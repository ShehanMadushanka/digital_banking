import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

class NotificationEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 109),
              child: Image.asset(
                AppImages.emptyViewIcon,
                height: 62.6,
                width: 55.6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Text(
                AppString.noNotifications.localize(context),
                style: AppStyling.normal600Size16
                    .copyWith(color: AppColors.textDarkColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 77, right: 77),
              child: Text(
                AppString.noNotificationsDescription.localize(context),
                style: AppStyling.normal300Size13
                    .copyWith(color: AppColors.textTitleColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
