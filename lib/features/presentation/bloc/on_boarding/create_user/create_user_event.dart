import '../../base_event.dart';

abstract class CreateUserParentEvent extends BaseEvent {}

class CreateUserEvent extends CreateUserParentEvent {
  final String username;
  final String password;
  final String confirmPassword;

  CreateUserEvent({this.username, this.password, this.confirmPassword});
}

class SaveUserEvent extends CreateUserParentEvent {}
