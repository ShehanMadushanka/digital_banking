import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/data/datasources/local_data_source.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import 'marketing_banner_one_view.dart';
import 'marketing_banner_three_view.dart';
import 'marketing_banner_two_view.dart';

class IntroductionSliderView extends StatelessWidget {
  final PageController _pageController = PageController();
  final appSharedData = inject<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
               BannerOne(),
               BannerTwo(),
               BannerThree(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 32),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: ColorTransitionEffect(
                      activeDotColor: AppColors.accentColor,
                      dotColor: AppColors.darkAshColor,
                      dotHeight: 10.h,
                      dotWidth: 10,
                      radius: 20,
                      spacing: 9.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  appSharedData.setInitialLaunch();
                  Navigator.pushNamed(
                      context, Routes.kLanguageView,
                      arguments: kGeneralTerms);
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 32, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) => AppColors.outlineGradient.createShader(rect),
                        child: Text(AppString.skip.localize(context),
                            style: AppStyling.normal400Size14),
                      ),
                      SizedBox(
                        width: 6.0.w,
                      ),
                      Image.asset(AppImages.forwardArrow,
                          width: 14.h, height: 14.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



