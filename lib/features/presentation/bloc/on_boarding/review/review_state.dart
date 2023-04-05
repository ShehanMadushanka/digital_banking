import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../base_state.dart';

abstract class ReviewState extends BaseState<ReviewState> {}

/// Initial State
class InitialReviewInfoState extends ReviewState {}

/// Get Data Success State
class ReviewInfoLoadedState extends ReviewState {
  final WalletOnBoardingData walletOnBoardingData;
  //
  ReviewInfoLoadedState({this.walletOnBoardingData});
}

/// Failed State
class ReviewInfoFailedState extends ReviewState {
  final String message;

  ReviewInfoFailedState({this.message});
}

class SaveReviewInfoSuccessEvent extends ReviewState {}

class SaveReviewInfoFailedEvent extends ReviewState {
  final String message;

  SaveReviewInfoFailedEvent({this.message});
}