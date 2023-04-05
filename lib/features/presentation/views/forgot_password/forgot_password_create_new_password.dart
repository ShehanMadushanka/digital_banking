import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/forgot_password/forgot_pw_create_new_password_bloc.dart';
import '../../bloc/forgot_password/forgot_pw_create_new_password_event.dart';
import '../../bloc/forgot_password/forgot_pw_create_new_password_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_header_underline.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class ForgotPasswordCreateNewPassword extends BaseView {
  const ForgotPasswordCreateNewPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordCreateNewPasswordState createState() =>
      _ForgotPasswordCreateNewPasswordState();
}

class _ForgotPasswordCreateNewPasswordState
    extends BaseViewState<ForgotPasswordCreateNewPassword> {
  final _bloc = inject<ForgotPwCreateNewPasswordBloc>();
  String password;
  String confirmPassword;
  String username='';

  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  final _forgotPwNewPwFormKey = GlobalKey<FormState>();
  TextStyle passwordFontStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );
  TextStyle confirmPasswordFontStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );

  initUI() async {
    username = await _bloc.localDataSource.getUsername();
    setState(() {
    });
  }

  @override
  void initState() {
    initUI();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 68.h,
          bottom: kBottomMargin,
        ),
        child: BlocProvider<ForgotPwCreateNewPasswordBloc>(
          create: (_) => _bloc,
          child: BlocListener<ForgotPwCreateNewPasswordBloc, BaseState<ForgotPwCreateNewPasswordState>>(
            listener: (_, state) {
              if (state is ForgotPwCreateNewPasswordSuccessState) {
                ToastUtils.showCustomToast(
                    context, AppString.passwordCreationSuccess.localize(context), ToastStatus.success);
                Navigator.pushReplacementNamed(
                    context, Routes.kLoginView,
                    arguments: false);
              } else if (state is ForgotPwCreateNewPasswordFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              } else if (state is SaveUserSuccessState) {
                Navigator.pushReplacementNamed(
                    context, Routes.kBioMetricInformation,
                    arguments: false);
              } else if (state is SaveUserFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CDBScrollView(
                    child: Form(
                      key: _forgotPwNewPwFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.createNewPw.localize(context),
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: CdbHeaderUnderline(),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Text(
                            AppString.createNewPwDesc.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          Center(
                            child: Image.asset(AppImages.cdbIPayLogo,
                                width: 228, height: 78),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Text(AppString.userName.localize(context),style: AppStyling.normal400Size14.copyWith(color: AppColors.textTitleColor,),),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,top: 6),
                            child: Text(username??'',style: AppStyling.normal500Size16.copyWith(color: AppColors.textDarkColor,),),
                          ),

                          SizedBox(
                            height: 30.h,
                          ),
                          CdbCustomTextField(
                            prefixIcon: Container(
                              transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
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
                            fontStyle: passwordFontStyle,
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
                            labelText: AppString.newPassword.localize(context),
                            onChange: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          CdbCustomTextField(
                            prefixIcon: Container(
                              transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
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
                            fontStyle: confirmPasswordFontStyle,
                            validator: (value) {
                              if (password != confirmPassword) {
                                setFontStyleToRed(isPasswordField: false);
                                return "Password not match try again";
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                !confirmPasswordHidden
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.accentColor,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  confirmPasswordHidden = !confirmPasswordHidden;
                                });
                              },
                              splashRadius: 18,
                              splashColor: AppColors.accentColor,
                            ),
                            isObscureText: confirmPasswordHidden,
                            labelText: AppString.confirmNewPassword.localize(context),
                            onChange: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kLeftRightMarginOnBoarding,
                    right: kLeftRightMarginOnBoarding,
                  ),
                  child: CDBBorderGradientButton(
                    width: double.maxFinite,
                    status:
                        _isValidated() ? ButtonStatus.ENABLE : ButtonStatus.DISABLE,
                    onTap: () {
                      if (_forgotPwNewPwFormKey.currentState.validate()) {
                        setState(() {
                          passwordFontStyle = AppStyling.normal500Size16.copyWith(
                            color: AppColors.textDarkColor,
                          );
                          confirmPasswordFontStyle =
                              AppStyling.normal500Size16.copyWith(
                            color: AppColors.textDarkColor,
                          );
                        });

                        _bloc.add(ForgotPasswordCreateNewPasswordEvent(
                            confirmPassword: confirmPassword,
                            password: password,
                            username: username_key));
                      }
                    },
                    text: AppString.next.localize(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Set error font style
  void setFontStyleToRed({bool isPasswordField}) {
    if (isPasswordField) {
      setState(() {
        passwordFontStyle = AppStyling.normal500Size16.copyWith(
          color: AppColors.accentColor,
        );
      });
    } else {
      setState(() {
        confirmPasswordFontStyle = AppStyling.normal500Size16.copyWith(
          color: AppColors.accentColor,
        );
      });
    }
  }

  /// Check if fields are null or empty
  bool _isValidated() {
    if (password == "" ||
        password == null ||
        confirmPassword == "" ||
        confirmPassword == null) {
      return false;
    }
    return true;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;

}
