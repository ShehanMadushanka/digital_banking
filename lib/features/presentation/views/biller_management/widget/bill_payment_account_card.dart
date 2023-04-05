import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_styling.dart';

class BillPaymentAccountCard extends StatelessWidget {
  const BillPaymentAccountCard(
      {Key key,
        this.backgroundColor,
        this.fontColor,
        this.title,
        this.accountNumber,
        this.amount,
        this.onTap,
        this.isEmpty = false})
      : super(key: key);

  final Color backgroundColor;
  final Color fontColor;
  final String title;
  final String accountNumber;
  final String amount;
  final Function onTap;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.darkGray,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyling.normal500Size16.copyWith(
                            color: fontColor ?? AppColors.whiteColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          accountNumber,
                          style: AppStyling.normal500Size10.copyWith(
                            color: fontColor ?? AppColors.whiteColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 53.w,
                    height: 16.h,
                    decoration: const BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          4,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "PRIMARY",
                        style: AppStyling.normal500Size8.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, bottom: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Account Balance",
                      style: AppStyling.normal300Size10.copyWith(
                        color: AppColors.textLightColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        AppImages.logo,
                        width: 50.w,
                        height: 17.h,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "LKR ",
                            style: AppStyling.normal700Size8.copyWith(
                              color: fontColor ?? AppColors.whiteColor,
                            ),
                            children: [
                              TextSpan(
                                text: "${amount.split(".")[0]}.",
                                style: AppStyling.normal700Size16
                                    .copyWith(
                                    color: fontColor ??
                                        AppColors.whiteColor),
                              ),
                              TextSpan(
                                text: amount.split(".")[1],
                                style: AppStyling.normal300Size12
                                    .copyWith(
                                    color: fontColor ??
                                        AppColors.whiteColor),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
