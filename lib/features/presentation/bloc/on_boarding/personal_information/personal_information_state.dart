import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';


abstract class PersonalInformationState extends BaseState<PersonalInformationState> {}

/// Initial State
class InitialPersonalInformationState extends PersonalInformationState {}

/// Get Data Success State
class PersonalInformationLoadedState extends PersonalInformationState {
  final WalletOnBoardingData walletOnBoardingData;
  //
  PersonalInformationLoadedState({this.walletOnBoardingData});
}

/// Stored Success State
class PersonalInformationStoredState extends PersonalInformationState {
  final bool isBackButtonClick;

  PersonalInformationStoredState({this.isBackButtonClick});
}

/// Verify NIC Success
class VerifyNICSuccessState extends PersonalInformationState {}

/// Submit Personal Info Success
class SubmitPersonalInfoSuccessState extends PersonalInformationState {}

/// Failed State
class PersonalInformationFailedState extends PersonalInformationState {
  final String message;

  PersonalInformationFailedState({this.message});
}
