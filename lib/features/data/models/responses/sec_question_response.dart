// To parse this JSON data, do
//
//     final securityQuestionResponse = securityQuestionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

SecurityQuestionResponse securityQuestionResponseFromJson(String str) =>
    SecurityQuestionResponse.fromJson(json.decode(str));

String securityQuestionResponseToJson(SecurityQuestionResponse data) =>
    json.encode(data.toJson());

class SecurityQuestionResponse extends Serializable {
  SecurityQuestionResponse({
    this.data,
  });

  final List<SecurityQuestion> data;

  factory SecurityQuestionResponse.fromJson(Map<String, dynamic> json) =>
      SecurityQuestionResponse(
        data: List<SecurityQuestion>.from(
            json["data"].map((x) => SecurityQuestion.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SecurityQuestion {
  SecurityQuestion({
    this.id,
    this.description,
  });

  final int id;
  final String description;

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) =>
      SecurityQuestion(
        id: json["id"],
        description: json["secQuestion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "secQuestion": description,
      };
}
