import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/enums.dart';

import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends BaseBloc<ReviewEvent, BaseState<ReviewState>> {
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;

  ReviewBloc({
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
  }) : super(InitialReviewInfoState());

  @override
  Stream<BaseState<ReviewState>> mapEventToState(ReviewEvent event) async* {
    if (event is GetReviewInfoEvent) {
      yield APILoadingState();
      // Get the Stored Data
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      yield result.fold(
          (l) => ReviewInfoFailedState(message: 'Failed to load the data'),
          (r) => ReviewInfoLoadedState(walletOnBoardingData: r));
    } else if (event is SaveReviewEvent) {
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Store the Wallet Data
        final _result = await storeWalletOnBoardingData(
          Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.INTERSTEDPROD.toString(),
              stepperValue: KYCStep.INTERSTEDPROD.getStep(),
              walletUserData: result
                  .getOrElse(
                    () => null,
                  )
                  .walletUserData,
            ),
          ),
        );

        yield _result.fold((l) {
          return SaveReviewInfoFailedEvent(
              message: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          return SaveReviewInfoSuccessEvent();
        });
      } else {
        yield SaveReviewInfoFailedEvent(
            message: ErrorMessages.errorSomethingWentWrong);
      }
    }
  }
}
