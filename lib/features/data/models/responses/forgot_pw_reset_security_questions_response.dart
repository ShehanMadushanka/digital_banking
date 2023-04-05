// To parse this JSON data, do
//
//     final forgotPwResetSecQuestionsResponseModel = forgotPwResetSecQuestionsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

ForgotPwResetSecQuestionsResponseModel forgotPwResetSecQuestionsResponseModelFromJson(String str) => ForgotPwResetSecQuestionsResponseModel.fromJson(json.decode(str));

String forgotPwResetSecQuestionsResponseModelToJson(ForgotPwResetSecQuestionsResponseModel data) => json.encode(data.toJson());

class ForgotPwResetSecQuestionsResponseModel extends Serializable{
  ForgotPwResetSecQuestionsResponseModel({
    this.otpReferenceNo,
    this.mobile,
    this.email,
  });

  String otpReferenceNo;
  String mobile;
  String email;

  factory ForgotPwResetSecQuestionsResponseModel.fromJson(Map<String, dynamic> json) => ForgotPwResetSecQuestionsResponseModel(
    otpReferenceNo: json["otpReferenceNo"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "otpReferenceNo": otpReferenceNo,
    "mobile": mobile,
    "email": email,
  };
}
