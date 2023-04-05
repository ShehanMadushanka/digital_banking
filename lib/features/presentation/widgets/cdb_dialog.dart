import 'dart:ui';

import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CDBDialog extends StatelessWidget {
  const CDBDialog({
    Key key,
    this.alertImagePath = AppImages.alertIcon,
    this.title,
    this.body,
    this.isTwoButton = true,
    this.negativeButtonText,
    this.positiveButtonText,
    this.negativeButtonTextColor = AppColors.grayColor,
    this.positiveButtonTextColor = AppColors.accentColor,
    this.negativeButtonGradient = AppColors.greyGradient,
    this.positiveButtonGradient = AppColors.outlineGradient,
    this.negativeButtonTap,
    this.positiveButtonTap,
    this.isPng = false,
  }) : super(key: key);

  final String alertImagePath;
  final String title;
  final Widget body;
  final bool isTwoButton;
  final String negativeButtonText;
  final String positiveButtonText;
  final Color negativeButtonTextColor;
  final Color positiveButtonTextColor;
  final Gradient negativeButtonGradient;
  final Gradient positiveButtonGradient;
  final Function negativeButtonTap;
  final Function positiveButtonTap;
  final bool isPng;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          alignment: FractionalOffset.center,
          padding: EdgeInsets.all(20.w),
          child: Material(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 32.h),
                      child: Center(
                        child: isPng
                            ? Image.asset(AppImages.cdbIPayLogo,
                                width: 153, height: 52)
                            : SvgPicture.asset(
                                alertImagePath,
                                width: 55.w,
                                height: 63.h,
                              ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 32.w, right: 32.w, top: 31.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? "",
                            style: AppStyling.normal600Size16
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          body,
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: isTwoButton
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            children: [
                              if (isTwoButton)
                                Column(
                                  children: [
                                    CDBBorderGradientButton(
                                      onTap: () {
                                        Navigator.pop(context);
                                        if (negativeButtonTap != null) {
                                          negativeButtonTap();
                                        }
                                      },
                                      width: isTwoButton
                                          ? (MediaQuery.of(context).size.width -
                                                  (64.w + 40.w + 15.w)) /
                                              2
                                          : null,
                                      gradient: negativeButtonGradient,
                                      child: Padding(
                                        padding: isTwoButton
                                            ? const EdgeInsets.all(0)
                                            : EdgeInsets.all(10.w),
                                        child: Center(
                                          child: Text(
                                            negativeButtonText ?? "",
                                            style: AppStyling.normal600Size16
                                                .copyWith(
                                              color: negativeButtonTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: isTwoButton ? 15.w : 0,
                                    ),
                                  ],
                                )
                              else
                                const SizedBox.shrink(),
                              CDBBorderGradientButton(
                                width: (MediaQuery.of(context).size.width -
                                        (64.w + 40.w + 15.w)) /
                                    2,
                                gradient: positiveButtonGradient,
                                onTap: () {
                                  Navigator.pop(context);
                                  if (positiveButtonTap != null) {
                                    positiveButtonTap();
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    positiveButtonText ?? "",
                                    textAlign: TextAlign.center,
                                    style: AppStyling.normal600Size16.copyWith(
                                      color: positiveButtonTextColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
