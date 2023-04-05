import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/models/requests/submit_products_request.dart';
import 'package:cdb_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/other_products/get_other_products.dart';
import 'package:cdb_mobile/features/domain/usecases/other_products/submit_other_products.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/enums.dart';

import '../../base_bloc.dart';
import '../../base_state.dart';
import 'other_products_event.dart';
import 'other_products_state.dart';

class OtherProductsBloc
    extends BaseBloc<OtherProductsEvent, BaseState<OtherProductsState>> {
  final GetOtherProducts getOtherProducts;
  final SubmitOtherProducts submitOtherProducts;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;

  OtherProductsBloc({
    this.getOtherProducts,
    this.submitOtherProducts,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
  }) : super(InitialOtherProductsState());

  @override
  Stream<BaseState<OtherProductsState>> mapEventToState(
      OtherProductsEvent event) async* {
    if (event is GetOtherProductsEvent) {
      yield APILoadingState();
      final result = await getOtherProducts(
        const Parameters(
          otherProductRequest: CommonRequestEntity(
            messageType: kMessageTypeInterestedProductReq,
          ),
        ),
      );

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return GetOtherProductsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return GetOtherProductsLoadedState(data: r.data.data);
      });
    } else if (event is SubmitOtherProductsEvent) {
      yield APILoadingState();
      final result = await submitOtherProducts(Params(
        submitProductsRequest: SubmitProductsRequest(
            messageType: kSubmitOtherProductsRequestType, products: event.data),
      ));

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return SubmitOtherProductFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return SubmitOtherProductSuccessState(message: r.errorDescription);
      });
    } else if (event is SaveOtherProductsEvent) {
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Store the Wallet Data
        final _result = await storeWalletOnBoardingData(
          Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.SECURITYQ.toString(),
              stepperValue: KYCStep.SECURITYQ.getStep(),
              walletUserData: result
                  .getOrElse(
                    () => null,
                  )
                  .walletUserData,
            ),
          ),
        );

        yield _result.fold((l) {
          return SaveOtherProductsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          return SaveOtherProductsSuccessState();
        });
      } else {
        yield SaveOtherProductsFailedState(
            message: ErrorMessages.errorSomethingWentWrong);
      }
    }else if (event is SaveUserEvent) {
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Store the Wallet Data
        final _result = await storeWalletOnBoardingData(
          Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.SECURITYQ.toString(),
              stepperValue: KYCStep.SECURITYQ.getStep(),
              walletUserData: result
                  .getOrElse(
                    () => null,
              )
                  .walletUserData,
            ),
          ),
        );

        yield _result.fold((l) {
          return SaveUserFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          return SaveUserSuccessState();
        });
      } else {
        yield SaveUserFailedState(
            message: ErrorMessages.errorSomethingWentWrong);
      }
    }
  }
}
