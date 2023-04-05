import 'dart:convert';
import 'package:cdb_mobile/features/data/models/ui/contact_information.dart';
import 'package:cdb_mobile/features/data/models/ui/personal_information.dart';

OnBoardingData onBoardingDataFromJson(String str) =>
    OnBoardingData.fromJson(json.decode(str));

String onBoardingDataToJson(OnBoardingData data) => json.encode(data.toJson());

class OnBoardingData {
  OnBoardingData({
    this.stepperValue,
    this.onBoardingData,
    this.stepperName,
  });

  String stepperName;
  int stepperValue;
  UserInformation onBoardingData;

  factory OnBoardingData.fromJson(Map<String, dynamic> json) => OnBoardingData(
        stepperName: json["stepperName"],
        stepperValue: json["stepperValue"],
        onBoardingData: json["onBoardingData"] == null
            ? null
            : UserInformation.fromJson(json["onBoardingData"]),
      );

  Map<String, dynamic> toJson() => {
        "stepperName": stepperName,
        "stepperValue": stepperValue,
        "onBoardingData":
            onBoardingData == null ? null : onBoardingData.toJson(),
      };
}

class UserInformation {
  UserInformation({
    this.personalInformation,
    this.contactInformation,
  });

  PersonalInformation personalInformation;
  ContactInformation contactInformation;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
        personalInformation: json["personalInfo"] != null
            ? PersonalInformation.fromJson(json["personalInfo"])
            : null,
        contactInformation: json["contactInformation"] != null
            ? ContactInformation.fromJson(json["contactInformation"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "personalInfo":
            personalInformation != null ? personalInformation.toJson() : null,
        "contactInformation":
            contactInformation != null ? contactInformation.toJson() : null,
      };
}
