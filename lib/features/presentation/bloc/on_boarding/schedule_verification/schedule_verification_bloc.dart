import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/schedule_verification_request.dart';
import '../../../../data/models/requests/submit_schedule_data_request.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/schedule/submit_schedule_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'schedule_verification_event.dart';
import 'schedule_verification_state.dart';

class ScheduleVerificationBloc extends BaseBloc<ScheduleVerificationEvent,
    BaseState<ScheduleVerificationState>> {
  final LocalDataSource appSharedData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final SubmitScheduleData submitScheduleData;

  ScheduleVerificationBloc(
      {this.appSharedData,
      this.getWalletOnBoardingData,
      this.storeWalletOnBoardingData,
      this.submitScheduleData})
      : super(InitialScheduleVerificationState());

  @override
  Stream<BaseState<ScheduleVerificationState>> mapEventToState(
      ScheduleVerificationEvent event) async* {
    /// StoreScheduleVerificationInformationEvent
    if (event is StoreScheduleVerificationInformationEvent) {
      // Get the Wallet Data
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Set the New Values
        final WalletOnBoardingData walletOnBoardingData =
            result.getOrElse(() => null);
        if (walletOnBoardingData.walletUserData.scheduleVerificationRequest !=
            null) {
          walletOnBoardingData.walletUserData.scheduleVerificationRequest.date =
              event.scheduleVerificationRequest.date;
          walletOnBoardingData.walletUserData.scheduleVerificationRequest
              .timeSlot = event.scheduleVerificationRequest.timeSlot;
          walletOnBoardingData.walletUserData.scheduleVerificationRequest
              .language = event.scheduleVerificationRequest.language;
        } else {
          final ScheduleVerificationRequest scheduleVerificationRequest =
              ScheduleVerificationRequest(
            date: event.scheduleVerificationRequest.date,
            timeSlot: event.scheduleVerificationRequest.timeSlot,
            language: event.scheduleVerificationRequest.language,
          );
          walletOnBoardingData.walletUserData.scheduleVerificationRequest =
              scheduleVerificationRequest;
        }

        // Store the Wallet Data
        final savedResult = await storeWalletOnBoardingData(Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperValue: event.stepValue,
                stepperName: event.stepName,
                walletUserData: walletOnBoardingData.walletUserData)));
        final obj = savedResult.fold((l) => l, (r) => r);
        if (obj is Failure) {
          yield ScheduleVerificationInformationFailedState(
              message: "Failed to load data");
        } else {
          yield ScheduleVerificationInformationSubmittedSuccessState(
              isBackButtonClick: event.isBackButtonClick);
        }
      } else {
        yield ScheduleVerificationInformationFailedState(
            message: "Failed to load data");
      }
    } else if (event is GetScheduleInformationEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      final obj = result.fold(
        (failure) => failure,
        (response) => response,
      );
      if (obj is Failure) {
        yield ScheduleVerificationInformationFailedState(
            message: "Failed to load data");
      } else {
        yield ScheduleVerificationInformationLoadedState(
            walletOnBoardingData: obj);
      }
    } else if (event is SubmitScheduleDataEvent) {
      yield APILoadingState();
      final result = await submitScheduleData(SubmitScheduleDataRequest(
          messageType: kScheduleDataSubmitRequestType,
          date: event.date,
          language: event.language.getLanguage(),
          timeSlot: event.timeSlot));

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return SubmitScheduleDataFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        appSharedData.removeAppWalletOnBoardingData();
        return SubmitScheduleDataSuccessState();
      });
    }
  }
}
