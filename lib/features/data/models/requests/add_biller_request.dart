// To parse this JSON data, do
//
//     final addBillerRequest = addBillerRequestFromJson(jsonString);

import 'dart:convert';

class AddBillerRequest {
  AddBillerRequest({
    this.nickName,
    this.serviceProviderId,
    this.fieldList,
    this.messageType
  });

  String nickName;
  String messageType;
  int serviceProviderId;
  List<FieldList> fieldList;

  factory AddBillerRequest.fromRawJson(String str) => AddBillerRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddBillerRequest.fromJson(Map<String, dynamic> json) => AddBillerRequest(
    nickName: json["nickName"],
    messageType: json["messageType"],
    serviceProviderId: json["serviceProviderId"],
    fieldList: List<FieldList>.from(json["fieldList"].map((x) => FieldList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nickName": nickName,
    "messageType": messageType,
    "serviceProviderId": serviceProviderId,
    "fieldList": List<dynamic>.from(fieldList.map((x) => x.toJson())),
  };
}

class FieldList {
  FieldList({
    this.customFieldId,
    this.customFieldValue,
  });

  String customFieldId;
  String customFieldValue;

  factory FieldList.fromRawJson(String str) => FieldList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FieldList.fromJson(Map<String, dynamic> json) => FieldList(
    customFieldId: json["customFieldId"],
    customFieldValue: json["customFieldValue"],
  );

  Map<String, dynamic> toJson() => {
    "customFieldId": customFieldId,
    "customFieldValue": customFieldValue,
  };
}
