import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_password_user_name_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_password_user_name_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_password_user_name_state.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/views/otp/otp_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
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

class ForgotPasswordUserNameView extends BaseView {
  const ForgotPasswordUserNameView({Key key}) : super(key: key);

  @override
  _ForgotPasswordUserNameViewState createState() =>
      _ForgotPasswordUserNameViewState();
}

class _ForgotPasswordUserNameViewState
    extends BaseViewState<ForgotPasswordUserNameView> {
  String nic = '';
  String username = '';
  final nicController = TextEditingController();
  final userNameController = TextEditingController();

  final _bloc = inject<ForgotPasswordUserNameBloc>();

  @override
  void initState() {
    super.initState();
  }

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
        create: (_) => _bloc,
        child: BlocListener<ForgotPasswordUserNameBloc,
            BaseState<ForgotPasswordUserNameState>>(
          listener: (_, state) async {
            if (state is InitialForgotPasswordUserNameState) {
            }
            else if (state is GetForgotPasswordUserNameSuccessState) {
              final _otpResult = await Navigator.pushNamed(
                  context, Routes.kCommonOTPView,
                  arguments: OTPViewArgs(
                      otpType: kOtpMessageTypeOnBoarding,
                      requestOTP: true)) as bool;
              if (_otpResult) {
                Navigator.pushReplacementNamed(
                    context, Routes.kForgotPasswordCreateNewPassword);
              }
            }
            else if (state is GetForgotPasswordUserNameFailedState) {
              showCDBDialog(
                title: AppString.failed.localize(context),
                body: Column(
                  children: [
                    Text(state.message),
                  ],
                ),
                positiveButtonText: AppString.tryAgain.localize(context),
                positiveButtonTap: () {},
                negativeButtonText: '',
                negativeButtonTap: () {},
              );
            }
            else if (state is GetForgotPasswordUserNameAPIFailedState) {
              showCDBDialog(
                title: AppString.errorDetailsNotFound.localize(context),
                body: Column(
                  children: [
                    Text(state.message),
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
                  // key: Key(username ?? "userName"),
                  // initialValue: username,

                  labelText: AppString.forgotUserName.localize(context),
                  onChange: (value) {
                    setState(() {
                      username = value;
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
                  status: _validate()?ButtonStatus.ENABLE:ButtonStatus.DISABLE,
                  onTap: () async {
                    _bloc.add(GetForgotPasswordUserNameEvent(
                        nic: nic, username: username));
                    /*final _otpResult = await Navigator.pushNamed(
                        context, Routes.kCommonOTPView,
                        arguments: OTPViewArgs(
                            otpType: kOtpMessageTypeOnBoarding,
                            requestOTP: true)) as bool;

                    if (_otpResult) {
                      Navigator.pushReplacementNamed(context, Routes.kForgotPasswordCreateNewPassword);
                    }*/
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

  bool _validate(){
    return username.isNotEmpty && nic.isNotEmpty;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
