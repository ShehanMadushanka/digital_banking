import 'package:cdb_mobile/core/services/cloud_notification_services.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/common/base_response.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../domain/entities/request/common_request_entity.dart';
import '../../../domain/usecases/splash/get_splash_data.dart';
import '../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, BaseState<SplashState>> {
  final LocalDataSource appSharedData;
  final GetSplashData useCaseSplashData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final CloudMessagingServices cloudMessagingServices;

  SplashBloc(
      {this.appSharedData,
      this.useCaseSplashData,
      this.getWalletOnBoardingData,
      this.cloudMessagingServices})
      : super(InitialSplashState());

  @override
  Stream<BaseState<SplashState>> mapEventToState(SplashEvent event) async* {
    if (event is SplashRequestEvent) {
      final biometric = await appSharedData.getBiometricCode();
      AppConstants.BIOMETRIC_CODE = biometric;

      final result = await useCaseSplashData(
        const Params(
          splashRequest: CommonRequestEntity(
            messageType: kMessageTypeSplashReq,
          ),
        ),
      );
      yield* _eitherSplashSuccessOrErrorState(result);
    } else if (event is GetStepperValueEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));

      final obj = result.fold(
        (failure) => failure,
        (response) => response,
      );
      if (obj is Failure) {
        yield SplashFailedState(
            message: "Could not load data from local Storage");
      } else {
        final WalletOnBoardingData walletOnBoardingData = obj;
        final bool initialLaunch = await appSharedData.isInitialLaunchDone();

        if (walletOnBoardingData != null) {
          if (walletOnBoardingData.stepperValue > 0) {
            yield StepperValueLoadedState(
                routeString: Routes.kLoginView,
                stepperName: walletOnBoardingData.stepperName,
                stepperValue: walletOnBoardingData.stepperValue,
                initialLaunchDone: initialLaunch);
          } else {
            yield StepperValueLoadedState(
                routeString: Routes.kLoginView,
                initialLaunchDone: initialLaunch);
          }
        } else {
          yield StepperValueLoadedState(
              routeString: Routes.kLoginView, initialLaunchDone: initialLaunch);
        }
      }
    } else if (event is RequestPushToken) {
      final hasToken = await appSharedData.hasPushToken();
      if (hasToken) {
        yield PushTokenSuccessState();
      } else {
        await cloudMessagingServices.capturePushToken();
        yield PushTokenFailedState();
      }
    }
  }

  /// Either Splash Success or Error
  Stream<BaseState<SplashState>> _eitherSplashSuccessOrErrorState(
    Either<Failure, BaseResponse> failureOrSplashSuccess,
  ) async* {
    final obj = failureOrSplashSuccess.fold(
      (failure) => failure,
      (response) => response,
    );
    if (obj is! Failure) {
      yield SplashLoadedState();
    } else {
      final ServerFailure serverFailure = obj as ServerFailure;
      yield SplashFailedState(
          message: serverFailure.errorResponse.errorDescription);
    }
  }
}
