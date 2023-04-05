import '../base_event.dart';

abstract class OTPEvent extends BaseEvent {}

class OTPVerificationEvent extends OTPEvent {
  final String otpReferenceNo;
  final String otp;
  final String otpMessageType;

  OTPVerificationEvent({this.otpReferenceNo, this.otp, this.otpMessageType});
}

class RequestOTPEvent extends OTPEvent {}
