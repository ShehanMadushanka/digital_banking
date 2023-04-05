// To parse this JSON data, do
//
//     final favouriteBillerRequest = favouriteBillerRequestFromJson(jsonString);

import 'dart:convert';

DeleteBillerRequest favouriteBillerRequestFromJson(String str) => DeleteBillerRequest.fromJson(json.decode(str));

String favouriteBillerRequestToJson(DeleteBillerRequest data) => json.encode(data.toJson());

class DeleteBillerRequest {
  DeleteBillerRequest({
    this.messageType,
    this.billerId,
  });

  final String messageType;
  final int billerId;

  factory DeleteBillerRequest.fromJson(Map<String, dynamic> json) => DeleteBillerRequest(
    messageType: json["messageType"],
    billerId: json["billerId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "billerId": billerId,
  };
}
