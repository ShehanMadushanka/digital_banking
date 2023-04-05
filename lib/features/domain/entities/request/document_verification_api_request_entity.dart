// To parse this JSON data, do
//
//     final documentVerificationApiRequest = documentVerificationApiRequestFromJson(jsonString);

import 'dart:convert';

import '../../../data/models/requests/document_verification_api_request.dart';

class DocumentVerificationApiRequestEntity extends DocumentVerificationApiRequest{
  DocumentVerificationApiRequestEntity({
    this.imageList,
    this.messageType
  }):super(imageListData: imageList, messageType: messageType);

  List<ImageListEntity> imageList;
  String messageType;
}

class ImageListEntity extends ImageList{
  ImageListEntity({
    this.name,
    this.image,
  }):super(name: name,  image: image);

  String name;
  String image;
}
