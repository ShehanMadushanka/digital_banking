import '../../../domain/entities/request/forgot_pw_reset_security_questions_request_entity.dart';

import '../base_event.dart';

abstract class ForgotPasswordUserNameEvent extends BaseEvent {}

class GetForgotPasswordUserNameEvent extends ForgotPasswordUserNameEvent {
  final String nic;
  final String username;

  GetForgotPasswordUserNameEvent({this.nic, this.username});
}

class SaveForgotPasswordUserNameEvent extends ForgotPasswordUserNameEvent {}

class ForgotPasswordUsingAccountNumber extends ForgotPasswordUserNameEvent{
  final String accountNumber;
  final String nic;

  ForgotPasswordUsingAccountNumber({this.accountNumber, this.nic});
}