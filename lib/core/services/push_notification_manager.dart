import 'package:cdb_mobile/core/configurations/app_config.dart';
import 'package:cdb_mobile/features/data/datasources/local_data_source.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:huawei_push/huawei_push.dart';


class PushNotificationsManager {
  final LocalDataSource _appSharedData;
  FirebaseMessaging _firebaseMessaging;

  PushNotificationsManager(this._appSharedData) {
    if (kDeviceOS == DeviceOS.ANDROID) {
      _firebaseMessaging = FirebaseMessaging.instance;
      _notificationPermission();
    }
  }

  Future<void> _notificationPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<bool> getFCMToken() async {
    String _token = await _firebaseMessaging.getToken();
    if (_token != null && _token.isNotEmpty) {
      _appSharedData.setPushToken(_token);
    } else {
      getFCMToken();
    }

    return true;
  }

  Future<bool> getHCMToken() async {
    Push.getToken("");
    Push.getTokenStream.listen((token) {
      _appSharedData.setPushToken(token);
    }, onError: (error) {
      getHCMToken();
    });

    return true;
  }
}
