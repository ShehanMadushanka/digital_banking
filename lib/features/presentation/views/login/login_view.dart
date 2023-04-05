
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/network/network_config.dart';
import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/biometric_helper.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/user_login/login_bloc.dart';
import '../../bloc/user_login/login_event.dart';
import '../../bloc/user_login/login_state.dart';
import '../../widgets/cdb_appbar/cdb_appbar_white.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';
import 'widget/round_notch_shape.dart';

class LoginView extends BaseView {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BaseViewState<LoginView> {
  final LoginBloc _loginBloc = inject<LoginBloc>();
  bool passwordHidden = true;
  String storedUsername = '';
  String username = '';
  String password = '';

  BiometricHelper _biometricHelper;
  bool _isBiometricAvailable = false;
  bool _isAppBiometricAvailable = false;
  bool _isInitialBiometricPrompted = false;
  BiometricType _biometricType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc.add(CheckCredentialAvailability());
    setState(() {
      _isAppBiometricAvailable = AppConstants.BIOMETRIC_CODE != null;
    });
  }

  @override
  void initState() {
    super.initState();
    _biometricHelper = BiometricHelper();
    _biometricHelper.isBiometricAvailable().then((value) {
      setState(() {
        _isBiometricAvailable = value;
      });
    });
    _biometricHelper.getListOfBiometricTypes().then((value) {
      setState(() {
        _biometricType = value;
      });
    });
  }

  initialBiometricLogin() async {
    if (!_isInitialBiometricPrompted) {
      if (_isAppBiometricAvailable && _isBiometricAvailable) {
        await _biometricHelper.authenticateUser().then((success) {
          _isInitialBiometricPrompted = true;
          if (success) {
            _loginBloc.add(BiometricLoginEvent());
          }
        });
      }
    }
  }

  @override
  Widget buildView(BuildContext context) {
    initialBiometricLogin();

    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: CDBAppBarWhite(
          onBackPressed: () {
            Navigator.pushReplacementNamed(context, Routes.kLanguageView,
                arguments: true);
          },

          actions: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Image.asset(
                AppImages.icFaq,
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
        body: BlocProvider(
          create: (_) => _loginBloc,
          child: BlocListener(
            bloc: _loginBloc,
            listener: (_, state) async {
              if (state is MobileLoginFailedState) {
                showCDBDialog(
                  title: AppString.invalidCredentials.localize(context),
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
              else if (state is MobileLoginAPIFailedState) {
                showCDBDialog(
                  isPng: true,
                  alertImagePath: AppImages.logo,
                  title: AppString.invalidCredentials.localize(context),
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
              else if (state is MobileLoginSuccessState) {
                if (state.responseCode == APIResponse.RESPONSE_LOGIN_SUCCESS ||
                    state.responseCode ==
                        APIResponse.RESPONSE_BIOMETRIC_LOGIN_SUCCESS) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.kHomeView,
                    (route) => false,
                  );
                } else if (state.responseCode ==
                        APIResponse.RESPONSE_M_LOGIN_SUCCESS_PASSWORD_RESET ||
                    state.responseCode ==
                        APIResponse.RESPONSE_B_LOGIN_SUCCESS_PASSWORD_RESET) {
                  ///PWD Reset
                  showCDBDialog(
                    title:
                        AppString.forgotPasswordSecQuesTitle.localize(context),
                    body: Column(
                      children: [
                        Text(state.responseDescription),
                      ],
                    ),
                    positiveButtonText: AppString.done.localize(context),
                    positiveButtonTap: () {
                      Navigator.pushNamed(
                          context, Routes.kSettingsChangePasswordView);
                    },
                    negativeButtonText: '',
                    negativeButtonTap: () {},
                  );
                } else if (state.responseCode ==
                        APIResponse.RESPONSE_M_LOGIN_SUCCESS_PASSWORD_EXPIRED ||
                    state.responseCode ==
                        APIResponse.RESPONSE_B_LOGIN_SUCCESS_PASSWORD_EXPIRED) {
                  ///PWD Expired
                  showCDBDialog(
                    title: AppString.titlePasswordExpired.localize(context),
                    body: Column(
                      children: [
                        Text(AppString.descriptionPasswordExpired
                            .localize(context)),
                      ],
                    ),
                    positiveButtonText:
                        AppString.settingsChangePwsTitle.localize(context),
                    positiveButtonTap: () {
                      Navigator.pushNamed(
                          context, Routes.kSettingsChangePasswordView);
                    },
                    negativeButtonText: '',
                    negativeButtonTap: () {},
                  );
                } else if (state.responseCode ==
                        APIResponse.RESPONSE_M_LOGIN_SUCCESS_NEW_DEVICE ||
                    state.responseCode ==
                        APIResponse.RESPONSE_B_LOGIN_SUCCESS_NEW_DEVICE) {
                  ///Device Change
                  final _otpResult = await Navigator.pushNamed(
                      context, Routes.kCommonOTPView,
                      arguments: OTPViewArgs(
                          otpType: kOtpMessageTypeNewDevice,
                          otpReference: state.mobileLoginResponse.otpResponseDto
                              .otpReferenceNo,
                          requestOTP: false)) as bool;

                  if (_otpResult) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeView,
                      (route) => false,
                    );
                  }
                } else if (state.responseCode ==
                        APIResponse.RESPONSE_M_LOGIN_SUCCESS_INACTIVE_DEVICE ||
                    state.responseCode ==
                        APIResponse.RESPONSE_B_LOGIN_SUCCESS_INACTIVE_DEVICE) {
                  ///Inactive device
                  /*showCDBDialog(
                    title: AppString.labelIncorrectPassword
                        .localize(context),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.descIncorrectPassword
                            .localize(context)),
                        SizedBox(height: 16,),
                        Text.rich(TextSpan(
                          text: AppString.contactUsOn
                              .localize(context),
                          children: [
                            TextSpan(text: '011 2678765', style: AppStyling.normal300Size13.copyWith(color: AppColors.primaryColor))
                          ]
                        )),
                      ],
                    ),
                    positiveButtonText: AppString.close.localize(context),
                    positiveButtonTap: () {

                    },
                    negativeButtonText: '',
                    negativeButtonTap: () {},
                  );*/

                  final _otpResult = await Navigator.pushNamed(
                      context, Routes.kCommonOTPView,
                      arguments: OTPViewArgs(
                          otpType: kOtpMessageTypeInactiveDevice,
                          otpReference: state.mobileLoginResponse.otpResponseDto
                              .otpReferenceNo,
                          requestOTP: false)) as bool;

                  if (_otpResult) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.kHomeView,
                      (route) => false,
                    );
                  }
                }
              }
              else if (state is GetLoginCredentials) {
                if (state.isAvailable) {
                  setState(() {
                    storedUsername = state.username;
                  });
                }
              }
              else if (state is StepperValueLoadedState) {
                Navigator.pushNamed(context, state.routeString);
              }
              else if (state is BiometricPromptSuccessState) {
                if (_isAppBiometricAvailable && _isBiometricAvailable) {
                  await _biometricHelper.authenticateUser().then((success) {
                    _isInitialBiometricPrompted = true;
                    if (success) {
                      _loginBloc.add(BiometricLoginEvent());
                    }
                  });
                }
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppImages.loginBackground,
                  fit: BoxFit.fill,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        AppString.welcomeTo.localize(context),
                        style: AppStyling.normal500Size16
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Image.asset(AppImages.cdbIPayLogo,
                          width: 153, height: 52),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 32.w, right: 32.w, bottom: 70.h),
                          padding: EdgeInsets.all(33.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 20, // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              if (storedUsername.isNotEmpty)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppString.forgotUserName
                                            .localize(context),
                                        style: AppStyling.normal400Size14
                                            .copyWith(
                                                color:
                                                    AppColors.textTitleColor),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(storedUsername,
                                              style: AppStyling.normal500Size16
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor)),
                                          Text(
                                            username,
                                            style: AppStyling.normal500Size16
                                                .copyWith(
                                              color: AppColors.textDarkColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              else
                                CdbCustomTextField(
                                  labelText:
                                      AppString.userName.localize(context),
                                  onChange: (value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                ),
                              SizedBox(
                                height: storedUsername.isNotEmpty ? 15 : 28,
                              ),
                              CdbCustomTextField(
                                // fontStyle: passwordFontStyle,
                                validator: (value) {
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    !passwordHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.accentColor,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordHidden = !passwordHidden;
                                    });
                                  },
                                  splashRadius: 18,
                                  splashColor: AppColors.accentColor,
                                ),
                                isObscureText: passwordHidden,
                                labelText: AppString.password.localize(context),
                                onChange: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.kForgotPasswordResetMethodView,
                                    );
                                  },
                                  child: Text(
                                    AppString.forgetPassword.localize(context),
                                    style: AppStyling.normal300Size13.copyWith(
                                      color: AppColors.primaryColor,
                                      // fontSize: 12
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              CDBBorderGradientButton(
                                width: double.maxFinite,
                                onTap: () {
                                  if (storedUsername.isNotEmpty) {
                                    if (password.isEmpty) {
                                      ToastUtils.showCustomToast(
                                          context,
                                          AppString.emptyPassword
                                              .localize(context),
                                          ToastStatus.fail);
                                    } else {
                                      _loginBloc.add(MobileLoginEvent(
                                          username: storedUsername,
                                          password: password));
                                    }
                                  } else {
                                    if (username.isEmpty) {
                                      ToastUtils.showCustomToast(
                                          context,
                                          AppString.emptyUsername
                                              .localize(context),
                                          ToastStatus.fail);
                                    } else if (password.isEmpty) {
                                      ToastUtils.showCustomToast(
                                          context,
                                          AppString.emptyPassword
                                              .localize(context),
                                          ToastStatus.fail);
                                    } else {
                                      _loginBloc.add(MobileLoginEvent(
                                          username: username,
                                          password: password));
                                    }
                                  }
                                },
                                text: AppString.login.localize(context),
                              ),
                              if (_isAppBiometricAvailable &&
                                  _isBiometricAvailable)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _loginBloc
                                            .add(RequestBiometricPromptEvent());
                                      },
                                      child: _getBiometricIcon(),
                                    )
                                  ],
                                )
                              else
                                _isAppBiometricAvailable
                                    ? const SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Text(
                                            AppString.or.localize(context),
                                            style: AppStyling.normal500Size16
                                                .copyWith(
                                              color: AppColors.textLightColor,
                                              // fontSize: 12
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _loginBloc
                                                  .add(GetStepperValueEvent());
                                            },
                                            child: Text(
                                              AppString.registerNewUser
                                                  .localize(context),
                                              style: AppStyling.normal400Size14
                                                  .copyWith(
                                                color: AppColors.textTitleColor,
                                                // fontSize: 12
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 48.w,
          width: 48.w,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, Routes.kPreLoginMenu);
            },
            child: CircleAvatar(
              radius: 48,
              backgroundColor: AppColors.accentColor,
              child: Padding(
                padding: EdgeInsets.all(14.h),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3.5,
                  crossAxisSpacing: 3.5,
                  children: List.generate(
                      9,
                      (index) => const CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                            radius: 4.5,
                          )),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 55.h,
          child: Container(
            decoration: ShapeDecoration(
                color: AppColors.separationLinesColor,
                shape: RoundNotchShape()),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 31.h,
                child: Center(
                  child: Text(
                    AppString.menu.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                      // fontSize: 12
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SvgPicture _getBiometricIcon() {
    return SvgPicture.asset(
      _biometricType == BiometricType.face
          ? AppImages.faceIdIntIcon
          : AppImages.fingerPrintInitIcon,
      width: 45.w,
      height: 45.h,
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _loginBloc;
  }
}
