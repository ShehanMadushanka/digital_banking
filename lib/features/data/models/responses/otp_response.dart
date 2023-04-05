// To parse this JSON data, do
//
//     final otpRequest = otpRequestFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

OTPResponse otpRequestFromJson(String str) =>
    OTPResponse.fromJson(json.decode(str));

String otpRequestToJson(OTPResponse data) => json.encode(data.toJson());

class OTPResponse extends Serializable {
  OTPResponse({
    this.data,
  });

  final OTPData data;

  factory OTPResponse.fromJson(Map<String, dynamic> json) => OTPResponse(
        data: json == null ? null : OTPData.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class OTPData {
  OTPData({
    this.otpReferenceNo,
    this.mobile,
    this.email,
  });

  final String otpReferenceNo;
  final String mobile;
  final String email;

  factory OTPData.fromJson(Map<String, dynamic> json) => OTPData(
        otpReferenceNo: json["otpReferenceNo"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "otpReferenceNo": otpReferenceNo,
        "mobile": mobile,
        "email": email,
      };
}
