import '../../../../data/models/requests/customer_reg_request.dart';
import '../../base_event.dart';

abstract class ContactInformationEvent extends BaseEvent {}

/// Get Personal Information
class GetContactInformationEvent extends ContactInformationEvent {}

/// Store Personal Information
class StoreContactInformationEvent extends ContactInformationEvent {
  final int stepValue;
  final String stepName;
  final CustomerRegistrationRequest customerRegistrationRequest;
  final bool isBackButtonClick;

  StoreContactInformationEvent(
      {this.customerRegistrationRequest,
      this.stepName,
      this.stepValue,
      this.isBackButtonClick});
}

class SubmitCusRegEvent extends ContactInformationEvent {
  String mobileNo;
  String email;
  String address1;
  String address2;
  String address3;
  int city;
  bool isAddSameAsNIC;

  SubmitCusRegEvent(
      {this.mobileNo,
      this.email,
      this.address1,
      this.address2,
      this.address3,
      this.city,
      this.isAddSameAsNIC});
}

/// Store And Navigate
// class StoreContactInfoAndNavigateForwardEvent extends ContactInformationEvent {
//   final int stepValue;
//   final String stepName;
//
//   StoreContactInfoAndNavigateForwardEvent({this.stepValue, this.stepName});
// }
