import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../../utils/enums.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/biometric_enable_request.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/biometric/enable_biometric.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'biometric_event.dart';
import 'biometric_state.dart';

class BiometricBloc
    extends BaseBloc<BiometricEvent, BaseState<BiometricState>> {
  final LocalDataSource appSharedData;
  final EnableBiometric enableBiometric;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;

  BiometricBloc(
      {this.appSharedData,
      this.enableBiometric,
      this.getWalletOnBoardingData,
      this.storeWalletOnBoardingData})
      : super(InitialBiometricState());

  @override
  Stream<BaseState<BiometricState>> mapEventToState(
      BiometricEvent event) async* {
    if (event is EnableBiometricEvent) {
      yield APILoadingState();
      final result = await enableBiometric(
        BiometricEnableRequest(
            messageType: kEnableBiometricRequestType,
            enableBiometric: event.shouldEnableBiometric),
      );

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return EnableBiometricFailedState(
              error: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        appSharedData.setBiometric(r.data.uniqueCode);
        return EnableBiometricSuccessState();
      });
    } else if (event is SaveUserEvent) {
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Store the Wallet Data
        final _result = await storeWalletOnBoardingData(
          Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.SCHEDULEVERIFY.toString(),
              stepperValue: KYCStep.SCHEDULEVERIFY.getStep(),
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
