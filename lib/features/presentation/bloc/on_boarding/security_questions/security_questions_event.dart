import '../../../../data/models/requests/set_security_questions_request.dart';
import '../../base_event.dart';

abstract class SecurityQuestionsEvent extends BaseEvent {}

/// Get Schedule Information
class SetSecurityQuestionsEvent extends SecurityQuestionsEvent {
  final List<AnswerList> answerList;

  SetSecurityQuestionsEvent(this.answerList);
}

class SaveSecurityQuestionsEvent extends SecurityQuestionsEvent {}
