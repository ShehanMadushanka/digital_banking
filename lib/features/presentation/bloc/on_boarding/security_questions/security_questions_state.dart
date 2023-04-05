import '../../base_state.dart';

abstract class SecurityQuestionsState
    extends BaseState<SecurityQuestionsState> {}

class InitialSecurityQuestionsState extends SecurityQuestionsState {}

class SetSecurityQuestionsSuccessState extends SecurityQuestionsState {}

class SetSecurityQuestionsFailedState extends SecurityQuestionsState {
  final String message;

  SetSecurityQuestionsFailedState({this.message});
}

class SaveSecurityQuestionsSuccessState extends SecurityQuestionsState {}

class SaveSecurityQuestionsFailedState extends SecurityQuestionsState {
  final String message;

  SaveSecurityQuestionsFailedState({this.message});
}
