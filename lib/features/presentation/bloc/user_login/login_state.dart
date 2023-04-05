import '../../../data/models/responses/mobile_login_response.dart';
import '../base_state.dart';

abstract class LoginState extends BaseState<LoginState> {}

class InitialLoginState extends LoginState {}

class MobileLoginFailedState extends LoginState {
  final String message;

  MobileLoginFailedState({this.message});
}

class MobileLoginAPIFailedState extends LoginState {
  final String message;

  MobileLoginAPIFailedState({this.message});
}

class MobileLoginSuccessState extends LoginState {
  final MobileLoginResponse mobileLoginResponse;
  final String responseCode;
  final String responseDescription;

  MobileLoginSuccessState({this.mobileLoginResponse, this.responseCode, this.responseDescription});
}

class GetLoginCredentials extends LoginState {
  final bool isAvailable;
  final String username;

  GetLoginCredentials({this.isAvailable, this.username});
}

class StepperValueLoadedState extends LoginState {
  final String routeString;
  final String stepperName;
  final int stepperValue;
  final bool initialLaunchDone;

  StepperValueLoadedState(
      {this.routeString,
      this.stepperValue,
      this.stepperName,
      this.initialLaunchDone});
}

class BiometricPromptSuccessState extends LoginState{}
