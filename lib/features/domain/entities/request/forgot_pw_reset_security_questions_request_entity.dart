// To parse this JSON data, do
//
//     final forgotPwResetSecQuestionsRequestModel = forgotPwResetSecQuestionsRequestModelFromJson(jsonString);

import '../../../data/models/requests/forgot_pw_reset_security_questions_request.dart';

class ForgotPwResetSecQuestionsRequestEntity extends ForgotPwResetSecQuestionsRequestModel {

  final String messageType;
  final String username;
  final List<AnswerEntity> answers;

  ForgotPwResetSecQuestionsRequestEntity({
    this.messageType,
    this.username,
    this.answers,
  }) : super(
    messageType: messageType,
    username: username,
    answers: answers,
  );
}

class AnswerEntity extends Answer{
  AnswerEntity({
    this.question,
    this.answer,
  }) : super(
    question: question,
    answer: answer,
  );

  int question;
  String answer;
}

