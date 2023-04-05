// To parse this JSON data, do
//
//     final forgotPwCreateNewPasswordRequestModel = forgotPwCreateNewPasswordRequestModelFromJson(jsonString);

import 'dart:convert';

ForgotPwCreateNewPasswordRequestModel forgotPwCreateNewPasswordRequestModelFromJson(String str) => ForgotPwCreateNewPasswordRequestModel.fromJson(json.decode(str));

String forgotPwCreateNewPasswordRequestModelToJson(ForgotPwCreateNewPasswordRequestModel data) => json.encode(data.toJson());

class ForgotPwCreateNewPasswordRequestModel {
  ForgotPwCreateNewPasswordRequestModel({
    this.messageType,
    this.username,
    this.newPassword,
    this.confirmPassword,
  });

  String messageType;
  String username;
  String newPassword;
  String confirmPassword;

  factory ForgotPwCreateNewPasswordRequestModel.fromJson(Map<String, dynamic> json) => ForgotPwCreateNewPasswordRequestModel(
    messageType: json["messageType"],
    username: json["username"],
    newPassword: json["newPassword"],
    confirmPassword: json["confirmPassword"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "username": username,
    "newPassword": newPassword,
    "confirmPassword": confirmPassword,
  };
}
