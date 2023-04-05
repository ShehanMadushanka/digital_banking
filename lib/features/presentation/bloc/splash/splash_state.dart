import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';

abstract class SplashState extends BaseState<SplashState> {}

class InitialSplashState extends SplashState {}

class SplashLoadedState extends SplashState {}

class SplashFailedState extends SplashState {
  final String message;

  SplashFailedState({this.message});
}

class StepperValueLoadedState extends SplashState {
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

class PushTokenSuccessState extends SplashState {}

class PushTokenFailedState extends SplashState {}
