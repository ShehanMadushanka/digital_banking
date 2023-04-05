import 'dart:convert';

PersonalInformation personalInformationFromJson(String str) =>
    PersonalInformation.fromJson(json.decode(str));

String personalInformationToJson(PersonalInformation data) =>
    json.encode(data.toJson());

class PersonalInformation {
  PersonalInformation({
    this.title,
    this.initials,
    this.initialsInFull,
    this.lastName,
    this.nationality,
    this.gender,
    this.maritalStatus,
    this.language,
    this.religion,
    this.nic,
    this.dateOfBirth,
  });

  String title;
  String initials;
  String initialsInFull;
  String lastName;
  String nationality;
  String gender;
  String maritalStatus;
  String language;
  String religion;
  String nic;
  String dateOfBirth;

  factory PersonalInformation.fromJson(Map<String, dynamic> json) =>
      PersonalInformation(
        title: json["title"],
        initials: json["initials"],
        initialsInFull: json["initialsInFull"],
        lastName: json["lastName"],
        nationality: json["nationality"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        language: json["language"],
        religion: json["religion"],
        nic: json["nic"],
        dateOfBirth: json["dateOfBirth"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "initials": initials,
        "initialsInFull": initialsInFull,
        "lastName": lastName,
        "nationality": nationality,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "language": language,
        "religion": religion,
        "nic": nic,
        "dateOfBirth": dateOfBirth,
      };
}
