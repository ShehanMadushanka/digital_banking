import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/requests/wallet_onboarding_data.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/reg_progress/reg_progress_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/reg_progress/reg_progress_state.dart';

class RegProgressBloc extends BaseBloc<RegProgressEvent, BaseState<RegProgressState>> {

  final GetWalletOnBoardingData getWalletOnBoardingData;

  RegProgressBloc({this.getWalletOnBoardingData}) : super(InitialRegProgressState());

  @override
  Stream<BaseState<RegProgressState>> mapEventToState(RegProgressEvent event) async* {
    if (event is GetStepperValueEvent) {
      final result = await getWalletOnBoardingData(const WalletParams(walletOnBoardingDataEntity: null));

      final obj = result.fold((failure) => failure, (response) => response,);
      if(obj is Failure) {
        yield RegProgressFailedState(message: "Could not load data from local Storage");
      } else {
        final WalletOnBoardingData walletOnBoardingData = obj;
        if(walletOnBoardingData != null) {
          if(walletOnBoardingData.stepperValue > 0) {
            yield StepperValueLoadedState(stepperName: walletOnBoardingData.stepperName,stepperValue: walletOnBoardingData.stepperValue);
          } else {
            yield RegProgressFailedState(message: "Invalid Stepper Value");
          }
        } else {
          yield RegProgressFailedState(message: "Invalid Stepper Value");
        }
      }

    }
  }
}