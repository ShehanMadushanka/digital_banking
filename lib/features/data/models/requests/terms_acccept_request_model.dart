import 'dart:convert';

TermsAcceptRequestModel termsAcceptRequestModelFromJson(String str) =>
    TermsAcceptRequestModel.fromJson(json.decode(str));

String termsAcceptRequestModelToJson(TermsAcceptRequestModel data) =>
    json.encode(data.toJson());

class TermsAcceptRequestModel {
  TermsAcceptRequestModel({
    this.termId,
    this.acceptedDate,
    this.messageType,
  });

  int termId;
  String acceptedDate;
  String messageType;

  factory TermsAcceptRequestModel.fromJson(Map<String, dynamic> json) =>
      TermsAcceptRequestModel(
        termId: json["termId"],
        acceptedDate: json["acceptedDate"],
        messageType: json["messageType"],
      );

  Map<String, dynamic> toJson() => {
        "termId": termId,
        "acceptedDate": acceptedDate,
        "messageType": messageType,
      };
}
