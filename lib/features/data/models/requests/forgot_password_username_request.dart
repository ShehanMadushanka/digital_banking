// To parse this JSON data, do
//
//     final usernameIdentityRequestModel = usernameIdentityRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ForgotPasswordUserNameRequestModel usernameIdentityRequestModelFromJson(String str) =>
    ForgotPasswordUserNameRequestModel.fromJson(json.decode(str));

String usernameIdentityRequestModelToJson(ForgotPasswordUserNameRequestModel data) =>
    json.encode(data.toJson());

class ForgotPasswordUserNameRequestModel {
  ForgotPasswordUserNameRequestModel({
    this.messageType,
    this.clientTransId = "b2385523-a66c-4907-ac3c-91848e8c0067",
    this.username,
    this.nic,
  });

  String messageType;
  String clientTransId;
  String username;
  String nic;

  factory ForgotPasswordUserNameRequestModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordUserNameRequestModel(
        messageType: json["messageType"],
        clientTransId: json["clientTransId"],
        username: json["username"],
        nic: json["nic"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "clientTransId": clientTransId,
        "username": username,
        "nic": nic,
      };
}
