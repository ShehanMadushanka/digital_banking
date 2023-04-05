abstract class AddBillerEvent {}

class ConfirmBillerEvent extends AddBillerEvent {
  final String username;
  final String password;

  ConfirmBillerEvent({this.username, this.password});

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class CancelBillerEvent extends AddBillerEvent {}

