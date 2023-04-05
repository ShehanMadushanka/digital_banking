// To parse this JSON data, do
//
//     final contactUsResponseModel = contactUsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

ContactUsResponseModel contactUsResponseModelFromJson(String str) => ContactUsResponseModel.fromJson(json.decode(str));

String contactUsResponseModelToJson(ContactUsResponseModel data) => json.encode(data.toJson());

class ContactUsResponseModel extends Serializable{
  ContactUsResponseModel({
    this.companyName,
    this.telNo,
    this.email,
    this.busAddLine1,
    this.busAddLine2,
    this.busAddLine3,
  });

  String companyName;
  String telNo;
  String email;
  String busAddLine1;
  String busAddLine2;
  String busAddLine3;

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) => ContactUsResponseModel(
    companyName: json["companyName"],
    telNo: json["telNo"],
    email: json["email"],
    busAddLine1: json["busAddLine1"],
    busAddLine2: json["busAddLine2"],
    busAddLine3: json["busAddLine3"],
  );

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "telNo": telNo,
    "email": email,
    "busAddLine1": busAddLine1,
    "busAddLine2": busAddLine2,
    "busAddLine3": busAddLine3,
  };
}
