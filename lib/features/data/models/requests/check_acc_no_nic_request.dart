// To parse this JSON data, do
//
//     final checkAccountNoNicRequest = checkAccountNoNicRequestFromJson(jsonString);

import 'dart:convert';

CheckAccountNoNicRequest checkAccountNoNicRequestFromJson(String str) => CheckAccountNoNicRequest.fromJson(json.decode(str));

String checkAccountNoNicRequestToJson(CheckAccountNoNicRequest data) => json.encode(data.toJson());

class CheckAccountNoNicRequest {
  CheckAccountNoNicRequest({
    this.messageType,
    this.accountNumber,
    this.nic,
  });

  String messageType;
  String accountNumber;
  String nic;

  factory CheckAccountNoNicRequest.fromJson(Map<String, dynamic> json) => CheckAccountNoNicRequest(
    messageType: json["messageType"],
    accountNumber: json["accountNumber"],
    nic: json["nic"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "accountNumber": accountNumber,
    "nic": nic,
  };
}
