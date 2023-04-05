import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/cdb_buttons/cdb_on_boarding_button.dart';
import '../base_view.dart';

class NewRegistrationView extends BaseView {
  const NewRegistrationView({Key key}) : super(key: key);

  @override
  _NewRegistrationViewState createState() => _NewRegistrationViewState();
}

class _NewRegistrationViewState extends BaseViewState<NewRegistrationView> {
  final SplashBloc _splashBloc = inject<SplashBloc>();

  @override
  Widget buildView(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
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
                        context, Routes.kCreateProfileUsingCdbAcc,
                        arguments: kGeneralTerms),
                    mainButtonText: AppString.cdbAccount.localize(context),
                    icon: Icons.arrow_forward_rounded,
                    gradient: AppColors.outlineGradient,
                    textColor: AppColors.accentColor,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                  child: CdbOnBoardingButton(
                    onTap: () => Navigator.pushNamed(
                        context, Routes.kTermsAndConditionsView,
                        arguments: kGeneralTerms),
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
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _splashBloc;
  }
}
