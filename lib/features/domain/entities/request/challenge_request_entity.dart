import '../../../data/models/requests/challenge_request.dart';

class ChallengeRequestEntity extends ChallengeRequest {
  final String messageType;
  final String otp;
  final String otpReferenceNo;
  final String otpMessageType;
  final String deviceId;

  const ChallengeRequestEntity(
      {this.messageType,
      this.otp,
      this.otpReferenceNo,
      this.otpMessageType,
      this.deviceId})
      : super(
            messageType: messageType,
            otp: otp,
            otpMessageType: otpMessageType,
            otpReferenceNo: otpReferenceNo,
            deviceId: deviceId);
}
