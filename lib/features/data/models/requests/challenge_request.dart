// To parse this JSON data, do
//
//     final challengeRequest = challengeRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

ChallengeRequest challengeRequestFromJson(String str) =>
    ChallengeRequest.fromJson(json.decode(str));

String challengeRequestToJson(ChallengeRequest data) =>
    json.encode(data.toJson());

class ChallengeRequest extends Equatable {
  const ChallengeRequest({
    this.messageType,
    this.otp,
    this.otpReferenceNo,
    this.otpMessageType,
    this.deviceId
  });

  final String messageType;
  final String otp;
  final String otpReferenceNo;
  final String otpMessageType;
  final String deviceId;

  factory ChallengeRequest.fromJson(Map<String, dynamic> json) =>
      ChallengeRequest(
        messageType: json["messageType"],
        otp: json["otpPin"],
        otpReferenceNo: json["otpReferenceNo"],
        otpMessageType: json["otpMessageType"],
        deviceId: json["deviceId"],
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "otpPin": otp,
        "otpReferenceNo": otpReferenceNo,
        "otpMessageType": otpMessageType,
        "deviceId": deviceId,
      };

  @override
  List<Object> get props => [messageType, otp, otpReferenceNo, otpMessageType];
}
