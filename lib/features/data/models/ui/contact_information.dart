import 'dart:convert';

import 'package:cdb_mobile/features/data/models/requests/customer_reg_request.dart';

ContactInformation contactInformationFromJson(String str) =>
    ContactInformation.fromJson(json.decode(str));

String contactInformationToJson(ContactInformation data) =>
    json.encode(data.toJson());

class ContactInformation {
  ContactInformation({
    this.mobileNo,
    this.email,
    this.perAddress,
  });

  String mobileNo;
  String email;
  List<PerAddress> perAddress;

  factory ContactInformation.fromJson(Map<String, dynamic> json) =>
      ContactInformation(
        mobileNo: json["mobileNo"],
        email: json["email"],
        perAddress: List<PerAddress>.from(
            json["perAddress"].map((x) => PerAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mobileNo": mobileNo,
        "email": email,
        "perAddress": List<dynamic>.from(perAddress.map((x) => x.toJson())),
      };
}
