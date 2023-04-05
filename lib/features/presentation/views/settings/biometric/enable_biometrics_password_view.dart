import 'package:flutter/material.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/user_login/login_bloc.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../../widgets/cdb_toast/cdb_toast.dart';
import '../../base_view.dart';

class EnableBiometricsPasswordView extends BaseView {
  const EnableBiometricsPasswordView({Key key}) : super(key: key);

  @override
  _EnableBiometricsPasswordViewState createState() =>
      _EnableBiometricsPasswordViewState();
}

class _EnableBiometricsPasswordViewState
    extends BaseViewState<EnableBiometricsPasswordView> {
  String password = '';
  bool passwordHidden = true;

  final LoginBloc _loginBloc = inject<LoginBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.biometricSettings.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: kLeftRightMarginOnBoarding,
          right: kLeftRightMarginOnBoarding,
          top: kTopMarginOnBoarding,
          bottom: kBottomMargin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  AppString.biometricEnablePswDesc.localize(context),
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textTitleColor),
                ),
                const SizedBox(
                  height: 20,
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
              ],
            ),
            CDBBorderGradientButton(
              width: double.maxFinite,
              onTap: () {
                if (password.isNotEmpty) {
                  Navigator.pushNamed(context, Routes.kEnableBiometricsView);
                } else {
                  ToastUtils.showCustomToast(
                      context,
                      AppString.emptyPassword.localize(context),
                      ToastStatus.fail);
                }
              },
              text: AppString.continueTxt.localize(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _loginBloc;
  }
}
