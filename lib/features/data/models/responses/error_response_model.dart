import 'dart:convert';

import 'package:cdb_mobile/features/domain/entities/response/error_response.dart';

ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());

class ErrorResponseModel extends ErrorResponse {
  ErrorResponseModel({
    this.errorCode,
    this.errorDescription,
  });

  String errorCode;
  String errorDescription;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
        errorCode: json["errorCode"],
        errorDescription: json["errorDescription"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorDescription": errorDescription,
      };
}
