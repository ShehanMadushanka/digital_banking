// To parse this JSON data, do
//
//     final forgotPwResetSecQuestionsRequestModel = forgotPwResetSecQuestionsRequestModelFromJson(jsonString);

import 'dart:convert';

ForgotPwResetSecQuestionsRequestModel
    forgotPwResetSecQuestionsRequestModelFromJson(String str) =>
        ForgotPwResetSecQuestionsRequestModel.fromJson(json.decode(str));

String forgotPwResetSecQuestionsRequestModelToJson(
        ForgotPwResetSecQuestionsRequestModel data) =>
    json.encode(data.toJson());

class ForgotPwResetSecQuestionsRequestModel {
  ForgotPwResetSecQuestionsRequestModel({
    this.messageType,
    this.username,
    this.answers,
  });

  String messageType;
  String username;
  List<Answer> answers;

  factory ForgotPwResetSecQuestionsRequestModel.fromJson(
          Map<String, dynamic> json) =>
      ForgotPwResetSecQuestionsRequestModel(
        messageType: json["messageType"],
        username: json["username"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "username": username,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.question,
    this.answer,
  });

  int question;
  String answer;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
