import 'package:cdb_mobile/features/data/models/requests/wallet_onboarding_data.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';

abstract class EmploymentDetailsState extends BaseState<EmploymentDetailsState> {}

class InitialEmploymentDetailsState extends EmploymentDetailsState {}

class EmploymentDetailsLoadedState extends EmploymentDetailsState {
  final WalletOnBoardingData walletOnBoardingData;
  //
  EmploymentDetailsLoadedState({this.walletOnBoardingData});
}

class EmploymentDetailsSuccessState extends EmploymentDetailsState {
  final bool isBackButtonClick;

  EmploymentDetailsSuccessState({this.isBackButtonClick});
}

class EmploymentDetailsFailedState extends EmploymentDetailsState {
  final String message;

  EmploymentDetailsFailedState({this.message});
}

class UpdateEmployeeDetailsSuccess extends EmploymentDetailsState {}
