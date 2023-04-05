import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_pw_create_new_password_state.dart';

import '../base_event.dart';

abstract class ForgotPwCreateNewPasswordEvent extends BaseEvent {}

class ForgotPasswordCreateNewPasswordEvent
    extends ForgotPwCreateNewPasswordEvent {
  final String username;
  final String password;
  final String confirmPassword;

  ForgotPasswordCreateNewPasswordEvent(
      {this.username, this.password, this.confirmPassword});
}

class ForgotPasswordCreateNewPasswordFailedState extends ForgotPwCreateNewPasswordState {
  final String message;

  ForgotPasswordCreateNewPasswordFailedState({this.message});
}

class SaveUserEvent extends ForgotPwCreateNewPasswordEvent {}
