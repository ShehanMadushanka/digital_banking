import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';

abstract class UserOtherInfoState extends BaseState<UserOtherInfoState> {}

class InitialUserOtherInfoState extends UserOtherInfoState {}

class UserOtherInfoLoadedState extends UserOtherInfoState {
  final WalletOnBoardingData walletOnBoardingData;
  //
  UserOtherInfoLoadedState({this.walletOnBoardingData});
}

class UserOtherInfoSubmittedSuccessState extends UserOtherInfoState {
  final bool isBackButtonClick;

  UserOtherInfoSubmittedSuccessState({this.isBackButtonClick});
}

class UserOtherInfoFailedState extends UserOtherInfoState {
  final String message;

  UserOtherInfoFailedState({this.message});
}

class SuccessSubmitOtherDetailsAndEmpInfo extends UserOtherInfoState {}