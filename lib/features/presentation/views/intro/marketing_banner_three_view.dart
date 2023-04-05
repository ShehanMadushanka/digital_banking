import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import 'widget/intro_card.dart';

class BannerThree extends StatelessWidget {
  const BannerThree({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.bannerThreeBg,
            ),
            fit: BoxFit.contain,
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
                right: 20.w,
                bottom: 510.h,
                child: IntroCard(
                  titleOne: AppString.digital.localize(context),
                  titleTwo: AppString.wallet.localize(context),
                  descOne: AppString.keepEasyAndKeepSafe.localize(context),
                  descTwo: AppString.withAllWalletFeatures.localize(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
