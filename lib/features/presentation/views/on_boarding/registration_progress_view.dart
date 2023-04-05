import 'package:cdb_mobile/features/presentation/widgets/cdb_header_underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/app_utils.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/reg_progress/reg_progress_bloc.dart';
import '../../bloc/on_boarding/reg_progress/reg_progress_event.dart';
import '../../bloc/on_boarding/reg_progress/reg_progress_state.dart';
import '../../widgets/cdb_buttons/cdb_on_boarding_button.dart';
import '../base_view.dart';

class RegistrationProgressView extends BaseView {
  const RegistrationProgressView({Key key}) : super(key: key);

  @override
  _RegistrationProgressViewState createState() =>
      _RegistrationProgressViewState();
}

class _RegistrationProgressViewState
    extends BaseViewState<RegistrationProgressView> {
  final RegProgressBloc _regProgressBloc = inject<RegProgressBloc>();

  @override
  void initState() {
    _regProgressBloc.add(GetStepperValueEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocProvider(
          create: (_) => _regProgressBloc,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
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
                      child: const CdbHeaderUnderline(),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 35.h),
                        child: Image.asset(
                          AppImages.registerBackground,
                          fit: BoxFit.fitWidth,
                          height: 330,
                          width: MediaQuery.of(context).size.width,
                        )),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(
                    //     left: 16.w,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         AppString.userRegProgress.localize(context),
                    //         style: AppStyling.normal400Size14.copyWith(color: AppColors.textDarkColor),
                    //       ),
                    //       SizedBox(
                    //         height: 10.h,
                    //       ),
                    //       BlocBuilder<RegProgressBloc, BaseState<RegProgressState>>(
                    //         builder: (context, state) {
                    //           if (state is StepperValueLoadedState) {
                    //             return Text(
                    //               " (STEP ${state.stepperValue}/6)",
                    //               style: AppStyling.normal400Size14.copyWith(color: AppColors.primaryColor),
                    //             );
                    //           } else {
                    //             return Text(
                    //               " (STEP 0/6)",
                    //               style: AppStyling.normal400Size14.copyWith(color: AppColors.primaryColor),
                    //             );
                    //           }
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 16.w),
                    //   child: Text(
                    //     "You are currently in the Personal Information step \n please complete your registration",
                    //     style: AppStyling.normal400Size14.copyWith(color: AppColors.textLightColor),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: Row(
                  children: [
                    Text(
                      AppString.userRegProgress.localize(context),
                      style: AppStyling.normal400Size14
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocBuilder<RegProgressBloc, BaseState<RegProgressState>>(
                      builder: (context, state) {
                        if (state is StepperValueLoadedState) {
                          return state.stepperValue >= 5 ? Container() : Text(
                            " (STEP ${state.stepperValue}/5)",
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.primaryColor),
                          );
                        } else {
                          return Text(
                            " (STEP 0/5)",
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.primaryColor),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocBuilder<RegProgressBloc, BaseState<RegProgressState>>(
                builder: (context, state) {
                  if (state is StepperValueLoadedState) {
                    return Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        "You are currently in the ${AppUtils.getKYCEnum(state.stepperName).getLabel(context) ?? "-"} step \n please complete your registration",
                        style: AppStyling.normal400Size14
                            .copyWith(color: AppColors.textLightColor),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        "You are currently in the Personal Information step \n please complete your registration",
                        style: AppStyling.normal400Size14
                            .copyWith(color: AppColors.textLightColor),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 32.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child:
                    BlocBuilder<RegProgressBloc, BaseState<RegProgressState>>(
                  builder: (context, state) {
                    if (state is StepperValueLoadedState) {
                      return CdbOnBoardingButton(
                        mainButtonText: AppString.completeReg.localize(context),
                        icon: Icons.arrow_forward_rounded,
                        gradient: AppColors.outlineGradient,
                        textColor: AppColors.accentColor,
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context,
                              AppUtils.getKYCEnum(state.stepperName)
                                  .getNavigationRouteName(),
                              arguments: false);
                        },
                      );
                    } else {
                      return CdbOnBoardingButton(
                        mainButtonText: AppString.completeReg.localize(context),
                        icon: Icons.arrow_forward_rounded,
                        gradient: AppColors.outlineGradient,
                        textColor: AppColors.accentColor,
                        onTap: () {},
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _regProgressBloc;
  }
}
