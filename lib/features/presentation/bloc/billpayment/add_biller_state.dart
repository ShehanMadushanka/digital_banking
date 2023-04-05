abstract class AddBillerState {}

class InitialSummaryState extends AddBillerState {}

class AddBillerLoadingState extends AddBillerState {}

class AddBillerSuccessState extends AddBillerState {
  final bool result;

  AddBillerSuccessState(this.result);
}

class AddBillerFailedState extends AddBillerState {}
