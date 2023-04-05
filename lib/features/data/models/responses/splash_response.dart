import 'dart:convert';

import '../common/base_response.dart';

SplashResponse splashResponseFromJson(String str) =>
    SplashResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String splashResponseToJson(SplashResponse data) => json.encode(data.toJson());

class SplashResponse extends Serializable {
  SplashResponse({
    this.data,
  }) : super();

  Data data;

  factory SplashResponse.fromJson(Map<String, dynamic> json) => SplashResponse(
        data: Data.fromJson(json),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.userNamePolicy,
    this.passwordPolicy,
    this.forceUpdate,
    this.mandatoryUpdate,
  });

  UserNamePolicy userNamePolicy;
  Map<String, int> passwordPolicy;
  bool forceUpdate;
  bool mandatoryUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userNamePolicy: UserNamePolicy.fromJson(
            json["userNamePolicy"] as Map<String, dynamic>),
        passwordPolicy: Map.from(json["passwordPolicy"] as Map<String, dynamic>)
            .map((k, v) => MapEntry<String, int>(k as String, v as int)),
        forceUpdate: json["isForceUpdate"] as bool,
        mandatoryUpdate: json["isMandatoryUpdate"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "userNamePolicy": userNamePolicy.toJson(),
        "passwordPolicy": Map.from(passwordPolicy)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "forceUpdate": forceUpdate,
        "mandatoryUpdate": mandatoryUpdate,
      };
}

class UserNamePolicy {
  UserNamePolicy({
    this.minLength,
    this.maxLength,
    this.minimumSpecialChars,
    this.minimumUpperCaseChars,
    this.minimumLowercaseChars,
    this.minimumNumericalChars,
    this.repeatedChars,
  });

  int minLength;
  int maxLength;
  int minimumSpecialChars;
  int minimumUpperCaseChars;
  int minimumLowercaseChars;
  int minimumNumericalChars;
  int repeatedChars;

  factory UserNamePolicy.fromJson(Map<String, dynamic> json) => UserNamePolicy(
        minLength: json["minLength"] as int,
        maxLength: json["maxLength"] as int,
        minimumSpecialChars: json["minimumSpecialChars"],
        minimumUpperCaseChars: json["minimumUpperCaseChars"],
        minimumLowercaseChars: json["minimumLowercaseChars"],
        minimumNumericalChars: json["minimumNumericalChars"],
        repeatedChars: json["repeatedChars"],
      );

  Map<String, dynamic> toJson() => {
        "minLength": minLength,
        "maxLength": maxLength,
        "minimumSpecialChars": minimumSpecialChars,
        "minimumUpperCaseChars": minimumUpperCaseChars,
        "minimumLowercaseChars": minimumLowercaseChars,
        "minimumNumericalChars": minimumNumericalChars,
        "repeatedChars": repeatedChars,
      };
}
