import 'package:cdb_mobile/features/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_scrollview.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../base_view.dart';

class SettingsChangePasswordView extends BaseView {
  const SettingsChangePasswordView({Key key}) : super(key: key);

  @override
  _SettingsChangePasswordViewState createState() =>
      _SettingsChangePasswordViewState();
}

class _SettingsChangePasswordViewState
    extends BaseViewState<SettingsChangePasswordView> {
  String currentPassword;
  bool currentPasswordHidden = true;

  String newPassword;
  bool newPasswordHidden = true;

  String confirmPassword;
  bool confirmPasswordHidden = true;

  TextStyle passwordFontStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );
  TextStyle confirmPasswordFontStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );

  final _ChangePwNewPwFormKey = GlobalKey<FormState>();

  final ChangePasswordBloc _changePasswordBloc = inject<ChangePasswordBloc>();

  String wrongCurrentPasswordErrorMessage = "";
  String wrongConfirmPasswordErrorMessage = "";

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.settingsChangePwsTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _changePasswordBloc,
        child: BlocListener(
          bloc: _changePasswordBloc,
          listener: (_, state) async {
            if (state is ChangePasswordFailState) {
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
            } else if (state is ChangePasswordApiFailState) {
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
            } else if (state is ChangePasswordSuccessState) {
              ToastUtils.showCustomToast(
                  context,
                  AppString.settingsChangePwsSuccessToast.localize(context),
                  ToastStatus.success);
              logout();
            } else if (state is ChangePasswordWrongCurrentPassword) {
              wrongCurrentPasswordErrorMessage = state.errorMessage;
              _ChangePwNewPwFormKey.currentState.validate();
            } else if (state is ChangePasswordConfirmPasswordWrong) {
              wrongConfirmPasswordErrorMessage = state.errorMessage;
              _ChangePwNewPwFormKey.currentState.validate();
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: kTopMarginOnBoarding,
              bottom: kBottomMargin,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CDBScrollView(
                    child: Form(
                      key: _ChangePwNewPwFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.settingsChangePwsDecs.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CdbCustomTextField(
                            fontStyle:
                                wrongCurrentPasswordErrorMessage.isNotEmpty
                                    ? confirmPasswordFontStyle
                                    : null,
                            suffixIcon: IconButton(
                              icon: Icon(
                                !currentPasswordHidden
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.accentColor,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  currentPasswordHidden =
                                      !currentPasswordHidden;
                                });
                              },
                              splashRadius: 18,
                              splashColor: AppColors.accentColor,
                            ),
                            isObscureText: currentPasswordHidden,
                            labelText:
                                AppString.currentPassword.localize(context),
                            validator: (value) {
                              if (wrongCurrentPasswordErrorMessage.isNotEmpty) {
                                setFontStyleToRed(isPasswordField: false);
                                return wrongCurrentPasswordErrorMessage;
                              }
                              return null;
                            },
                            onChange: (value) {
                              setState(() {
                                currentPassword = value;
                                wrongCurrentPasswordErrorMessage = "";
                              });
                              _ChangePwNewPwFormKey.currentState.validate();
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          CdbCustomTextField(
                            suffixIcon: IconButton(
                              icon: Icon(
                                !newPasswordHidden
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.accentColor,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  newPasswordHidden = !newPasswordHidden;
                                });
                              },
                              splashRadius: 18,
                              splashColor: AppColors.accentColor,
                            ),
                            isObscureText: newPasswordHidden,
                            labelText: AppString.newPassword.localize(context),
                            onChange: (value) {
                              setState(() {
                                newPassword = value;
                              });
                              debugPrint(value.toString());
                            },
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          CdbCustomTextField(
                            fontStyle:
                                wrongConfirmPasswordErrorMessage.isNotEmpty
                                    ? confirmPasswordFontStyle
                                    : null,
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
                                  confirmPasswordHidden =
                                      !confirmPasswordHidden;
                                });
                              },
                              splashRadius: 18,
                              splashColor: AppColors.accentColor,
                            ),
                            isObscureText: confirmPasswordHidden,
                            labelText:
                                AppString.confirmNewPassword.localize(context),
                            onChange: (value) {
                              setState(() {
                                confirmPassword = value;
                                wrongConfirmPasswordErrorMessage = "";
                              });
                              _ChangePwNewPwFormKey.currentState.validate();
                            },
                            validator: (value) {
                              if (newPassword != confirmPassword) {
                                setFontStyleToRed(isPasswordField: false);
                                return wrongConfirmPasswordErrorMessage;
                              }
                              return null;
                            },
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
                    status: _isValidated()
                        ? ButtonStatus.ENABLE
                        : ButtonStatus.DISABLE,
                    onTap: () {
                      _changePasswordBloc.add(
                        ChangeCurrentPasswordEvent(
                          oldPassword: currentPassword.toBase64(),
                          newPassword: newPassword.toBase64(),
                          confirmPassword: confirmPassword.toBase64(),
                        ),
                      );
                    },
                    text: AppString.settingsChangePwsTitle.localize(context),
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
    if (currentPassword == "" ||
        currentPassword == null ||
        newPassword == "" ||
        newPassword == null ||
        confirmPassword == "" ||
        confirmPassword == null) {
      return false;
    }
    return true;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _changePasswordBloc;
  }
}
