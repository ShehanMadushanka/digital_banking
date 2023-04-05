import 'dart:ui';

import 'package:cdb_mobile/core/permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../features/presentation/widgets/cdb_dialog.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_strings.dart';

class AppPermissionManager {
  static requestCameraPermission(BuildContext context, VoidCallback onGranted) async {
    final permissionValidator = EasyPermissionValidator(context: context, appName: kAppName, customDialog: AppPermissionDialog());
    final result = await permissionValidator.camera();
    if (result) onGranted();
  }

  static requestExternalStoragePermission(BuildContext context, VoidCallback onGranted) async {
    final permissionValidator = EasyPermissionValidator(context: context, appName: kAppName, customDialog: AppPermissionDialog());
    final result = await permissionValidator.storage();
    if (result) onGranted();
  }

  static requestGalleryPermission(BuildContext context, VoidCallback onGranted) async {
    final permissionValidator = EasyPermissionValidator(context: context, appName: kAppName, customDialog: AppPermissionDialog());
    final result = await permissionValidator.mediaLibrary();
    if (result) onGranted();
  }
}

class AppPermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CDBDialog(
      title: kAppName,
      body: Column(
        children: [
          Text(AppString.appPermissionRequest.localize(context)),
        ],
      ),
      negativeButtonText: AppString.cancel.localize(context),
      negativeButtonTap: () {},
      positiveButtonText: AppString.appNavigateSettings.localize(context),
      positiveButtonTap: () {
        openAppSettings();
      },
    );
  }
}
