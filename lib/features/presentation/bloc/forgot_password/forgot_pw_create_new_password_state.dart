import '../base_state.dart';

abstract class ForgotPwCreateNewPasswordState
    extends BaseState<ForgotPwCreateNewPasswordState> {}

class InitialForgotPwCreateNewPasswordState
    extends ForgotPwCreateNewPasswordState {}

class ForgotPwCreateNewPasswordSuccessState
    extends ForgotPwCreateNewPasswordState {}

class ForgotPwCreateNewPasswordFailedState
    extends ForgotPwCreateNewPasswordState {
  final String message;

  ForgotPwCreateNewPasswordFailedState({this.message});
}

class SaveUserSuccessState extends ForgotPwCreateNewPasswordState {}

class SaveUserFailedState extends ForgotPwCreateNewPasswordState {
  final String message;

  SaveUserFailedState({this.message});
}
