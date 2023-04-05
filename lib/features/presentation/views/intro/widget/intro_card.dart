import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class IntroCard extends StatelessWidget {
  final String titleOne;
  final String titleTwo;
  final String descOne;
  final String descTwo;

  const IntroCard({this.titleOne, this.titleTwo, this.descOne, this.descTwo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF555454).withOpacity(0.19),
            spreadRadius: 5,
            blurRadius: 30,
            offset: const Offset(2, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 24.h, bottom: 24.h),
            child: Container(
              width: 2.w,
              height: 81.h,
              color: const Color(0xFFFF473A),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
            ),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.w, top: 30.h),
                    child: Container(
                      width: 180.w,
                      height: 24.h,
                      child: Row(
                        children: [
                          Text(
                            titleOne,
                            style: AppStyling.normal600Size20
                                .copyWith(color: AppColors.accentColor),
                          ),
                          Expanded(
                            child: Text(
                              //", $titleTwo",
                              titleTwo,
                              style: AppStyling.normal600Size20
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w, top: 10.h),
                    child: Container(
                      width: 180.w,
                      height: 36.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                descOne,
                                style: AppStyling.normal300Size15,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              descTwo,
                              style: AppStyling.normal300Size15,
                            ),
                          )),
                        ],
                      ),
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
