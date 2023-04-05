import 'package:cdb_mobile/features/domain/entities/response/saved_biller_entity.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';

class NotificationBottomAppBar extends StatefulWidget {
  final VoidCallback onTapSelectAll;
  final VoidCallback onTapMarkAsRead;
  final VoidCallback onTapDelete;
  final int selectedIndex;
  final IconData iconOne;
  final IconData iconTwo;
  final IconData iconThree;
  final String iconNameOne;
  final String iconNameTwo;
  final String iconNameThree;
  final SavedBillerEntity savedBillerEntity;
  final ButtonStatus status;
  final GestureLongPressCallback onLongPress;
  final bool inkWell;

  NotificationBottomAppBar(
      {this.onTapSelectAll,
      this.onTapMarkAsRead,
      this.onTapDelete,
      this.selectedIndex,
      this.iconOne,
      this.iconTwo,
      this.iconThree,
      this.iconNameOne,
      this.iconNameTwo,
      this.iconNameThree,
      this.savedBillerEntity,
      this.status,
      this.onLongPress,
      this.inkWell});

  @override
  _NotificationBottomAppBarState createState() =>
      _NotificationBottomAppBarState();
}

class _NotificationBottomAppBarState extends State<NotificationBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.separationLinesColor,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
            child: InkWell(
              onTap: AppConstants.Notification_selected_view
                  ? widget.onTapSelectAll
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.iconOne,
                    color: AppConstants.Notification_selected_view
                        ? AppColors.grayColor
                        : AppColors.disableGray,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.iconNameOne,
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppConstants.Notification_selected_view
                          ? AppColors.textTitleColor
                          : AppColors.disableGray,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
            child: InkWell(
              onTap: AppConstants.Notification_selected_view
                  ? widget.onTapMarkAsRead
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 20,
                      child: Icon(
                        widget.iconTwo,
                        color: AppConstants.Notification_selected_view
                            ? AppColors.grayColor
                            : AppColors.disableGray,
                      )),
                  const SizedBox(height: 3),
                  Text(
                    widget.iconNameTwo,
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppConstants.Notification_selected_view
                          ? AppColors.textTitleColor
                          : AppColors.disableGray,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
            child: InkWell(
              onTap: AppConstants.Notification_selected_view
                  ? widget.onTapDelete
                  : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    child: Icon(
                      widget.iconThree,
                      color: AppConstants.Notification_selected_view
                          ? AppColors.grayColor
                          : AppColors.disableGray,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.iconNameThree,
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppConstants.Notification_selected_view
                          ? AppColors.textTitleColor
                          : AppColors.disableGray,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
