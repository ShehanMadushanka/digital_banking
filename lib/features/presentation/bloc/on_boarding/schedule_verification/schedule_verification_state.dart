import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';

abstract class ScheduleVerificationState extends BaseState<ScheduleVerificationState> {}

class InitialScheduleVerificationState extends ScheduleVerificationState {}

class ScheduleVerificationInformationLoadedState extends ScheduleVerificationState {
  final WalletOnBoardingData walletOnBoardingData;
  //
  ScheduleVerificationInformationLoadedState({this.walletOnBoardingData});
}

class ScheduleVerificationInformationSubmittedSuccessState extends ScheduleVerificationState {
  final bool isBackButtonClick;

  ScheduleVerificationInformationSubmittedSuccessState({this.isBackButtonClick});
}

class ScheduleVerificationInformationFailedState extends ScheduleVerificationState {
  final String message;

  ScheduleVerificationInformationFailedState({this.message});
}

class SubmitScheduleDataSuccessState extends ScheduleVerificationState{

}

class SubmitScheduleDataFailedState extends ScheduleVerificationState{
  final String message;

  SubmitScheduleDataFailedState({this.message});
}