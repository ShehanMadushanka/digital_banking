import '../../../data/models/requests/verify_nic_request.dart';


class VerifyNICRequestEntity extends VerifyNicRequest {
  VerifyNICRequestEntity({
    nic,
    messageType,
    dob
  }) : super(
      nic: nic,
      messageType: messageType, dob: dob);
}
