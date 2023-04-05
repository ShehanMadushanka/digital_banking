import '../../../domain/entities/request/forgot_pw_reset_security_questions_request_entity.dart';

import '../base_event.dart';

abstract class ForgotPwResetSecQuestionsEvent extends BaseEvent {}

class GetForgotPwResetSecQuestionsEvent extends ForgotPwResetSecQuestionsEvent {
  final List<AnswerEntity> answers;

  GetForgotPwResetSecQuestionsEvent(this.answers);
}

class SaveForgotPwResetSecQuestionsEvent extends ForgotPwResetSecQuestionsEvent {}