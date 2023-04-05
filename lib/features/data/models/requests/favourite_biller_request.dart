// To parse this JSON data, do
//
//     final favouriteBillerRequest = favouriteBillerRequestFromJson(jsonString);

import 'dart:convert';

FavouriteBillerRequest favouriteBillerRequestFromJson(String str) => FavouriteBillerRequest.fromJson(json.decode(str));

String favouriteBillerRequestToJson(FavouriteBillerRequest data) => json.encode(data.toJson());

class FavouriteBillerRequest {
  FavouriteBillerRequest({
    this.messageType,
    this.billerId,
  });

  final String messageType;
  final int billerId;

  factory FavouriteBillerRequest.fromJson(Map<String, dynamic> json) => FavouriteBillerRequest(
    messageType: json["messageType"],
    billerId: json["billerId"],
  );

  Map<String, dynamic> toJson() => {
    "messageType": messageType,
    "billerId": billerId,
  };
}
