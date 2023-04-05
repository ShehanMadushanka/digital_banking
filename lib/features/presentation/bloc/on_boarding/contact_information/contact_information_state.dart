import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';

abstract class ContactInformationState extends BaseState<ContactInformationState> {}

class InitialContactInformationState extends ContactInformationState {}

class ContactInformationLoadedState extends ContactInformationState {
  final WalletOnBoardingData walletOnBoardingData;
  //
  ContactInformationLoadedState({this.walletOnBoardingData});
}

class ContactInformationSubmittedSuccessState extends ContactInformationState {
  final bool isBackButtonClick;

  ContactInformationSubmittedSuccessState({this.isBackButtonClick});
}

class ContactInformationFailedState extends ContactInformationState {
  final String message;

  ContactInformationFailedState({this.message});
}

class ContactInfoApiSuccessState extends ContactInformationState {}
