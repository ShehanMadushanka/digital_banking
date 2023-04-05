import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class HomeRecentTransactionCard extends StatelessWidget {
  const HomeRecentTransactionCard(
      {Key key,
      @required this.title,
      @required this.paymentType,
      @required this.time,
      @required this.amount,
      @required this.imageUrl})
      : super(key: key);

  final String title;
  final String paymentType;
  final String time;
  final String amount;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.darkAshColor),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 6, // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      imageUrl,
                      width: 60.w,
                      height: 55.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppStyling.normal300Size13.copyWith(
                              color: AppColors.textDarkColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            paymentType,
                            style: AppStyling.normal500Size10.copyWith(
                              color: AppColors.textDarkColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            time,
                            style: AppStyling.normal300Size12.copyWith(
                              color: AppColors.textLightColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Rs ',
                  style: AppStyling.normal300Size10.copyWith(
                    color: AppColors.textDarkColor,
                  ),
                ),
                TextSpan(
                  text: amount,
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
