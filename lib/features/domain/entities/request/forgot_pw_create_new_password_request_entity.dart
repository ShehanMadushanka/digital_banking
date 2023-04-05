// To parse this JSON data, do
//
//     final forgotPwCreateNewPasswordRequestModel = forgotPwCreateNewPasswordRequestModelFromJson(jsonString);

import 'package:cdb_mobile/features/data/models/requests/forgot_pw_create_new_password_request.dart';

class ForgotPwCreateNewPasswordRequestEntity extends ForgotPwCreateNewPasswordRequestModel{
  ForgotPwCreateNewPasswordRequestEntity({
    this.messageType,
    this.username,
    this.newPassword,
    this.confirmPassword,
  }) : super(
    messageType: messageType,
    username: username,
    newPassword: newPassword,
    confirmPassword: confirmPassword
  );

  final String messageType;
  final String username;
  final String newPassword;
  final String confirmPassword;
}
