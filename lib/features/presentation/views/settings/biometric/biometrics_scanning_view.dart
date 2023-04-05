import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/biometric_helper.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/on_boarding/biometric/biometric_bloc.dart';
import '../../../bloc/on_boarding/biometric/biometric_event.dart';
import '../../../bloc/on_boarding/biometric/biometric_state.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_toast/cdb_toast.dart';
import '../../base_view.dart';

class BiometricsScanningView extends BaseView {
  const BiometricsScanningView({Key key}) : super(key: key);

  @override
  _BiometricsScanningViewState createState() => _BiometricsScanningViewState();
}

class _BiometricsScanningViewState
    extends BaseViewState<BiometricsScanningView> {
  final _biometricBloc = inject<BiometricBloc>();
  bool _initialAuthentication = true;
  BiometricHelper _biometricHelper;
  bool _isBiometricAvailable = false;
  bool _isAuthenticated = false;

  // BiometricType _biometricType;

  @override
  void initState() {
    super.initState();
    _biometricHelper = BiometricHelper();
    _biometricHelper.isBiometricAvailable().then((value) {
      setState(() {
        _isBiometricAvailable = value;
      });
    });
    // _biometricHelper.getListOfBiometricTypes().then((value) {
    //   setState(() {
    //     _biometricType = value;
    //   });
    // });
  }

  Future<void> _authenticateUsingBiometrics() async {
    if (_isBiometricAvailable) {
      if (await _biometricHelper.authenticateUser()) {
        _initialAuthentication = false;
        _isAuthenticated = true;
      } else {
        _initialAuthentication = false;
        _isAuthenticated = false;
      }

      setState(() {});
    }
  }

  @override
  Widget buildView(BuildContext context) {
    if (_initialAuthentication && !_isAuthenticated) {
      _authenticateUsingBiometrics();
    }

    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.biometricsVerificationTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _biometricBloc,
        child: BlocListener(
          bloc: _biometricBloc,
          listener: (_, state) {
            if (state is EnableBiometricSuccessState) {
              _biometricBloc.add(SaveUserEvent());
            } else if (state is EnableBiometricFailedState) {
              ToastUtils.showCustomToast(
                  context, state.error, ToastStatus.fail);
            } else if (state is SaveUserSuccessState) {
              Navigator.pushReplacementNamed(
                  context, Routes.kScheduleVerificationView,
                  arguments: false);
            } else if (state is SaveUserFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: kLeftRightMarginOnBoarding,
              right: kLeftRightMarginOnBoarding,
              top: kTopMarginOnBoarding,
              bottom: kBottomMargin,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_initialAuthentication)
                        SvgPicture.asset(
                          AppImages.fingerPrintInitIcon,
                        )
                      else
                        Container(
                          child: _getBiometricIcon(),
                        ),
                      SizedBox(
                        height: 23.h,
                      ),
                      _getBiometricText(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CDBBorderGradientButton(
                      text: _isAuthenticated
                          ? AppString.done.localize(context)
                          : _initialAuthentication
                              ? AppString.saveFingerprint.localize(context)
                              : AppString.tryAgain.localize(context),
                      onTap: () async {
                        if (_isAuthenticated) {
                          _biometricBloc.add(EnableBiometricEvent(
                              shouldEnableBiometric: true));
                        } else {
                          await _authenticateUsingBiometrics();
                        }
                      },
                    ),
                    CDBNoBorderBackgroundButton(
                      onTap: () {
                        _biometricBloc.add(SaveUserEvent());
                      },
                      text: AppString.cancel.localize(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _getBiometricText() {
    if (_initialAuthentication && !_isAuthenticated) {
      return Text(
        AppString.touchIDInitial.localize(context),
        textAlign: TextAlign.center,
        style:
            AppStyling.normal400Size14.copyWith(color: AppColors.textDarkColor),
      );
    } else if (_isAuthenticated) {
      return Text(
        AppString.touchIDConfigurationSuccessful.localize(context),
        textAlign: TextAlign.center,
        style:
            AppStyling.normal400Size14.copyWith(color: AppColors.textDarkColor),
      );
    } else {
      return Text(
        AppString.touchIDConfigurationFailed.localize(context),
        textAlign: TextAlign.center,
        style:
            AppStyling.normal400Size14.copyWith(color: AppColors.textDarkColor),
      );
    }
  }

  SvgPicture _getBiometricIcon() {
    if (_initialAuthentication && !_isAuthenticated) {
      return SvgPicture.asset(AppImages.fingerPrintInitIcon);
    } else if (_isAuthenticated) {
      return SvgPicture.asset(
        AppImages.fingerPrintSuccessIcon,
      );
    } else {
      return SvgPicture.asset(AppImages.fingerPrintFailedIcon);
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _biometricBloc;
  }
}
