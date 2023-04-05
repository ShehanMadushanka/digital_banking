// To parse this JSON data, do
//
//     final baseRequest = baseRequestFromJson(jsonString);

import 'dart:convert';

BaseRequest baseRequestFromJson(String str) => BaseRequest.fromJson(json.decode(str));

String baseRequestToJson(BaseRequest data) => json.encode(data.toJson());

class BaseRequest {
  BaseRequest({
    this.deviceChannel,
    this.messageVersion,
    this.deviceInfo,
    this.epicTransId,
    this.epicUserId,
    this.appId,
    this.appMaxTimeout,
    this.appReferenceNumber,
    this.appTransId,
    this.ghostId,
  });

  String deviceChannel;
  String messageVersion;
  String deviceInfo;
  String epicTransId;
  String epicUserId;
  String messageType;
  String appId;
  String appMaxTimeout;
  String appReferenceNumber;
  String appTransId;
  String ghostId;

  factory BaseRequest.fromJson(Map<String, dynamic> json) => BaseRequest(
        deviceChannel: json["deviceChannel"],
        messageVersion: json["messageVersion"],
        deviceInfo: json["deviceInfo"],
        epicTransId: json["epicTransId"],
        epicUserId: json["epicUserId"],
        appId: json["appID"],
        appMaxTimeout: json["appMaxTimeout"],
        appReferenceNumber: json["appReferenceNumber"],
        appTransId: json["appTransID"],
        ghostId: json["ghostId"],
      );

  Map<String, dynamic> toJson() => {
        "deviceChannel": deviceChannel,
        "messageVersion": messageVersion,
        "deviceInfo": deviceInfo,
        "epicTransId": epicTransId,
        "epicUserId": epicUserId,
        "appID": appId,
        "appMaxTimeout": appMaxTimeout,
        "appReferenceNumber": appReferenceNumber,
        "appTransID": appTransId,
        "ghostId": ghostId,
      };
}
