// To parse this JSON data, do
//
//     final biometricLoginRequest = biometricLoginRequestFromJson(jsonString);

import 'dart:convert';

class BiometricLoginRequest {
  BiometricLoginRequest({
    this.uniqueCode,
    this.messageType,
  });

  String uniqueCode;
  String messageType;

  factory BiometricLoginRequest.fromRawJson(String str) => BiometricLoginRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BiometricLoginRequest.fromJson(Map<String, dynamic> json) => BiometricLoginRequest(
    uniqueCode: json["uniqueCode"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "uniqueCode": uniqueCode,
    "messageType": messageType,
  };
}
