import 'package:cdb_mobile/features/presentation/views/notifications/transaction_offer_notifications_view.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

import 'notification_component_image.dart';

class NotificationComponent extends StatefulWidget {
  final NotificationData data;
  final VoidCallback onLongPress;
  final VoidCallback onPressed;
  final String imageName;
  final String readImageName;

  const NotificationComponent(
      {this.data,
      this.onLongPress,
      this.onPressed,
      this.imageName,
      this.readImageName});

  @override
  _NotificationComponentState createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.onLongPress,
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: widget.data.isSelected
              ? Border.all(width: 0.5, color: AppColors.accentColor)
              : widget.data.isRead
                  ? Border.all(width: 0.5, color: AppColors.darkAshColor)
                  : Border.all(width: 0.5, color: AppColors.blackColor),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (widget.data.isSelected)
                      SelectingNotificationComponentImage(
                        imgName: AppImages.selectedNotificationIc,
                      )
                    else
                      NotificationComponentImage(
                        imgName: widget.imageName,
                        readImgName: widget.readImageName,
                        isRead: widget.data.isRead,
                      ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.data.title,
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            const SizedBox(
                              width: 110,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                widget.data.date,
                                style: AppStyling.normal300Size12
                                    .copyWith(color: AppColors.textLightColor),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 28,
                          width: 196,
                          child: Text(
                            widget.data.description,
                            style: AppStyling.normal300Size12
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
