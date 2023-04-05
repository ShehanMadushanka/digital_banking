// To parse this JSON data, do
//
//     final createUserResponse = createUserResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

CreateUserResponse createUserResponseFromJson(String str) =>
    CreateUserResponse.fromJson(json.decode(str));

String createUserResponseToJson(CreateUserResponse data) =>
    json.encode(data.toJson());

class CreateUserResponse extends Serializable {
  CreateUserResponse({
    this.data,
  });

  final UserData data;

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) =>
      CreateUserResponse(
        data: UserData.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserData {
  UserData({
    this.epicUserId,
  });

  final String epicUserId;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        epicUserId: json["epicUserId"],
      );

  Map<String, dynamic> toJson() => {
        "epicUserId": epicUserId,
      };
}
