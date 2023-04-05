// To parse this JSON data, do
//
//     final usernameIdentityRequestModel = usernameIdentityRequestModelFromJson(jsonString);

import 'dart:convert';

import '../../../data/models/requests/forgot_password_username_request.dart';

class ForgotPasswordUserNameRequestEntity extends ForgotPasswordUserNameRequestModel {
  ForgotPasswordUserNameRequestEntity({
    this.messageType,
    this.clientTransId,
    this.username,
    this.nic,
  }) : super(
          messageType: messageType,
          clientTransId: clientTransId,
          username: username,
          nic: nic,
        );

  String messageType;
  String clientTransId;
  String username;
  String nic;
}
