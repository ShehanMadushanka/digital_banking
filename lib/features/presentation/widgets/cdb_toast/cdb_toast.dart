import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import 'cdb_toast_animation.dart';

/*
* Usage:
*ToastUtils.showCustomToast(context,"Your text.");
* */
class ToastUtils {
  static Timer toastTimer;
  // static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context, String message, ToastStatus status) {
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100.0,
        width: MediaQuery.of(context).size.width - 20,
        left: 10,
        child: SlideInToastMessageAnimation(Material(
          elevation: 10.0,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
            decoration: BoxDecoration(color: AppColors.whiteColor, boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.25),
                blurRadius: 8, // changes position of shadow
              ),
            ]),
            child: Align(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 35.w,
                    height: 35.w,
                    decoration: BoxDecoration(
                      color: status == ToastStatus.success ? AppColors.successGreenColor : AppColors.errorRedColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        status == ToastStatus.success ? Icons.check_rounded : Icons.close_rounded,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          status == ToastStatus.success ? AppString.success.localize(context) : AppString.failed.localize(context),
                          style: AppStyling.normal500Size16.copyWith(
                            color: AppColors.textDarkColor,
                          ),
                        ),
                        Text(
                          message,
                          style: AppStyling.normal400Size14.copyWith(
                            color: AppColors.grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    /// Two seconds later, remove Toast
    Future.delayed(const Duration(seconds: 3)).then((value) {
      overlayEntry.remove();
    });
  }
}

enum ToastStatus { success, fail }
