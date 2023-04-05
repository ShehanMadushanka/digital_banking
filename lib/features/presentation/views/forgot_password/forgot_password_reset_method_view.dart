import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/data/datasources/local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../widgets/cdb_appbar/cdb_appbar_white.dart';
import '../../widgets/cdb_buttons/cdb_on_boarding_button.dart';

class ForgotPasswordResetMethodView extends StatefulWidget {
  const ForgotPasswordResetMethodView({Key key}) : super(key: key);

  @override
  _ForgotPasswordResetMethodViewState createState() =>
      _ForgotPasswordResetMethodViewState();
}

class _ForgotPasswordResetMethodViewState
    extends State<ForgotPasswordResetMethodView> {
  final localDataSource = inject<LocalDataSource>();
  bool isUserNameAvailable = false;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  getUserName() async {
    await localDataSource.hasUsername().then((value){
      setState(() {
        isUserNameAvailable = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBAppBarWhite(
        title: AppString.forgotPasswordTitle.localize(context),
      ),
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 0.h),
                    height: 295.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: AppColors.redGradient,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.h),
                    child: Image.asset(
                      AppImages.forgotPasswordBackground,
                      fit: BoxFit.fitHeight,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ],
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
                      AppString.forgotPasswordResetMethod.localize(context),
                      style: AppStyling.normal400Size14
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (isUserNameAvailable) Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CdbOnBoardingPrefixButton(
                  onTap: () => Navigator.pushNamed(
                      context, Routes.kForgotPasswordResetUsingSecurityQuestionsView,),
                  mainButtonText: AppString.securityQuestions.localize(context),
                  image: Image.asset(AppImages.securityQuesIcon),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ) else const SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CdbOnBoardingPrefixButton(
                  onTap: () => Navigator.pushNamed(
                    context, Routes.kForgotPwUserName,),
                  mainButtonText: AppString.userName.localize(context),
                  image: Image.asset(AppImages.walletIcon),
                  icon: Icons.arrow_forward_rounded,
                  gradient: AppColors.outlineGradient,
                  textColor: AppColors.accentColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CdbOnBoardingPrefixButton(
                  onTap: () => Navigator.pushNamed(
                    context, Routes.kForgotPasswordAccount,),
                  mainButtonText: AppString.cdbAccount.localize(context),
                  image: Image.asset(AppImages.accountIcon),
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
