import 'package:cdb_mobile/features/presentation/bloc/on_boarding/biometric/biometric_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/biometric/biometric_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

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
import '../../bloc/on_boarding/biometric/biometric_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_header_underline.dart';
import '../base_view.dart';

class BiometricInformationView extends BaseView {
  const BiometricInformationView({Key key}) : super(key: key);

  @override
  _BiometricInformationViewState createState() =>
      _BiometricInformationViewState();
}

class _BiometricInformationViewState
    extends BaseViewState<BiometricInformationView> {
  final _biometricBloc = inject<BiometricBloc>();
  BiometricHelper _biometricHelper;
  bool _isBiometricAvailable = false;
  BiometricType _biometricType;

  @override
  void initState() {
    super.initState();
    _biometricHelper = BiometricHelper();
    _biometricHelper.isBiometricAvailable().then((value) => setState(() {
          _isBiometricAvailable = value;
        }));

    _biometricHelper.getListOfBiometricTypes().then((value) {
      setState(() {
        _biometricType = value;
      });
    });
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BiometricBloc>(
        create: (_)=>_biometricBloc,
        child: BlocListener(
          bloc: _biometricBloc,
          listener: (_, state){
            if (state is SaveUserSuccessState) {
              Navigator.pushReplacementNamed(
                  context, Routes.kScheduleVerificationView, arguments: false);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppString.addYourBiometric.localize(context),
                  style: AppStyling.normal500Size16
                      .copyWith(color: AppColors.textDarkColor),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 2), child: CdbHeaderUnderline()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _biometricType == BiometricType.face
                            ? AppImages.biometricFaceIcon
                            : AppImages.biometricTouchIDIcon,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        AppString.biometricPageDescription.localize(context),
                        style: AppStyling.normal400Size14
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CDBBorderGradientButton(
                      text: _biometricType == BiometricType.face
                          ? AppString.turnOnFaceId.localize(context)
                          : AppString.turnOnTouchId.localize(context),
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.kBioMetricConfiguration);
                      },
                    ),
                    CDBNoBorderBackgroundButton(
                      onTap: () {
                        _biometricBloc.add(SaveUserEvent());
                      },
                      text: AppString.skip.localize(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _biometricBloc;
  }
}
