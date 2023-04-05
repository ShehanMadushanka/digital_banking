library epic_dart_encryptor;

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:cdb_mobile/core/encryption/common_utils.dart';
import 'package:cdb_mobile/core/encryption/exception/encryptor_exception.dart';
import 'package:cdb_mobile/core/encryption/rsa_key_helper.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/ecb.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

/// EPIC Dart Encryption Library.
class DartEncryptor {
  static PublicKey _publicKey;
  static PublicKey _serverPublicKey;
  static PrivateKey _privateKey;
  static Uint8List _encryptedPMK;
  static Uint8List _sessionKey;
  static Uint8List _xorPMK;
  static Uint8List _iv;
  static String _tc;
  static var _rsaKeyHelper;

  static const int sessionKeyEnc = 1;
  static const int deviceKeyEnc = 2;
  static const int sessionKeyDec = 3;
  static const int deviceKeyDec = 4;
  static const String securityAlgoPkcs7 = "AES/CBC/PKCS7";

  static String get publicKey => _rsaKeyHelper.encodePublicKeyToPem(_publicKey);

  static String get pmk {
    if (_xorPMK != null) {
      return HEX.encode(_xorPMK);
    }

    throw EncryptorException('[DART Encryptor] PMK is null');
  }

  static String get kcv {
    if (_sessionKey != null) {
      return CommonUtils.formatBytesAsHexString(_createKCV(_sessionKey));
    }

    throw EncryptorException('[DART Encryptor] Key Check Value is null');
  }

  static String get tc {
    if (_tc != '' || _tc != null) {
      return _tc;
    }

    throw EncryptorException('[DART Encryptor] Time is null');
  }

  static Uint8List get iv => _iv;

  DartEncryptor.init() {
    _rsaKeyHelper = RsaKeyHelper();
    _generateKeyPair();
  }

  void _generateKeyPair() {
    // Generate 2048 length RSAKey Params
    final keyParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12);

    final secureRandom = FortunaRandom();
    final random = math.Random.secure();

    final List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }

    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final rngParams = ParametersWithRandom(keyParams, secureRandom);
    final k = RSAKeyGenerator();
    k.init(rngParams);

    final _keyPair = k.generateKeyPair();

    _publicKey = _keyPair.publicKey;
    _privateKey = _keyPair.privateKey;
  }

  // Storing XOR value of PMK
  static void _storePMK(Uint8List decryptedPMK) {
    _xorPMK = CommonUtils.generateXOR(decryptedPMK, HEX.decode(XOR));
  }

  static bool compareKCV({@required String kcv, @required String pmk, @required String serverPublicKey}) {
    _serverPublicKey = _rsaKeyHelper.parsePublicKeyFromPem(serverPublicKey) as PublicKey;
    _encryptedPMK = HEX.decode(pmk);
    final decryptedPMK = _decryptPMK(_encryptedPMK);

    _storePMK(decryptedPMK);

    final String kvcHexString = CommonUtils.formatBytesAsHexString(_createKCV(decryptedPMK));

    if (kvcHexString == kcv) {
      return true;
    }

    return false;
  }

  static Uint8List _generateSessionKey(bool isEncrypt, String tc) {
    List<int> uk;

    if (isEncrypt) {
      _tc = _getTC();
      uk = HEX.decode(_tc.padRight(32, 'F'));
    } else {
      uk = HEX.decode(tc.padRight(32, 'F'));
    }

    final BlockCipher cipher = ECBBlockCipher(AESFastEngine());

    cipher.init(true, KeyParameter(CommonUtils.generateXOR(_xorPMK, HEX.decode(XOR))));

    final sessionKey = cipher.process(uk);

    return sessionKey;
  }

  static Uint8List _generateDeviceKey(String deviceID, int mode, String tc) {
    final sha = CommonUtils.getSHA(deviceID);
    log(sha);
    return _encryptDeviceId(HEX.decode(sha), mode, tc);
  }

  static Uint8List _encryptDeviceId(Uint8List deviceID, int mode, String tc) {
    List<int> uk;
    if (mode == deviceKeyDec) {
      uk = HEX.decode(tc.padRight(32, 'F'));
    } else {
      _tc = _getTC();
      uk = HEX.decode(_tc.padRight(32, 'F'));
    }

    final BlockCipher cipher = ECBBlockCipher(AESFastEngine());
    cipher.init(true, KeyParameter(CommonUtils.generateXOR(deviceID, HEX.decode(XOR))));
    final deviceKey = cipher.process(uk);

    return deviceKey;
  }

  static String encryptPacket({@required Uint8List data, @required int mode, @required String deviceId}) {
    if (mode == deviceKeyEnc) {
      _sessionKey = _generateDeviceKey(deviceId, mode, '');
    } else {
      _sessionKey = _generateSessionKey(true, '');
    }

    _iv = CommonUtils.generateRandomByteArray();

    final CipherParameters params = PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(_sessionKey), iv), null);

    final BlockCipher cipher = PaddedBlockCipher(securityAlgoPkcs7);
    cipher.init(true, params);
    final Uint8List encryptedPacket = cipher.process(data);

    return HEX.encode(utf8.encode(base64Encode(encryptedPacket)));
  }

  static String decryptPacket({@required String encryptedData, @required String keyInfo, @required int mode, @required String deviceID}) {
    final keyInfoArray = keyInfo.split('-');

    final tc = keyInfoArray[0];
    final kcv = keyInfoArray[1];
    final iv = keyInfoArray[2];
    Uint8List generatedKey;

    if (mode == deviceKeyDec) {
      generatedKey = _generateDeviceKey(deviceID, mode, tc);
    } else {
      generatedKey = _generateSessionKey(false, tc);
    }

    final _serverKCV = HEX.encode(_createKCV(generatedKey)).toUpperCase();

    log('[DART Encryptor - DEC] Generated KCV: $_serverKCV');

    if (_serverKCV == kcv) {
      return _decrypt(base64Decode(String.fromCharCodes(HEX.decode(encryptedData))), generatedKey, HEX.decode(iv));
    }

    throw EncryptorException('[DART Encryptor - DEC] Session key not match');
  }

  static String _decrypt(Uint8List data, Uint8List sessionKey, Uint8List iv) {
    final CipherParameters params = PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(sessionKey), iv), null);

    final BlockCipher cipher = PaddedBlockCipher(securityAlgoPkcs7);
    cipher.init(false, params);
    final Uint8List decryptedPacket = cipher.process(data);

    return const Utf8Decoder().convert(decryptedPacket);
  }

  static String _getTC() {
    return formatDate(DateTime.now(), [HH, nn, ss]);
  }

  static Uint8List _decryptPMK(Uint8List pmk) {
    final AsymmetricKeyParameter<RSAPrivateKey> keyParametersPrivate = PrivateKeyParameter(_privateKey);
    final AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic = PublicKeyParameter(_serverPublicKey);

    final cipher = RSAEngine()..init(false, keyParametersPrivate);
    final decryptedPMKFromPrivate = cipher.process(pmk);

    final cipher2 = RSAEngine()..init(false, keyParametersPublic);
    final decryptedFromServerPublic = cipher2.process(decryptedPMKFromPrivate);

    return decryptedFromServerPublic;
  }

  static Uint8List _createKCV(Uint8List key) {
    final Uint8List buffer = Uint8List(16);

    final BlockCipher cipher = ECBBlockCipher(AESFastEngine());
    cipher.init(true, KeyParameter(key));
    final Uint8List kcv = cipher.process(buffer);

    return kcv.sublist(0, 3);
  }
}
