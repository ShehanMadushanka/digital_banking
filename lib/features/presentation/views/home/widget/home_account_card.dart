import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_styling.dart';

class HomeAccountCard extends StatelessWidget {
  HomeAccountCard(
      {Key key,
      this.backgroundColor,
      this.fontColor,
      this.title,
      this.accountNumber,
      this.amount,
      this.isCDBAccount = true,
      this.isGridView = false,
      this.isSelected = false,
      this.isEmpty = false})
      : super(key: key);

  final Color backgroundColor;
  final Color fontColor;
  final String title;
  final String accountNumber;
  final String amount;
  final bool isEmpty;
  final bool isCDBAccount;
  final bool isGridView;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: isEmpty
          ? Container(
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Add Pay Option",
                      style: AppStyling.normal500Size16.copyWith(
                        color: AppColors.textDarkColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.add_outlined,
                    color: AppColors.darkAshColor,
                    size: 40,
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width * 0.65,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: backgroundColor ?? isCDBAccount
                    ? AppColors.whiteColor
                    : AppColors.darkGray,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.transparent),
                boxShadow: [
                  BoxShadow(
                    color: isGridView
                        ? const Color(0x66000000).withOpacity(.1)
                        : const Color(0x66000000),
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
                                  fontSize: !isGridView ? 16 : 12,
                                  color: fontColor ?? isCDBAccount
                                      ? AppColors.textDarkColor
                                      : AppColors.whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                accountNumber,
                                style: AppStyling.normal500Size10.copyWith(
                                  fontSize: !isGridView ? 10 : 8,
                                  color: fontColor ?? isCDBAccount
                                      ? AppColors.textDarkColor
                                      : AppColors.whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        if (isCDBAccount)
                          const SizedBox.shrink()
                        else
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
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.logo,
                          width: 50.w,
                          height: 17.h,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Account Balance",
                                style: AppStyling.normal300Size10.copyWith(
                                  fontSize: !isGridView ? 10 : 8,
                                  color: isCDBAccount
                                      ? AppColors.textDarkColor
                                      : AppColors.textLightColor,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "LKR ",
                                    style: AppStyling.normal700Size8.copyWith(
                                      fontSize: !isGridView ? 8 : 6,
                                      color: fontColor ?? isCDBAccount
                                          ? AppColors.textDarkColor
                                          : AppColors.whiteColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${amount.split(".")[0]}.",
                                        style: AppStyling.normal700Size16
                                            .copyWith(
                                                fontSize:
                                                    !isGridView ? 16 : 8,
                                                fontWeight: !isGridView
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                color: fontColor ??
                                                        isCDBAccount
                                                    ? AppColors.textDarkColor
                                                    : AppColors.whiteColor),
                                      ),
                                      TextSpan(
                                        text: amount.split(".")[1],
                                        style: AppStyling.normal300Size12
                                            .copyWith(
                                                fontSize:
                                                    !isGridView ? 12 : 6,
                                                fontWeight: !isGridView
                                                    ? FontWeight.w300
                                                    : FontWeight.w600,
                                                color: fontColor ??
                                                        isCDBAccount
                                                    ? AppColors.textDarkColor
                                                    : AppColors.whiteColor),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
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
