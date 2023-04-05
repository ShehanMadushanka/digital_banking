// To parse this JSON data, do
//
//     final forgotPasswordUserNameResponseModel = forgotPasswordUserNameResponseModelFromJson(jsonString);

import 'dart:convert';

ForgotPasswordUserNameResponseEntity forgotPasswordUserNameResponseModelFromJson(String str) => ForgotPasswordUserNameResponseEntity.fromJson(json.decode(str));

String forgotPasswordUserNameResponseModelToJson(ForgotPasswordUserNameResponseEntity data) => json.encode(data.toJson());

class ForgotPasswordUserNameResponseEntity {
  ForgotPasswordUserNameResponseEntity({
    this.otpReferenceNo,
    this.email,
    this.mobile,
  });

  String otpReferenceNo;
  String email;
  String mobile;

  factory ForgotPasswordUserNameResponseEntity.fromJson(Map<String, dynamic> json) => ForgotPasswordUserNameResponseEntity(
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
