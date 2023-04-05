import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_on_boarding_button.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordResetMethodView extends StatefulWidget {
  const ForgotPasswordResetMethodView({Key key}) : super(key: key);

  @override
  _ForgotPasswordResetMethodViewState createState() => _ForgotPasswordResetMethodViewState();
}

class _ForgotPasswordResetMethodViewState extends State<ForgotPasswordResetMethodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60.h, left: 16.w),
                      child: Text(
                        AppString.registerWith.localize(context),
                        style: AppStyling.normal500Size16.copyWith(
                          color: AppColors.textDarkColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, top: 5.h),
                      child: Container(
                        width: 20.w,
                        height: 4.h,
                        decoration: const BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35.h),
                      child: Image.asset(
                        AppImages.registerBackground,
                        fit: BoxFit.fitWidth,
                        height: 330,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
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
                      AppString.chooseOptionReg.localize(context),
                      style: AppStyling.normal400Size14
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CdbOnBoardingButton(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.kTermsAndConditionsView,
                      arguments: kGeneralTerms),
                  mainButtonText: AppString.newWallet.localize(context),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CdbOnBoardingButton(
                  mainButtonText: AppString.cdbAccCard.localize(context),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CdbOnBoardingButton(
                  mainButtonText: AppString.otherBank.localize(context),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
