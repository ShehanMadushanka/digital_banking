import '../base_event.dart';

abstract class PayeeManagementEvent extends BaseEvent {}

class GetSavedPayeesEvent extends PayeeManagementEvent {}
