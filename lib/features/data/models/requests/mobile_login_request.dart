// To parse this JSON data, do
//
//     final mobileLoginRequest = mobileLoginRequestFromJson(jsonString);

import 'dart:convert';

class MobileLoginRequest {
  MobileLoginRequest({
    this.username,
    this.password,
    this.messageType,
  });

  String username;
  String password;
  String messageType;

  factory MobileLoginRequest.fromRawJson(String str) => MobileLoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileLoginRequest.fromJson(Map<String, dynamic> json) => MobileLoginRequest(
    username: json["username"],
    password: json["password"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "messageType": messageType,
  };
}
