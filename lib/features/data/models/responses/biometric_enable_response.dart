// To parse this JSON data, do
//
//     final biometricEnableResponse = biometricEnableResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

class BiometricEnableResponse extends Serializable{
  BiometricEnableResponse({
    this.uniqueCode,
  });

  String uniqueCode;

  factory BiometricEnableResponse.fromRawJson(String str) => BiometricEnableResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BiometricEnableResponse.fromJson(Map<String, dynamic> json) => BiometricEnableResponse(
    uniqueCode: json["uniqueCode"],
  );

  Map<String, dynamic> toJson() => {
    "uniqueCode": uniqueCode,
  };
}
