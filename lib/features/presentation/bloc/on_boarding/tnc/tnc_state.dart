import 'package:cdb_mobile/features/data/models/responses/get_terms_response.dart';

import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';

abstract class TnCState extends BaseState<TnCState> {}

/// Initial State
class InitialTnCState extends TnCState {}

/// Get Data Success State
class OnBoardingDataLoadedState extends TnCState {
  final WalletOnBoardingData walletOnBoardingData;

  //
  OnBoardingDataLoadedState({this.walletOnBoardingData});
}

class TnCAcceptedState extends TnCState {}

class TnCFailedState extends TnCState {}

/// Failed State
class OnBoardingDataFailedState extends TnCState {
  final String message;

  OnBoardingDataFailedState({this.message});
}

class TermsLoadedState extends TnCState {
  final TermsData termsData;

  TermsLoadedState({this.termsData});
}

class TermsSubmittedState extends TnCState {}

class TermsFailedState extends TnCState {
  final String message;

  TermsFailedState({this.message});
}
