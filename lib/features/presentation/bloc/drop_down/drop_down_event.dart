import '../../../data/models/responses/city_response.dart';
import '../base_event.dart';

abstract class DropDownEvent extends BaseEvent {}

class GetCustomDropDownEvent extends DropDownEvent {
  final List<String> dataList;

  GetCustomDropDownEvent({this.dataList});
}

class GetTitleDropDownEvent extends DropDownEvent {}

class GetLanguageDropDownEvent extends DropDownEvent {}

class GetCityDropDownEvent extends DropDownEvent {}

class GetReligionDropDownEvent extends DropDownEvent {}

class GetEmpTypeDropDownEvent extends DropDownEvent {}

class GetEmpDesignation extends DropDownEvent {}

class GetAnnualIncome extends DropDownEvent {}

class GetEmpFieldDropDownEvent extends DropDownEvent {}

class GetSecurityQuestionDropDownEvent extends DropDownEvent {}

class GetPurposeOfAccountDropDownEvent extends DropDownEvent {}

class GetSourceOfFundsDropDownEvent extends DropDownEvent {}

class GetTransactionModeDropDownEvent extends DropDownEvent {}

class GetScheduleDatesDropDownEvent extends DropDownEvent{}

class GetBillerCategoriesDropDownEvent extends DropDownEvent{}

class GetBillerListDropDownEvent extends DropDownEvent{}

class GetScheduleTimeSlotDropDownEvent extends DropDownEvent{
  final String selectedDate;

  GetScheduleTimeSlotDropDownEvent({this.selectedDate});
}

class FilterEvent extends DropDownEvent {
  final List<CommonDropDownResponse> dropDownData;
  final String searchText;

  FilterEvent({this.dropDownData,this.searchText});
}
