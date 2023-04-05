import '../base_state.dart';

abstract class OTPState extends BaseState<OTPState> {}

class InitialOTPState extends OTPState {}

class OTPVerificationSuccessState extends OTPState {}

class OTPVerificationFailedState extends OTPState {
  final String message;

  OTPVerificationFailedState({this.message});
}

class OTPRequestSuccessState extends OTPState {
  final String otpReferenceNo;
  final String mobile;
  final String email;

  OTPRequestSuccessState({this.otpReferenceNo, this.mobile, this.email});
}

class OTPRequestFailedState extends OTPState {
  final String message;

  OTPRequestFailedState({this.message});
}
