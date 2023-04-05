import '../../../../data/models/requests/customer_reg_request.dart';
import '../../base_event.dart';


abstract class PersonalInformationEvent extends BaseEvent {}

/// Get Personal Information
class GetPersonalInformationEvent extends PersonalInformationEvent {
}

/// Store Personal Information
class StorePersonalInformationEvent extends PersonalInformationEvent {

  final int stepValue;
  final String stepName;
  final CustomerRegistrationRequest customerRegistrationRequest;
  final bool isBackButtonClick;

  StorePersonalInformationEvent({this.customerRegistrationRequest,this.stepName,this.stepValue,this.isBackButtonClick});
}

/// Verify NIC
class VerifyNICEvent extends PersonalInformationEvent {
  final String nic;
  final String dob;

  VerifyNICEvent({this.nic,this.dob});
}

/// Submit Personal Info API event
class SubmitPersonalInfoEvent extends PersonalInformationEvent {
  final String title;
  final String language;
  final String religion;
  final String dateOfBirth;
  final String initials;
  final String initialsInFull;
  final String lastName;
  final String nationality;
  final String gender;
  final String nic;
  final String martialStatus;
  final String mothersMaidenName;

  SubmitPersonalInfoEvent({this.title, this.language, this.religion, this.dateOfBirth, this.initials, this.initialsInFull, this.lastName, this.nationality, this.gender, this.nic, this.martialStatus, this.mothersMaidenName});


}

