// To parse this JSON data, do
//
//     final checkAccountNoNicResponse = checkAccountNoNicResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

CheckAccountNoNicResponse checkAccountNoNicResponseFromJson(String str) => CheckAccountNoNicResponse.fromJson(json.decode(str));

String checkAccountNoNicResponseToJson(CheckAccountNoNicResponse data) => json.encode(data.toJson());

class CheckAccountNoNicResponse extends Serializable{
  CheckAccountNoNicResponse({
    this.otpReferenceNo,
    this.email,
    this.mobile,
  });

  String otpReferenceNo;
  String email;
  String mobile;

  factory CheckAccountNoNicResponse.fromJson(Map<String, dynamic> json) => CheckAccountNoNicResponse(
    otpReferenceNo: json["otpReferenceNo"],
    email: json["email"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "otpReferenceNo": otpReferenceNo,
    "email": email,
    "mobile": mobile,
  };
}
