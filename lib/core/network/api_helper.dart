import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cdb_mobile/features/data/models/responses/refresh_token_response.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hex/hex.dart';
import 'package:http_certificate_pinning/certificate_pinning_interceptor.dart';

import '../../error/exceptions.dart';
import '../../error/messages.dart';
import '../../features/data/datasources/local_data_source.dart';
import '../../features/data/models/common/base_api_handler.dart';
import '../../features/data/models/common/base_request.dart';
import '../../features/data/models/responses/error_response_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_sync_data.dart';
import '../../utils/device_data.dart';
import '../../utils/strings.dart';
import '../configurations/app_config.dart';
import '../encryption/encryptor/epic_dart_encryptor.dart';
import 'certificates.dart';
import 'network_config.dart';

class APIHelper {
  final Dio dio;
  final LocalDataSource _localDataSource;
  final AppSyncData appSyncData;
  var _token;
  String deviceId;
  String request;
  final DeviceData deviceData;

  APIHelper(
      this._localDataSource, {
        @required this.dio,
        @required this.deviceData,
        @required this.appSyncData,
      }) {
    _initApiClient();
  }

  Future<void> _initApiClient() async {
    ///TODO: DIO Certificate Issue REMOVE IN PRODUCTION MODE
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    final logInterceptor = LogInterceptor()
      ..responseHeader = true
      ..requestHeader = true;

    // deviceId = await FlutterUdid.consistentUdid;

    final BaseOptions options = BaseOptions(
      connectTimeout: kConnectionTimeout,
      receiveTimeout: kReceiveTimeout,
      baseUrl: NetworkConfig.getNetworkUrl(),
      contentType: 'application/json',
      headers: {
        // 'device_id': deviceId,
        'x-api-key': NetworkConfig.getToken(),
      },
    );

    final _tokenInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (AppConstants.IS_USER_LOGGED) {
          dio.interceptors.requestLock.lock();
          dio.interceptors.responseLock.lock();

          // CHECK IF REFRESH TOKEN IS EXPIRED
          if (DateTime.now().isAfter(AppConstants.TOKEN_EXPIRE_TIME) || DateTime.now().isAtSameMomentAs(AppConstants.TOKEN_EXPIRE_TIME)) {
            // REMOVE TOKENS IN STORAGE
            _localDataSource.clearAccessToken();

            final _tokenResponse = await _getRefreshToken();
            final _tokenData = RefreshTokenResponse.fromJson(_tokenResponse);

            _localDataSource.setAccessToken(_tokenData.accessToken);
            _localDataSource.setRefreshToken(_tokenData.refreshToken);
            AppConstants.TOKEN_EXPIRE_TIME =
                DateTime.now().add(Duration(seconds: _tokenData.expiresIn));

            final String _accessToken = await _localDataSource.getAccessToken();

            if (_accessToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $_accessToken';
            }
          } else {
            final String _accessToken = await _localDataSource.getAccessToken();

            if (_accessToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $_accessToken';
            }
          }

          dio.interceptors.requestLock.unlock();
          dio.interceptors.responseLock.unlock();
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError dioError, handler) async {
        return handler.next(dioError);
      },
    );

    dio
      ..options = options
      ..interceptors.add(_tokenInterceptor)
      ..interceptors.add(logInterceptor);

    if (kIsSSLAvailable) {
      dio.interceptors
          .add(CertificatePinningInterceptor(SSLCert.getCertificates()));
    }
  }

  /// DIO GET REFRESH TOKEN REQUEST
  /// @Param [url]
  /// @Param [body]
  /// @Param [headers]
  Future<dynamic> _getRefreshToken() async {
    try {

      final _refreshTokenDio = Dio();

      final _auth =
          'Basic ${base64Encode(utf8.encode('$basicAuthUsername:$basicAuthPassword'))}';

      (_refreshTokenDio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      final BaseOptions _options = BaseOptions(
        connectTimeout: kConnectionTimeout,
        receiveTimeout: kReceiveTimeout,
        baseUrl: NetworkConfig.getNetworkUrl(),
        contentType: 'application/json',
        headers: {
          'Authorization': _auth,
          'x-api-key': NetworkConfig.getToken(),
        },
      );

      final _logInterceptor = LogInterceptor()
        ..responseHeader = true
        ..requestHeader = true;

      _refreshTokenDio.options = _options;
      _refreshTokenDio.interceptors.add(_logInterceptor);


      final response = await _refreshTokenDio.post('oauth/token', queryParameters: {
        'refresh_token': await _localDataSource.getRefreshToken(),
        'grant_type': 'refresh_token'
      });
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> get(String url) async {
    try {
      final response = await dio.get(NetworkConfig.getNetworkUrl() + url);

      if (kIsPacketEncryptionAvailable) {
        final BaseAPIHandler exchangeResponse =
        BaseAPIHandler.fromJson(response.data);

        Map<String, dynamic> kxMap;
        try {
          kxMap = jsonDecode(DartEncryptor.decryptPacket(
              encryptedData: exchangeResponse.data,
              keyInfo: exchangeResponse.keyInfo,
              mode: null,
              deviceID: deviceId));
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        _printDecodedData(kxMap);
        return kxMap;
      } else {
        _printDecodedData(response.data);
        return response.data;
      }
    } on DioError catch (e) {
      log('[API Helper - GET] Connection Exception => ${e.message}');

      if (e.response != null) {
        final int statusCode = e.response.statusCode;

        Map<String, dynamic> kxMap;

        if (kIsPacketEncryptionAvailable) {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: null,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        }

        if (statusCode < 200 || statusCode > 400) {
          switch (statusCode) {
            case 401:
              throw UnAuthorizedException(ErrorResponseModel.fromJson(
                  kIsPacketEncryptionAvailable ? kxMap : e.response.data));
            case 403:
              throw UnAuthorizedException(ErrorResponseModel.fromJson(
                  kIsPacketEncryptionAvailable ? kxMap : e.response.data));
            case 404:
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            case 500:
            default:
              throw DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response.statusCode.toString(),
                      errorDescription: e.response.statusMessage));
          }
        }
      } else {
        throw ServerException(ErrorResponseModel(
            errorDescription: ErrorMessages.errorSomethingWentWrong));
      }
    }
  }

  Future<dynamic> post(String url,
      {Map headers,
        body,
        encoding,
        isKeyExchangeRequest = false,
        HttpMethods httpMethod = HttpMethods.POST}) async {
    assert(body != null);

    try {
      if (kIsPacketEncryptionAvailable) {
        try {
          if (isKeyExchangeRequest) {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  deviceId: deviceId,
                  mode: DartEncryptor.deviceKeyEnc);
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  mode: DartEncryptor.sessionKeyEnc,
                  deviceId: '');
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        final BaseAPIHandler baseAPIHandler = BaseAPIHandler(
            data: request,
            keyInfo:
            '${DartEncryptor.tc}-${DartEncryptor.kcv}-${HEX.encode(DartEncryptor.iv)}');

        final response = httpMethod == HttpMethods.POST
            ? await dio.post(url,
            data: baseAPIHandler.toJson(),
            options: Options(headers: headers))
            : await dio.put(url,
            data: baseAPIHandler.toJson(),
            options: Options(headers: headers));

        Map<String, dynamic> kxMap;
        try {
          if (isKeyExchangeRequest) {
            final BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: DartEncryptor.deviceKeyDec,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            final BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: null,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        if (response.headers["token"] != null) {
          _token = response.headers["token"][0];
        }

        _printDecodedData(kxMap);
        return kxMap;
      } else {
        final Map<String, dynamic> bodyData =
        await _generateBaseRequestData(body);

        log('[API Helper - POST] Request Body => ${bodyData.toString()}');

        final response = httpMethod == HttpMethods.POST
            ? await dio.post(url,
            data: bodyData, options: Options(headers: headers))
            : await dio.put(url,
            data: bodyData, options: Options(headers: headers));
        if (response.headers["token"] != null) {
          _token = response.headers["token"][0];
        }

        if (response.data == "") {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        } else {
          _printDecodedData(response.data);
          return response.data;
        }
      }
    } on DioError catch (e) {
      log('[API Helper - POST] Connection Exception => ${e.message}');
      Map<String, dynamic> kxMap;

      if (kIsPacketEncryptionAvailable) {
        if (isKeyExchangeRequest) {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: DartEncryptor.deviceKeyDec,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        } else {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: null,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        }
      }

      if (e.response != null) {
        final int statusCode = e.response.statusCode;

        if (statusCode < 200 || statusCode >= 400) {
          if (statusCode >= 400 && statusCode <= 499) {
            if (e.response.data != null) {
              log('[API Helper - POST] Connection Exception => ${e.response.data}');
              if (statusCode == 401) {
                throw UnAuthorizedException(ErrorResponseModel.fromJson(
                    kIsPacketEncryptionAvailable ? kxMap : e.response.data));
              }
              throw ServerException(ErrorResponseModel(
                  errorCode: e.response.data["errorCode"]?? 404,
                  errorDescription: e.response.data["errorDescription"]));
            } else {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            if (e.response.data != null) {
              throw DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response.statusCode.toString(),
                      errorDescription: e.response.statusMessage));
            } else {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } else if (e.response.statusCode == 307 ||
            e.response.statusCode == 308) {
          return e.response.data;
        } else if (e.response.statusCode == 806) {
          return ErrorMessages.errorMessageAlreadyExistingNIC;
        } else {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }
      } else {
        throw ServerException(ErrorResponseModel(
            errorDescription: ErrorMessages.errorSomethingWentWrong));
      }
    }
  }

  Future<Map<String, dynamic>> _generateBaseRequestData(
      Map<String, dynamic> body) async {
    final _deviceInfo = await deviceData.getDeviceData();

    final _deviceInfoString = jsonEncode(_deviceInfo);

    final BaseRequest baseRequest = BaseRequest();
    // App Sync Data
    baseRequest.appId = appSyncData.getAppId();
    baseRequest.appTransId = appSyncData.appTransId;
    baseRequest.epicTransId = appSyncData.epicTransId;
    baseRequest.ghostId = appSyncData.getGhostId();
    baseRequest.epicUserId = appSyncData.getEpicUserId();

    // App Constant Data
    baseRequest.appMaxTimeout = kAppMaxTimeout;
    baseRequest.appReferenceNumber = kReferenceNumber;
    baseRequest.deviceChannel = kDeviceChannel;
    baseRequest.messageVersion = kMessageVersion;

    //App Device Info
    baseRequest.deviceInfo = _deviceInfoString.toBase64();

    body.addAll(baseRequest.toJson());

    return body;
  }

  void _printDecodedData(Map<String, dynamic> map) {
    try {
      log("[API Helper] ${json.encode(map)}\n\n");
    } catch (e) {
      log("[API Helper] ${e.toString()}\n\n");
    }
  }

  Future<dynamic> delete(String url,
      {Map headers,
        body,
        encoding,
        isKeyExchangeRequest = false,
        HttpMethods httpMethod = HttpMethods.DELETE}) async {
    assert(body != null);

    try {
      if (kIsPacketEncryptionAvailable) {
        try {
          if (isKeyExchangeRequest) {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  deviceId: deviceId,
                  mode: DartEncryptor.deviceKeyEnc);
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  mode: DartEncryptor.sessionKeyEnc,
                  deviceId: '');
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        final BaseAPIHandler baseAPIHandler = BaseAPIHandler(
            data: request,
            keyInfo:
            '${DartEncryptor.tc}-${DartEncryptor.kcv}-${HEX.encode(DartEncryptor.iv)}');

        final response = await dio.delete(url,
            data: baseAPIHandler.toJson(), options: Options(headers: headers));

        Map<String, dynamic> kxMap;
        try {
          if (isKeyExchangeRequest) {
            final BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: DartEncryptor.deviceKeyDec,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            final BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: null,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        if (response.headers["token"] != null) {
          _token = response.headers["token"][0];
        }

        _printDecodedData(kxMap);
        return kxMap;
      } else {
        final Map<String, dynamic> bodyData =
        await _generateBaseRequestData(body);

        log('[API Helper - DELETE] Request Body => ${bodyData.toString()}');

        final response = await dio.delete(url,
            data: bodyData, options: Options(headers: headers));
        if (response.headers["token"] != null) {
          _token = response.headers["token"][0];
        }

        if (response.data == "") {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        } else {
          _printDecodedData(response.data);
          return response.data;
        }
      }
    } on DioError catch (e) {
      log('[API Helper - DELETE] Connection Exception => ${e.message}');
      Map<String, dynamic> kxMap;

      if (kIsPacketEncryptionAvailable) {
        if (isKeyExchangeRequest) {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: DartEncryptor.deviceKeyDec,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        } else {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: null,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        }
      }

      if (e.response != null) {
        final int statusCode = e.response.statusCode;

        if (statusCode < 200 || statusCode >= 400) {
          if (statusCode >= 400 && statusCode <= 499) {
            if (e.response.data != null) {
              log('[API Helper - DELETE] Connection Exception => ${e.response.data}');
              throw ServerException(ErrorResponseModel(
                  errorCode: e.response.data["errorCode"],
                  errorDescription: e.response.data["errorDescription"]));
            } else {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            if (e.response.data != null) {
              throw DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response.statusCode.toString(),
                      errorDescription: e.response.statusMessage));
            } else {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } else {
          if (e.response.statusCode == 307 || e.response.statusCode == 308) {
            return e.response.data;
          }
        }
      } else {
        throw ServerException(ErrorResponseModel(
            errorDescription: ErrorMessages.errorSomethingWentWrong));
      }
    }
  }

  Future<dynamic> put(String url,
      {Map headers,
        body,
        encoding,
        isKeyExchangeRequest = false,
        HttpMethods httpMethod = HttpMethods.PUT}) async {
    assert(body != null);

    try {
      if (kIsPacketEncryptionAvailable) {
        try {
          if (isKeyExchangeRequest) {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  deviceId: deviceId,
                  mode: DartEncryptor.deviceKeyEnc);
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            try {
              request = DartEncryptor.encryptPacket(
                  data: utf8.encode(jsonEncode(body)),
                  mode: DartEncryptor.sessionKeyEnc,
                  deviceId: '');
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        final BaseAPIHandler baseAPIHandler = BaseAPIHandler(
            data: request,
            keyInfo:
            '${DartEncryptor.tc}-${DartEncryptor.kcv}-${HEX.encode(DartEncryptor.iv)}');

        final response = await dio.put(url,
            data: baseAPIHandler.toJson(), options: Options(headers: headers));

        Map<String, dynamic> kxMap;
        try {
          if (isKeyExchangeRequest) {
            final BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: DartEncryptor.deviceKeyDec,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            final BaseAPIHandler exchangeResponse =
            BaseAPIHandler.fromJson(response.data);
            try {
              kxMap = jsonDecode(DartEncryptor.decryptPacket(
                  encryptedData: exchangeResponse.data,
                  keyInfo: exchangeResponse.keyInfo,
                  mode: null,
                  deviceID: deviceId));
            } catch (e) {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } on Exception {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        }

        if (response.headers["token"] != null) {
          _token = response.headers["token"][0];
        }

        _printDecodedData(kxMap);
        return kxMap;
      } else {
        final Map<String, dynamic> bodyData =
        await _generateBaseRequestData(body);

        log('[API Helper - PUT] Request Body => ${bodyData.toString()}');

        final response = await dio.put(url,
            data: bodyData, options: Options(headers: headers));
        if (response.headers["token"] != null) {
          _token = response.headers["token"][0];
        }

        if (response.data == "") {
          throw ServerException(ErrorResponseModel(
              errorDescription: ErrorMessages.errorSomethingWentWrong));
        } else {
          _printDecodedData(response.data);
          return response.data;
        }
      }
    } on DioError catch (e) {
      log('[API Helper - PUT] Connection Exception => ${e.message}');
      Map<String, dynamic> kxMap;

      if (kIsPacketEncryptionAvailable) {
        if (isKeyExchangeRequest) {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: DartEncryptor.deviceKeyDec,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        } else {
          final BaseAPIHandler exchangeResponse =
          BaseAPIHandler.fromJson(e.response.data);
          try {
            kxMap = jsonDecode(DartEncryptor.decryptPacket(
                encryptedData: exchangeResponse.data,
                keyInfo: exchangeResponse.keyInfo,
                mode: null,
                deviceID: deviceId));
          } catch (e) {
            throw ServerException(ErrorResponseModel(
                errorDescription: ErrorMessages.errorSomethingWentWrong));
          }
        }
      }

      if (e.response != null) {
        final int statusCode = e.response.statusCode;

        if (statusCode < 200 || statusCode >= 400) {
          if (statusCode >= 400 && statusCode <= 499) {
            if (e.response.data != null) {
              log('[API Helper - PUT] Connection Exception => ${e.response.data}');
              throw ServerException(ErrorResponseModel(
                  errorCode: e.response.data["errorCode"],
                  errorDescription: e.response.data["errorDescription"]));
            } else {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          } else {
            if (e.response.data != null) {
              throw DioException(
                  errorResponseModel: ErrorResponseModel(
                      errorCode: e.response.statusCode.toString(),
                      errorDescription: e.response.statusMessage));
            } else {
              throw ServerException(ErrorResponseModel(
                  errorDescription: ErrorMessages.errorSomethingWentWrong));
            }
          }
        } else {
          if (e.response.statusCode == 307 || e.response.statusCode == 308) {
            return e.response.data;
          }
        }
      } else {
        throw ServerException(ErrorResponseModel(
            errorDescription: ErrorMessages.errorSomethingWentWrong));
      }
    }
  }
}
