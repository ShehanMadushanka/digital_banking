import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import '../../features/data/models/common/justpay_payload.dart';
import 'package:flutter/services.dart';

const String ADB_REQ_KEY = "2672ef947486257c71881b970411546803f35a4ed09833edf55ab2e8968684c0";
const String APP_HASH_REQ_KEY = "c8fe82764f3a63f8eb5cd8c11a272b313ef113880c8eb3b8714004719eb958c3";
const String ROOT_REQ_KEY = "cdec2bb0ae84adc926bac868fc193b34a8e40a0e2970c9cda11f6bf9124427ef";
const String EMU_REQ_KEY = "bcf8b716f48ac74e853995f0a59fbdfe7f261fa247784ba8fe19218a07ce9517";
const String ADB_RES_KEY = "c68622628700ae373e914ec0a7c527cb85dea7292e6cf7fffc8239e0f98e9b33";
const String ROOT_RES_KEY = "18417d51b0f0917e79ee900abfeb4aa59c51bd65b456cf23e3b607cd677eb8c9";
const String EMU_RES_KEY = "4e0966ea2be68e9bee5987918154ecb5c5574536605e8314162d42bab08ce494";
const String LQR_REQ_KEY = "D995DA23505A798C93DA3E2E7F2F1611BB3F4DF1110612705F60C17DFD2759FF";
const String JAIL_KEY = "messedUp";
const String JP_DEVICE_ID = "e5c04fba45d532efde8556112f7348af05390329006e25d2dfc0be958d96b764";
const String JP_IS_IDENTITY_EXISTS = "e9743512bb66c5d4c51d6708900ab41d281e8d2c25418748dbcf90c34871a39e";
const String JP_REVOKE = "e481371a5ccdde8ae32b83f3a1a8f189bb21da39e374b7b9ab6a51fbceaa1c47";
const String JP_CREATE_IDENTITY = "b7b56e183578a1ffb909354c3a57679196af73a93da06ace2a6c4597be670fc5";
const String JP_SIGN_TERMS = "2956c01f62d011b2dd41b33ac66d25a671ba99bb7af77306c9cd9eaf737f44ee";

// ignore: avoid_classes_with_only_static_members
class PlatformServices {
  static const platform = MethodChannel('cdb_secure_method_channel');

  static Future<bool> get getADBStatus async {
    final res = await platform.invokeMethod(ADB_REQ_KEY);
    final Map<String, bool> map = _decoder(res.keys.first as String, res.values.first as String);
    if (map.keys.first == ADB_RES_KEY) {
      return map.values.first;
    } else {
      return false;
    }
  }

  static Future<String> get signature async {
    if (Platform.isAndroid) {
      return await platform.invokeMethod(APP_HASH_REQ_KEY);
    } else {
      return "12345";
    }
  }

  static Future<bool> get isRooted async {
    final res = await platform.invokeMethod(ROOT_REQ_KEY);
    final Map<String, bool> map = _decoder(res.keys.first as String, res.values.first as String);
    if (map.keys.first == ROOT_RES_KEY) {
      return map.values.first;
    } else {
      return false;
    }
  }

  static Future<bool> get isJailBroken async {
    final res = await platform.invokeMethod(JAIL_KEY);
    return res as bool;
  }

  static Future<bool> get isRealDevice async {
    final res = await platform.invokeMethod(EMU_REQ_KEY);
    final Map<String, bool> map = _decoder(res.keys.first as String, res.values.first as String);
    if (map.keys.first == EMU_RES_KEY) {
      return map.values.first;
    } else {
      return false;
    }
  }

  static Map<String, bool> _decoder(String key, String value) {
    final String decoded = utf8.decode(base64Decode(utf8.decode(base64Decode(key))));
    final resArr = decoded.split(value);
    final Map<String, bool> result = HashMap();
    result.putIfAbsent(resArr.join(""), () => resArr.length.isOdd);
    return result;
  }

  static Future<String> validateLankaQR(String qrString) async {
    try {
      final String result =
      await platform.invokeMethod(LQR_REQ_KEY, {"qrString": qrString});
      return result;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  static Future<String> getJustPayDeviceId() async {
    try {
      final String result =
      await platform.invokeMethod(JP_DEVICE_ID);
      return result;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  static Future<bool> isJustPayIdentityExists() async {
    try {
      final bool result =
      await platform.invokeMethod(JP_IS_IDENTITY_EXISTS);
      return result;
    } on PlatformException catch (e) {
      return false;
    }
  }
  static Future<void> justPayRevoke() async {
    try {
      await platform.invokeMethod(JP_REVOKE);
      return true;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<JustPayPayload> justPayCreateIdentity(String challenge) async {
    try {
      final String result =
      await platform.invokeMethod(JP_CREATE_IDENTITY, {"challenge": challenge});
      return JustPayPayload.fromRawJson(result);
    } on PlatformException catch (e) {
      return JustPayPayload(isSuccess: false, data: e.message);
    }
  }

  static Future<JustPayPayload> justPaySignedTerms(String terms) async {
    try {
      final String result =
      await platform.invokeMethod(JP_SIGN_TERMS, {"terms": terms});
      return JustPayPayload.fromRawJson(result);
    } on PlatformException catch (e) {
      return JustPayPayload(isSuccess: false, data: e.message);
    }
  }
}
