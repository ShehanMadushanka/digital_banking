import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/otp/otp_bloc.dart';
import '../../bloc/otp/otp_event.dart';
import '../../bloc/otp/otp_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_otp_view.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class OTPViewArgs {
  final String otpType;
  final bool requestOTP;
  final String otpReference;

  OTPViewArgs({this.otpType, this.requestOTP = false, this.otpReference});
}

class OTPView extends BaseView {
  final OTPViewArgs args;

  const OTPView({Key key, this.args}) : super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends BaseViewState<OTPView>
    with TickerProviderStateMixin {
  String _mobileNumber = '';
  OTPCountDown _otpCountDown;
  String _otpReference = '';
  final int _otpTimeInMS = 1000 * 1 * 60;
  bool _isCountDownFinished = false;
  String _countDown;
  String otp;
  ButtonStatus _submitButtonStatus = ButtonStatus.DISABLE;
  final TextEditingController _otpController = TextEditingController();

  final _bloc = inject<OTPBloc>();

  @override
  void initState() {
    super.initState();

    if (widget.args.requestOTP) _bloc.add(RequestOTPEvent());
    if (widget.args.otpReference != null && widget.args.otpReference.isNotEmpty)
      _otpReference = widget.args.otpReference;
  }

  void _startCountDown() {
    _isCountDownFinished = false;
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        _isCountDownFinished = true;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    if (_otpCountDown != null) {
      _otpCountDown.cancelTimer();
    }
    if (_otpController != null) {
      // _otpController.dispose();
    }
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDarkColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16, bottom: bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: BlocProvider<OTPBloc>(
                    create: (_) => _bloc,
                    child: BlocListener<OTPBloc, BaseState<OTPState>>(
                      bloc: _bloc,
                      listener: (_, state) {
                        if (state is OTPVerificationSuccessState) {
                          if (_otpController != null) _otpController.clear();
                          Navigator.pop(context, true);
                        } else if (state is OTPVerificationFailedState) {
                          if (_otpController != null) _otpController.clear();
                          ToastUtils.showCustomToast(
                              context, state.message, ToastStatus.fail);
                        } else if (state is OTPRequestSuccessState) {
                          _mobileNumber =
                              state.mobile.replaceAll("\\d(?=\\d{4})", "*");
                          _otpReference = state.otpReferenceNo;
                          _startCountDown();
                        } else if (state is OTPRequestFailedState) {
                          ToastUtils.showCustomToast(
                              context, state.message, ToastStatus.fail);
                          Navigator.pop(context, false);
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset(AppImages.mobileVerificationIcon),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Mobile Number Verification",
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text.rich(
                            TextSpan(
                              text:
                                  "We sent a SMS with a 6 digit code to\nyour mobile number ",
                              children: [
                                TextSpan(
                                  text: _mobileNumber,
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textDarkColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Enter the 6 digit code",
                            style: AppStyling.normal600Size16
                                .copyWith(color: AppColors.textDarkColor),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: CDBOtpView(
                              controller: _otpController,
                              length: 6,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              activeColor: AppColors.accentColor,
                              backgroundColor: Colors.transparent,
                              cellBackgroundColor: Colors.white,
                              inactiveColor: AppColors.accentColor,
                              disabledColor: AppColors.accentColor,
                              selectedColor: AppColors.accentColor,
                              animationType: AnimationType.fade,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onCompleted: (value) {
                                _submitButtonStatus = ButtonStatus.ENABLE;
                                setState(() {
                                  otp = value;
                                });
                              },
                              textInputType: TextInputType.number,
                              textStyle: AppStyling.normal500Size18
                                  .copyWith(color: AppColors.accentColor),
                              onChanged: (String value) {
                                if (value.length < 6) {
                                  setState(() {
                                    _submitButtonStatus = ButtonStatus.DISABLE;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (_isCountDownFinished)
                            GestureDetector(
                              onTap: () {
                                _bloc.add(RequestOTPEvent());
                              },
                              child: Text(
                                "Resend the 6 digit code",
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.accentColor),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Resend code in",
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  (_countDown != null) ? _countDown : '',
                                  style: AppStyling.bold600Size14
                                      .copyWith(color: AppColors.accentColor),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          const Spacer(),
                          Text.rich(
                            TextSpan(
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor),
                              children: <TextSpan>[
                                const TextSpan(text: 'Call for Assistance'),
                                const TextSpan(text: '  '),
                                TextSpan(
                                  text: '011 2678765',
                                  style: AppStyling.light300Size13.copyWith(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _makePhoneCall('tel:0112678765');
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: CDBBorderGradientButton(
                              status: _submitButtonStatus,
                              width: double.maxFinite,
                              onTap: () {
                                _bloc.add(OTPVerificationEvent(
                                    otp: otp,
                                    otpMessageType: widget.args.otpType,
                                    otpReferenceNo: _otpReference));
                              },
                              text: 'Submit',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      log('Could not launch $url');
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
