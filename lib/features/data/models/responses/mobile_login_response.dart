// To parse this JSON data, do
//
//     final mobileLoginResponse = mobileLoginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

class MobileLoginResponse extends Serializable{
  MobileLoginResponse({
    this.accessToken,
    this.refreshToken,
    this.tokenExpiresIn,
    this.viewAllOptions,
    this.otpVerificationRequired,
    this.otpResponseDto,
  });

  String accessToken;
  String refreshToken;
  int tokenExpiresIn;
  bool viewAllOptions;
  bool otpVerificationRequired;
  OtpResponseDto otpResponseDto;

  factory MobileLoginResponse.fromRawJson(String str) => MobileLoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MobileLoginResponse.fromJson(Map<String, dynamic> json) => MobileLoginResponse(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    tokenExpiresIn: json["tokenExpiresIn"],
    viewAllOptions: json["viewAllOptions"],
    otpVerificationRequired: json["otpVerificationRequired"],
    otpResponseDto: json["otpResponseDTO"] !=null?OtpResponseDto.fromJson(json["otpResponseDTO"]):OtpResponseDto(),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "tokenExpiresIn": tokenExpiresIn,
    "viewAllOptions": viewAllOptions,
    "otpVerificationRequired": otpVerificationRequired,
    "otpResponseDTO": otpResponseDto.toJson(),
  };
}

class OtpResponseDto {
  OtpResponseDto({
    this.otpReferenceNo,
    this.otpMessageType,
    this.otpMsType,
    this.email,
    this.mobile,
  });

  String otpReferenceNo;
  String otpMessageType;
  String otpMsType;
  String email;
  String mobile;

  factory OtpResponseDto.fromRawJson(String str) => OtpResponseDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpResponseDto.fromJson(Map<String, dynamic> json) => OtpResponseDto(
    otpReferenceNo: json["otpReferenceNo"],
    otpMessageType: json["otpMessageType"],
    otpMsType: json["otpMsType"],
    email: json["email"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "otpReferenceNo": otpReferenceNo,
    "otpMessageType": otpMessageType,
    "otpMsType": otpMsType,
    "email": email,
    "mobile": mobile,
  };
}
