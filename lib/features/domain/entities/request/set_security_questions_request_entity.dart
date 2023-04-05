import '../../../data/models/requests/set_security_questions_request.dart';

class SetSecurityQuestionsEntity extends SetSecurityQuestionsRequest {
  final String messageType;
  final List<AnswerList> answerList;

  SetSecurityQuestionsEntity({this.messageType, this.answerList})
      : super(messageType: messageType, answerList: answerList);
}
