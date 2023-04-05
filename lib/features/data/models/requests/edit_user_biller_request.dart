// To parse this JSON data, do
//
//     final editUserBillerRequest = editUserBillerRequestFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/requests/add_biller_request.dart';

EditUserBillerRequest editUserBillerRequestFromJson(String str) => EditUserBillerRequest.fromJson(json.decode(str));

String editUserBillerRequestToJson(EditUserBillerRequest data) => json.encode(data.toJson());

class EditUserBillerRequest {
  EditUserBillerRequest({
    this.messageType,
    this.nickName,
    this.serviceProviderId,
    this.billerId,
    this.categoryId,
    this.fieldList,
  });

  String messageType;
  String nickName;
  String serviceProviderId;
  int billerId;
  String categoryId;
  List<FieldList> fieldList;

  factory EditUserBillerRequest.fromJson(Map<String, dynamic> json) => EditUserBillerRequest(
    messageType: json["messageType"],
    nickName: json["nickName"],
    serviceProviderId: json["serviceProviderId"],
    billerId: json["billerId"],
    categoryId: json["categoryId"],
    fieldList: List<FieldList>.from(json["fieldList"].map((x) => FieldList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "nickName": nickName,
    "serviceProviderId": serviceProviderId,
    "billerId": billerId,
    "categoryId": categoryId,
    "fieldList": List<dynamic>.from(fieldList.map((x) => x.toJson())),
  };
}
