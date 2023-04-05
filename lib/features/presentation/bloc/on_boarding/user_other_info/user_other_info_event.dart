import '../../../../data/models/requests/emp_detail_request.dart';
import '../../base_event.dart';

abstract class UserOtherInformationEvent extends BaseEvent {}

/// Get Personal Information
class GetUserOtherInformationEvent extends UserOtherInformationEvent {}

/// Store Personal Information
class StoreUserOtherInformationEvent extends UserOtherInformationEvent {
  final int stepValue;
  final String stepName;
  final EmpDetailRequest empDetailRequest;
  final bool isBackButtonClick;

  StoreUserOtherInformationEvent(
      {this.empDetailRequest,
      this.stepName,
      this.stepValue,
      this.isBackButtonClick});
}

/// Submit Employee Details Request
class SubmitOtherAndEmpDetailsEvent extends UserOtherInformationEvent {
  String isPoliticallyExposed;
  String purposeOfAccOpening;
  String taxPayeeInUS;
  String sourceOfFunds;
  String expectedTransMode;
  String amountDepositPerMonth;
  String referralCode;
  bool isPoliticsInvolved;
  bool isPositionParty;
  bool isMP;

  SubmitOtherAndEmpDetailsEvent(
      {this.isPoliticallyExposed,
      this.purposeOfAccOpening,
      this.taxPayeeInUS,
      this.sourceOfFunds,
      this.expectedTransMode,
      this.amountDepositPerMonth,
      this.referralCode,
      this.isPoliticsInvolved,
        this.isMP,
        this.isPositionParty,
      });
}
