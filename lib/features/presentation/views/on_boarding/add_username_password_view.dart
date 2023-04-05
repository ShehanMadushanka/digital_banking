import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/create_user/create_user_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/create_user/create_user_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/create_user/create_user_state.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_header_underline.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';

class AddUserNamePasswordView extends BaseView {
  const AddUserNamePasswordView({Key key}) : super(key: key);

  @override
  _AddUserNamePasswordViewState createState() =>
      _AddUserNamePasswordViewState();
}

class _AddUserNamePasswordViewState
    extends BaseViewState<AddUserNamePasswordView> {
  final _bloc = inject<CreateUserBloc>();

  String password;
  String confirmPassword;
  String username;

  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  final _formKey = GlobalKey<FormState>();
  TextStyle passwordFontStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );
  TextStyle confirmPasswordFontStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(
            context,
            Routes.kRegProgress,
          );
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 68.h,
            bottom: kBottomMargin,
          ),
          child: BlocProvider<CreateUserBloc>(
            create: (_) => _bloc,
            child: BlocListener<CreateUserBloc, BaseState<CreateUserState>>(
              listener: (_, state) {
                if (state is CreateUserSuccessState) {
                  _bloc.add(SaveUserEvent());
                } else if (state is CreateUserFailedState) {
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
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.setUpLoginDetails.localize(context),
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
                              AppString.setUpLoginDescription.localize(context),
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
                            CdbCustomTextField(
                              // key: Key(initialReferenceCode ?? "referenceCode"),
                              // initialValue: referenceCode,
                              labelText: AppString.userName.localize(context),
                              onChange: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            CdbCustomTextField(
                              prefixIcon: Container(
                                transform:
                                    Matrix4.translationValues(-10.0, 0.0, 0.0),
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
                              labelText: AppString.password.localize(context),
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
                              // prefixIcon: Container(
                              //   transform:
                              //       Matrix4.translationValues(-10.0, 0.0, 0.0),
                              //   child: IconButton(
                              //     splashRadius: 18,
                              //     padding: EdgeInsets.zero,
                              //     icon: const Icon(
                              //       Icons.info_outline_rounded,
                              //       size: 18,
                              //     ),
                              //     color: AppColors.textDarkColor,
                              //     onPressed: () {},
                              //   ),
                              // ),
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
                                    confirmPasswordHidden =
                                        !confirmPasswordHidden;
                                  });
                                },
                                splashRadius: 18,
                                splashColor: AppColors.accentColor,
                              ),
                              isObscureText: confirmPasswordHidden,
                              labelText:
                                  AppString.confirmPassword.localize(context),
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
                      status: _isValidated()
                          ? ButtonStatus.ENABLE
                          : ButtonStatus.DISABLE,
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            passwordFontStyle =
                                AppStyling.normal500Size16.copyWith(
                              color: AppColors.textDarkColor,
                            );
                            confirmPasswordFontStyle =
                                AppStyling.normal500Size16.copyWith(
                              color: AppColors.textDarkColor,
                            );
                          });

                          _bloc.add(CreateUserEvent(
                              confirmPassword: confirmPassword,
                              password: password,
                              username: username));
                        } else {}
                      },
                      text: AppString.next.localize(context),
                    ),
                  ),
                ],
              ),
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
    if (username == null ||
        username == "" ||
        password == "" ||
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
