import 'package:cdb_mobile/core/configurations/app_config.dart';
import 'package:cdb_mobile/core/services/push_notification_manager.dart';
import 'package:cdb_mobile/utils/enums.dart';

class CloudMessagingServices {
  final PushNotificationsManager _pushNotificationsManager;

  CloudMessagingServices(this._pushNotificationsManager);

  Future<bool> capturePushToken() {
    if (kDeviceOS == DeviceOS.ANDROID) {
      return _pushNotificationsManager.getFCMToken();
    } else {
      return _pushNotificationsManager.getHCMToken();
    }
  }
}
