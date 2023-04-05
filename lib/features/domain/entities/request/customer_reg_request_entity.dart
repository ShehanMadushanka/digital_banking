import '../../../data/models/requests/customer_reg_request.dart';

class CustomerRegistrationRequestEntity extends CustomerRegistrationRequest {
  CustomerRegistrationRequestEntity({this.messageType, this.title, this.initials, this.initialsInFull, this.lastName, this.nationality, this.gender, this.language, this.religion, this.nic, this.dateOfBirth, this.mobileNo, this.email, this.maritalStatus, this.mothersMaidenName, this.perAddress}) : super(
      title: title,
      initials: initials,
      initialsInFull: initialsInFull,
      lastName: lastName,
      nationality: nationality,
      gender: gender,
      language: language,
      religion: religion,
      nic: nic,
      dateOfBirth: dateOfBirth,
      mobileNo: mobileNo,
      email: email,
      maritalStatus: maritalStatus,
      mothersMaidenName: mothersMaidenName,
      perAddress: perAddress,
      messageType: messageType
  );



  final String messageType;
  final String title;
  final String initials;
  final String initialsInFull;
  final String lastName;
  final String nationality;
  final String gender;
  final String language;
  final String religion;
  final String nic;
  final String dateOfBirth;
  final String mobileNo;
  final String email;
  final String maritalStatus;
  final String mothersMaidenName;
  final List<PerAddress> perAddress;
}