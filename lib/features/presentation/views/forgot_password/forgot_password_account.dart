import 'package:cdb_mobile/utils/app_images.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/forgot_password/forgot_password_user_name_bloc.dart';
import '../../bloc/forgot_password/forgot_password_user_name_event.dart';
import '../../bloc/forgot_password/forgot_password_user_name_state.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';

class ForgotPasswordAccount extends BaseView {
  const ForgotPasswordAccount({Key key}) : super(key: key);

  @override
  State<ForgotPasswordAccount> createState() => _ForgotPasswordAccountState();
}

class _ForgotPasswordAccountState extends BaseViewState<ForgotPasswordAccount> {
  final bloc = inject<ForgotPasswordUserNameBloc>();
  String accountNumber = '', nic = '';

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: 'Reset Password',
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider<ForgotPasswordUserNameBloc>(
        create: (_) => bloc,
        child: BlocListener<ForgotPasswordUserNameBloc,
            BaseState<ForgotPasswordUserNameState>>(
          bloc: bloc,
          listener: (_, state) async {
            if (state is ForgotPWUsingAccountNumberSuccessState) {
              final _otpResult = await Navigator.pushNamed(
                  context, Routes.kCommonOTPView,
                  arguments: OTPViewArgs(
                      otpType: kOtpMessageTypeOnBoarding,
                      otpReference: state.otpRef)) as bool;

              if (_otpResult) {
                Navigator.pushReplacementNamed(
                    context, Routes.kForgotPasswordCreateNewPassword);
              }
            } else if (state is ForgotPWUsingAccountNumberFailState) {
              showCDBDialog(
                isPng: true,
                alertImagePath: AppImages.logo,
                title: AppString.failed.localize(context),
                body: Column(
                  children: [
                    Text(state.errorMessage),
                  ],
                ),
                positiveButtonText: AppString.ok.localize(context),
                positiveButtonTap: () {},
                negativeButtonText: '',
                negativeButtonTap: () {},
              );
            } else if (state is NICValidationFailedState) {
              showCDBDialog(
                isPng: true,
                alertImagePath: AppImages.logo,
                title: AppString.failed.localize(context),
                body: Column(
                  children: [
                    Text(AppString.validNicKey.localize(context)),
                  ],
                ),
                positiveButtonText: AppString.tryAgain.localize(context),
                positiveButtonTap: () {},
                negativeButtonText: '',
                negativeButtonTap: () {},
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Row(
                  children: [
                    Text(
                      AppString.forgotPwUserName.localize(context),
                      style: AppStyling.normal400Size14
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 44.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.h),
                child: CdbCustomTextField(
                  suffixIcon: Container(
                    transform: Matrix4.translationValues(0.0, 0.0, .0),
                    child: IconButton(
                      splashRadius: 18,
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                      ),
                      color: AppColors.textDarkColor,
                      onPressed: () {},
                    ),
                  ),
                  labelText: AppString.accNumber.localize(context),
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    setState(() {
                      accountNumber = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 45.4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.h),
                child: CdbCustomTextField(
                  suffixIcon: Container(
                    transform: Matrix4.translationValues(0.0, 0.0, .0),
                    child: IconButton(
                      splashRadius: 18,
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: 18,
                      ),
                      color: AppColors.textDarkColor,
                      onPressed: () {},
                    ),
                  ),
                  labelText: AppString.nic.localize(context),
                  onChange: (value) {
                    setState(() {
                      nic = value;
                    });
                  },
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding,
                ),
                child: CDBBorderGradientButton(
                  status: _isValidated()
                      ? ButtonStatus.ENABLE
                      : ButtonStatus.DISABLE,
                  onTap: () async {
                    bloc.add(
                      ForgotPasswordUsingAccountNumber(
                          accountNumber: accountNumber, nic: nic),
                    );
                  },
                  width: double.maxFinite,
                  text: AppString.next.localize(context),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidated() {
    return accountNumber.isNotEmpty && nic.isNotEmpty;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
