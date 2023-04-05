import '../base_state.dart';

abstract class ForgotPwResetSecQuestionsState extends BaseState<ForgotPwResetSecQuestionsState> {}

class InitialForgotPwResetSecQuestionsState extends ForgotPwResetSecQuestionsState {}

class GetForgotPwResetSecQuestionsSuccessState extends ForgotPwResetSecQuestionsState {
  String answer;
  String question;

  GetForgotPwResetSecQuestionsSuccessState({this.answer, this.question});
}

class GetForgotPwResetSecQuestionsFailedState extends ForgotPwResetSecQuestionsState {
  final String message;

  GetForgotPwResetSecQuestionsFailedState({this.message});
}

class SaveForgotPwResetSecQuestionsSuccessState extends ForgotPwResetSecQuestionsState {
  String otpReferenceNo;
  String mobile;
  String email;

  SaveForgotPwResetSecQuestionsSuccessState({this.otpReferenceNo, this.mobile, this.email});
}

class SaveForgotPwResetSecQuestionsFailedState extends ForgotPwResetSecQuestionsState {
  final String message;

  SaveForgotPwResetSecQuestionsFailedState({this.message});
}