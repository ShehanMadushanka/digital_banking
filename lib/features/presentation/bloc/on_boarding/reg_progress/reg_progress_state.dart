import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';

abstract class RegProgressState extends BaseState<RegProgressState> {}

class StepperValueLoadedState extends RegProgressState {
  final int stepperValue;
  final String stepperName;

  StepperValueLoadedState({this.stepperValue, this.stepperName});
}

class RegProgressFailedState extends RegProgressState {
  final String message;

  RegProgressFailedState({this.message});

}

class InitialRegProgressState extends RegProgressState {}