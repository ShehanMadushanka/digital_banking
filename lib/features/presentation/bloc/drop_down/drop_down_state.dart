import '../base_state.dart';

abstract class DropDownState extends BaseState<DropDownState> {}

class InitialDropDownState extends DropDownState {}

class DropDownDataLoadedState<T> extends DropDownState {
  final T data;

  DropDownDataLoadedState({this.data});
}

class DropDownFilteredState<T> extends DropDownState {
  final T data;

  DropDownFilteredState({this.data});
}

class DropDownFailedState extends DropDownState {
  final String message;

  DropDownFailedState({this.message});
}

