// To parse this JSON data, do
//
//     final forgotPasswordUserNameResponseModel = forgotPasswordUserNameResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

ForgotPasswordUserNameResponseModel forgotPasswordUserNameResponseModelFromJson(String str) => ForgotPasswordUserNameResponseModel.fromJson(json.decode(str));

String forgotPasswordUserNameResponseModelToJson(ForgotPasswordUserNameResponseModel data) => json.encode(data.toJson());

class ForgotPasswordUserNameResponseModel extends Serializable{
  ForgotPasswordUserNameResponseModel({
    this.otpReferenceNo,
    this.email,
    this.mobile,
  });

  String otpReferenceNo;
  String email;
  String mobile;

  factory ForgotPasswordUserNameResponseModel.fromJson(Map<String, dynamic> json) => ForgotPasswordUserNameResponseModel(
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
