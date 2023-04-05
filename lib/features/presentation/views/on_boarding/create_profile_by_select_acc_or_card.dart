import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/cdb_buttons/cdb_on_boarding_button.dart';
import '../../widgets/cdb_header_underline.dart';

class CreateProfileBySelectAccOrCard extends StatelessWidget {
  const CreateProfileBySelectAccOrCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDarkColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 3.h, left: 16.w),
            child: Text(
              AppString.createProfile.localize(context),
              style: AppStyling.normal500Size16.copyWith(
                color: AppColors.textDarkColor,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: 0.h, left: kLeftRightMarginOnBoarding.w),
            child: const CdbHeaderUnderline(),
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 0.h),
                height: 295.h,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: AppColors.pinkGradient,
                ),
              ),
              Positioned(
                bottom: 21.h,
                child: Image.asset(
                  AppImages.createProfileBgOne,
                  width: MediaQuery.of(context).size.width,
                  height: 170.h,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: Row(
                  children: [
                    Text(
                      AppString.selectYourPreferredMethod.localize(context),
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                child: CdbOnBoardingPrefixButton(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.kCreateProfileUsingCdbAcc,
                      arguments: kGeneralTerms),
                  mainButtonText: AppString.myCdbAcc.localize(context),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 16.w, right: 16.w,),
                child: CdbOnBoardingPrefixButton(
                  mainButtonText: AppString.myCdbCard.localize(context),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
