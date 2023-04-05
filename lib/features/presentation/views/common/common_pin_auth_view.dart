import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/forgot_password/forgot_pw_create_new_password_bloc.dart';
import '../../bloc/forgot_password/forgot_pw_create_new_password_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';

class CommonPinAuthArguments {
  final String title;
  final String message;

  CommonPinAuthArguments({this.title, this.message});
}

class CommonPinAuthView extends BaseView {
  final CommonPinAuthArguments commonPinAuthArguments;

  CommonPinAuthView({@required this.commonPinAuthArguments});

  @override
  _CommonPINAuthViewState createState() => _CommonPINAuthViewState();
}

class _CommonPINAuthViewState extends BaseViewState<CommonPinAuthView> {
  final _bloc = inject<ForgotPwCreateNewPasswordBloc>();
  String password = '';
  bool passwordHidden = true;

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
        appBar: CDBMainAppBar(
          appBarTitle: widget.commonPinAuthArguments.title ??
              AppString.ft2faCommonPinTitle.localize(context),
          onTapBack: () {
            Navigator.pop(context, false);
          },
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: kBottomMargin,
          ),
          child: BlocProvider<ForgotPwCreateNewPasswordBloc>(
            create: (_) => _bloc,
            child: BlocListener<ForgotPwCreateNewPasswordBloc,
                BaseState<ForgotPwCreateNewPasswordState>>(
              listener: (_, state) {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CDBScrollView(
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.commonPinAuthArguments.message ??
                                  AppString.ft2faCommonPinDescription
                                      .localize(context),
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            CdbCustomTextField(
                              fontStyle: AppStyling.normal500Size16.copyWith(
                                color: AppColors.textDarkColor,
                              ),
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
                    child: Column(
                      children: [
                        CDBBorderGradientButton(
                          width: double.maxFinite,
                          status: password.isNotEmpty
                              ? ButtonStatus.ENABLE
                              : ButtonStatus.DISABLE,
                          onTap: () {},
                          text: AppString.proceed.localize(context),
                        ),
                        CDBNoBorderBackgroundButton(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          text: AppString.cancel.localize(context),
                        ),
                      ],
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
