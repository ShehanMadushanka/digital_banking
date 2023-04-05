import '../../base_event.dart';

abstract class BiometricEvent extends BaseEvent {}

class EnableBiometricEvent extends BiometricEvent {
  final bool shouldEnableBiometric;

  EnableBiometricEvent({this.shouldEnableBiometric});
}

class SaveUserEvent extends BiometricEvent {}
