import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
      // ignore: empty_catches
    } on PlatformException {
      return isAvailable;
    }

    return isAvailable;
  }

  Future<BiometricType> getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
      return listOfBiometrics[0];
    } on PlatformException {
      return null;
    }
  }

  Future<bool> authenticateUser() async {
    const iosStrings = IOSAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set-up TouchID or FaceID on your device.',
      lockOut: 'Please re enable your TouchID or FaceID',
    );

    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        biometricOnly: true,
        localizedReason: "Touch your fingerprint scanner",
        androidAuthStrings: const AndroidAuthMessages(
          cancelButton: "Cancel",
          signInTitle: 'CDB iPay',
        ),
        iOSAuthStrings: iosStrings,
        useErrorDialogs: true,
        stickyAuth: true,
        sensitiveTransaction: true,
      );
    } on PlatformException {
      return isAuthenticated;
    }

    return isAuthenticated;
  }
}
