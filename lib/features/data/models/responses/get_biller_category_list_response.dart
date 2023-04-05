// To parse this JSON data, do
//
//     final getBillerCategoryListResponse = getBillerCategoryListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cdb_mobile/features/data/models/common/base_response.dart';

class GetBillerCategoryListResponse extends Serializable{
  GetBillerCategoryListResponse({
    this.data,
  });

  List<BillerCategoryResponse> data;

  factory GetBillerCategoryListResponse.fromRawJson(String str) => GetBillerCategoryListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBillerCategoryListResponse.fromJson(Map<String, dynamic> json) => GetBillerCategoryListResponse(
    data: json["data"]!=null?List<BillerCategoryResponse>.from(json["data"].map((x) => BillerCategoryResponse.fromJson(x))):List.empty(),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BillerCategoryResponse {
  BillerCategoryResponse({
    this.id,
    this.code,
    this.description,
    this.name,
    this.status,
    this.createdUser,
    this.modifiedUser,
    this.createdDate,
    this.modifiedDate,
    this.dbpBspMetaCollection,
  });

  int id;
  String code;
  String description;
  String name;
  String status;
  String createdUser;
  String modifiedUser;
  DateTime createdDate;
  DateTime modifiedDate;
  List<DbpBspMetaCollection> dbpBspMetaCollection;

  factory BillerCategoryResponse.fromRawJson(String str) => BillerCategoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillerCategoryResponse.fromJson(Map<String, dynamic> json) => BillerCategoryResponse(
    id: json["id"],
    code: json["code"],
    description: json["description"],
    name: json["name"],
    status: json["status"],
    createdUser: json["createdUser"],
    modifiedUser: json["modifiedUser"],
    createdDate: DateTime.parse(json["createdDate"]),
    modifiedDate: DateTime.parse(json["modifiedDate"]),
    dbpBspMetaCollection: json["dbpBspMetaCollection"]!=null?List<DbpBspMetaCollection>.from(json["dbpBspMetaCollection"].map((x) => DbpBspMetaCollection.fromJson(x))):List.empty(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": description,
    "name": name,
    "status": status,
    "createdUser": createdUser,
    "modifiedUser": modifiedUser,
    "createdDate": createdDate.toIso8601String(),
    "modifiedDate": modifiedDate.toIso8601String(),
    "dbpBspMetaCollection": List<dynamic>.from(dbpBspMetaCollection.map((x) => x.toJson())),
  };
}

class DbpBspMetaCollection {
  DbpBspMetaCollection({
    this.id,
    this.name,
    this.description,
    this.displayName,
    this.collectionAccount,
    this.status,
    this.createdDate,
    this.imageUrl,
    this.dbpBspMetaCustomFieldCollection,
  });

  int id;
  String name;
  String description;
  String displayName;
  String collectionAccount;
  String status;
  DateTime createdDate;
  String imageUrl;
  List<DbpBspMetaCustomFieldCollection> dbpBspMetaCustomFieldCollection;

  factory DbpBspMetaCollection.fromRawJson(String str) => DbpBspMetaCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DbpBspMetaCollection.fromJson(Map<String, dynamic> json) => DbpBspMetaCollection(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    displayName: json["displayName"],
    collectionAccount: json["collectionAccount"],
    status: json["status"],
    createdDate: DateTime.parse(json["createdDate"]),
    imageUrl: json["imageUrl"],
    dbpBspMetaCustomFieldCollection: List<DbpBspMetaCustomFieldCollection>.from(json["dbpBspMetaCustomFieldCollection"].map((x) => DbpBspMetaCustomFieldCollection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "displayName": displayName,
    "collectionAccount": collectionAccount,
    "status": status,
    "createdDate": createdDate.toIso8601String(),
    "imageUrl": imageUrl,
    "dbpBspMetaCustomFieldCollection": List<dynamic>.from(dbpBspMetaCustomFieldCollection.map((x) => x.toJson())),
  };
}

class DbpBspMetaCustomFieldCollection {
  DbpBspMetaCustomFieldCollection({
    this.id,
    this.name,
    this.validation,
    this.length,
    this.fieldType,
    this.value,
    this.placeHolder
  });

  int id;
  String name;
  String value;
  String placeHolder;
  String validation;
  String length;
  FieldType fieldType;

  factory DbpBspMetaCustomFieldCollection.fromRawJson(String str) => DbpBspMetaCustomFieldCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DbpBspMetaCustomFieldCollection.fromJson(Map<String, dynamic> json) => DbpBspMetaCustomFieldCollection(
    id: json["id"],
    name: json["name"],
    placeHolder: json["placeHolder"],
    value: json["value"],
    validation: json["validation"],
    length: json["length"],
    fieldType: FieldType.fromJson(json["fieldType"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "validation": validation,
    "length": length,
    "placeHolder": placeHolder,
    "value": value,
    "fieldType": fieldType.toJson(),
  };
}

class FieldType {
  FieldType({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory FieldType.fromRawJson(String str) => FieldType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FieldType.fromJson(Map<String, dynamic> json) => FieldType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}