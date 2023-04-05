import '../../base_state.dart';

abstract class BiometricState extends BaseState<BiometricState> {}

class InitialBiometricState extends BiometricState {}

class EnableBiometricSuccessState extends BiometricState{}

class EnableBiometricFailedState extends BiometricState{
  final String error;

  EnableBiometricFailedState({this.error});
}

class SaveUserSuccessState extends BiometricState {}

class SaveUserFailedState extends BiometricState {
  final String message;

  SaveUserFailedState({this.message});
}