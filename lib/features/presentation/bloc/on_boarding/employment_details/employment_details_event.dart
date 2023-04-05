import 'package:cdb_mobile/features/data/models/requests/emp_detail_request.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';

abstract class EmploymentDetailsEvent extends BaseEvent {}

/// Get Personal Information
class GetEmploymentDetailsEvent extends EmploymentDetailsEvent {
}

/// Store Personal Information
class StoreEmploymentDetailsEvent extends EmploymentDetailsEvent {

  final int stepValue;
  final String stepName;
  final bool isBackButtonClick;
  final EmpDetailRequest empDetailRequest;

  StoreEmploymentDetailsEvent({this.stepName,this.stepValue,this.isBackButtonClick,this.empDetailRequest});
}

class UpdateEmployeeDetailsEvent extends EmploymentDetailsEvent {}