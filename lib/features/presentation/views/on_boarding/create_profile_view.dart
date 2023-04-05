import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/create_user/create_user_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_header_underline.dart';
import '../base_view.dart';

class CreateProfileView extends BaseView {
  const CreateProfileView({Key key}) : super(key: key);

  @override
  _CreateProfileViewState createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends BaseViewState<CreateProfileView> {
  final _bloc = inject<CreateUserBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async {
          Navigator.pushReplacementNamed(
              context, Routes.kRegProgress);
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(top: 68.h, bottom: kBottomMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: kLeftRightMarginOnBoarding.w),
                      child: Text(
                        AppString.createProfile.localize(context),
                        style: AppStyling.normal500Size16
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 2, left: kLeftRightMarginOnBoarding.w),
                      child: const CdbHeaderUnderline(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60.h),
                          height: 125.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 235, 235, 0.75),
                                Color.fromRGBO(255, 255, 255, 0.75),
                                Color.fromRGBO(255, 235, 235, 0.75),
                                Color.fromRGBO(243, 243, 243, 0),
                                Color.fromRGBO(255, 235, 235, 0.75),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: SvgPicture.asset(
                            AppImages.createProfileImage,
                            width: MediaQuery.of(context).size.width,
                            height: 250.h,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: kLeftRightMarginOnBoarding.w,
                          right: kLeftRightMarginOnBoarding.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            AppString.cusRegSuccess.localize(context),
                            style: AppStyling.normal600Size16.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            AppString.cusRegDes1.localize(context),
                            style: AppStyling.normal400Size14.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            AppString.cusRegDes2.localize(context),
                            style: AppStyling.normal400Size14.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding,
                ),
                child: Column(
                  children: [
                    CDBBorderGradientButton(
                      width: double.maxFinite,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.kAddUserNamePasswordView);
                      },
                      text: AppString.createYourProfile.localize(context),
                    ),
                    CDBNoBorderBackgroundButton(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.kRegProgress);
                      },
                      text: 'Create Later',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
