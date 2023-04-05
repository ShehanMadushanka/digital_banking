import '../../../domain/entities/response/saved_payee_entity.dart';
import '../base_state.dart';

abstract class PayeeManagementState extends BaseState<PayeeManagementState> {}

class InitialPayeeManagementState extends PayeeManagementState {}

class GetSavedPayeesSuccessState extends PayeeManagementState {
  final List<SavedPayeeEntity> savedPayees;

  GetSavedPayeesSuccessState({this.savedPayees});
}

class GetSavedPayeeFailedState extends PayeeManagementState{
  final String message;

  GetSavedPayeeFailedState({this.message});
}
