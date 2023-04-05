// To parse this JSON data, do
//
//     final cityDetailResponse = cityDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

CityDetailResponse cityDetailResponseFromJson(String str) => CityDetailResponse.fromJson(json.decode(str));

String cityDetailResponseToJson(CityDetailResponse data) => json.encode(data.toJson());

class CityDetailResponse extends Serializable {
  CityDetailResponse({
    this.data,
  });

  final List<CommonDropDownResponse> data;

  factory CityDetailResponse.fromJson(Map<String, dynamic> json) => CityDetailResponse(
        data: List<CommonDropDownResponse>.from(json["data"].map((x) => CommonDropDownResponse.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CommonDropDownResponse {
  CommonDropDownResponse({
    this.id,
    this.description,
    this.key,
  });

  final int id;
  final String description;
  final String key;

  factory CommonDropDownResponse.fromJson(Map<String, dynamic> json) => CommonDropDownResponse(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
