import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/requests/wallet_onboarding_data.dart';

const String _PUSH_TOKEN = 'push_token';
const String _AUTH_TOKEN = 'auth_token';
const String _ACCESS_TOKEN = 'access_token';
const String _REFRESH_TOKEN = 'refresh_token';
const String _APP_ID = 'app_id';
const String _INITIAL_LAUNCH_FLAG = 'initial_launch_flag';
const String appWalletOnBoardingData = "appWalletOnBoardingData";
const String appNewInstallKey = "newlyInstalled";
const String ghostId = 'ghost_id';
const String epicUserId = "epic_user_id";
const String appBiometricState = "app_biometric_state";
const String _BIOMETRIC_CODE = 'biometric_code';
const String username_key = 'username_key';
const String _prefLanguageState = "language_state";
const String _onboardingState = "onboarding_state";
const String _tokenExpiresIn = 'tokenExpiresIn';

class LocalDataSource {
  FlutterSecureStorage secureStorage;
  SharedPreferences prefs;

  LocalDataSource(
      {FlutterSecureStorage securePreferences,
      SharedPreferences sharedPreferences}) {
    secureStorage = securePreferences;
    prefs = sharedPreferences;
  }

  Future<bool> hasPushToken() async {
    return await secureStorage.containsKey(key: _PUSH_TOKEN);
  }

  Future<bool> isInitialLaunchDone() async {
    return await secureStorage.containsKey(key: _INITIAL_LAUNCH_FLAG);
  }

  void setPushToken(String token) {
    log('[App Store] Storing push token => $token');
    secureStorage.write(key: _PUSH_TOKEN, value: token);
  }

  void setInitialLaunch() {
    secureStorage.write(key: _INITIAL_LAUNCH_FLAG, value: _INITIAL_LAUNCH_FLAG);
  }

  Future<String> getPushToken() async {
    return await secureStorage.read(key: _PUSH_TOKEN);
  }

  void clearPushToken() {
    secureStorage.delete(key: _PUSH_TOKEN);
  }

  void setToken(String token) {
    secureStorage.write(key: _AUTH_TOKEN, value: token);
  }

  Future<String> getToken() async {
    return await secureStorage.read(key: _AUTH_TOKEN);
  }

  void clearToken() {
    secureStorage.delete(key: _AUTH_TOKEN);
  }

  Future<bool> hasAuthToken() async {
    if (secureStorage.containsKey(key: _AUTH_TOKEN) != null) {
      final bool token = (await secureStorage.read(key: _AUTH_TOKEN)).isEmpty;
      return !token;
    } else {
      return false;
    }
  }

  /// EPIC USER ID
  // -> Setter
  void setEpicUserId(String epicUserIdValue) {
    prefs.setString(epicUserId, epicUserIdValue);
  }

  // -> Getter
  String getEpicUserId() {
    return prefs.getString(epicUserId);
  }

  ///GHOST ID
  // -> Setter
  String setGhostId() {
    final uuid = const Uuid().v4();
    prefs.setString(ghostId, uuid);
    return uuid;
  }

  // -> Getter
  String getGhostId() {
    return prefs.getString(ghostId);
  }

  /// APP ID
  // -> Setter
  String setAppID() {
    final uuid = const Uuid().v4();
    prefs.setString(_APP_ID, uuid);
    return uuid;
  }

  // -> Getter
  String getAppID() {
    return prefs.getString(_APP_ID);
  }

  /// Language
  // -> Setter
  void setLanguageState() {
    prefs.setBool(_prefLanguageState, true);
  }

  // -> Getter
  bool getLanguageState() {
    return prefs.getBool(_prefLanguageState);
  }

  bool hasLanguageState() {
    return prefs.containsKey(_prefLanguageState);
  }

  /// Onboarding State
  // -> Setter
  void setOnboardingState() {
    prefs.setBool(_onboardingState, true);
  }

  // -> Getter
  bool getOnboardingState() {
    return prefs.getBool(_onboardingState);
  }

  bool hasOnboardingState() {
    return prefs.containsKey(_onboardingState);
  }

  /// Check if App is newly installed and clear data
  Future<void> checkIfAppIsNewInstalled() async {
    final bool containsKey = prefs.containsKey(appNewInstallKey);
    if (!containsKey) {
      // await removeAppWalletOnBoardingData();
      deleteAllDataInSecureStorage();
      await prefs.setString(appNewInstallKey, "1");
      // return true;
    }
  }

  /// Delete All Data
  void deleteAllDataInSecureStorage() {
    secureStorage.deleteAll();
  }

  /// APP ON BOARDING DATA
  // Remove Wallet On Boarding Data
  Future<void> removeAppWalletOnBoardingData() async {
    await secureStorage.delete(key: appWalletOnBoardingData);
  }

  // Get Wallet On Boarding Data
  Future<WalletOnBoardingData> getAppWalletOnBoardingData() async {
    try {
      final String data =
          await secureStorage.read(key: appWalletOnBoardingData);
      if (data == null) {
        return null;
      }
      return WalletOnBoardingData.fromJson(jsonDecode(data));
    } on Exception {
      rethrow;
    }
  }

  // Store Wallet On Boarding Data
  Future<bool> storeAppWalletOnBoardingData(
      WalletOnBoardingData walletOnBoardingData) async {
    try {
      final String data = jsonEncode(walletOnBoardingData.toJson());
      await secureStorage.write(key: appWalletOnBoardingData, value: data);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  void setBiometric(String code) {
    secureStorage.write(key: _BIOMETRIC_CODE, value: code);
  }

  Future<String> getBiometricCode() async {
    final bool hasBiometric =
        await secureStorage.containsKey(key: _BIOMETRIC_CODE);
    if (hasBiometric) {
      final String value = await secureStorage.read(key: _BIOMETRIC_CODE);
      return value;
    } else {
      return null;
    }
  }

  void setUserName(String username) {
    secureStorage.write(key: username_key, value: username);
  }

  Future<bool> hasUsername() async {
    final contain = await secureStorage.containsKey(key: username_key);
    return contain;
  }

  Future<String> getUsername() async {
    final usernameValue = await secureStorage.read(key: username_key);
    return usernameValue;
  }

  void setAccessToken(String token) {
    secureStorage.write(key: _ACCESS_TOKEN, value: token);
  }

  Future<String> getAccessToken() async {
    return secureStorage.read(key: _ACCESS_TOKEN);
  }

  void clearAccessToken() {
    secureStorage.delete(key: _ACCESS_TOKEN);
  }

  void setRefreshToken(String token) {
    secureStorage.write(key: _REFRESH_TOKEN, value: token);
  }

  Future<String> getRefreshToken() async {
    return secureStorage.read(key: _REFRESH_TOKEN);
  }

  void clearRefreshToken() {
    secureStorage.delete(key: _REFRESH_TOKEN);
  }

  void setTokenExpireTimeToken(int token) {
    prefs.setInt(_tokenExpiresIn, token);
  }

  Future<int> getTokenExpireTime() async {
    return prefs.getInt(_tokenExpiresIn);
  }
}
