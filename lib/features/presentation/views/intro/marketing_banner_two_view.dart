
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import 'widget/intro_card.dart';

class BannerTwo extends StatelessWidget {
  const BannerTwo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.bannerTwoBgTwo,
            ),
            fit: BoxFit.contain,
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: AppColorsWithOpacity().bannerGradientWithOpacity),
          child: Stack(
            children: [
              Positioned(
                height: 129.h,
                width: 220.w,
                left: 20.w,
                bottom: 535.h,
                child: IntroCard(
                  titleOne: AppString.qr.localize(context),
                  titleTwo: AppString.payments.localize(context),
                  descOne: AppString.youCanJustScanAndPay.localize(context),
                  descTwo: AppString.withCdbIpay.localize(context),
                ),
              ),
              Positioned(
                bottom: 175.h,
                left: 13.5.w,
                child: Container(
                  child: Image.asset(
                    AppImages.bannerTwoQr,
                    width: 97.w,
                    height: 97.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
