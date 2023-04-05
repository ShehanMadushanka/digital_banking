import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/emp_details_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/emp_details/emp_details.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'user_other_info_event.dart';
import 'user_other_info_state.dart';

class UserOtherInformationBloc
    extends BaseBloc<UserOtherInformationEvent, BaseState<UserOtherInfoState>> {
  final LocalDataSource appSharedData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final EmpDetails empDetails;

  UserOtherInformationBloc({
    this.appSharedData,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.empDetails,
  }) : super(InitialUserOtherInfoState());

  @override
  Stream<BaseState<UserOtherInfoState>> mapEventToState(
      UserOtherInformationEvent event) async* {
    /// StoreContactInformationEvent
    if (event is StoreUserOtherInformationEvent) {
      // Get the Wallet Data
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Set the New Values
        final WalletOnBoardingData walletOnBoardingData =
            result.getOrElse(() => null);
        walletOnBoardingData.walletUserData.empDetailRequest
            .isPoliticallyExposed = event.empDetailRequest.isPoliticallyExposed;
        walletOnBoardingData.walletUserData.empDetailRequest.purposeOfAcc =
            event.empDetailRequest.purposeOfAcc;
        walletOnBoardingData.walletUserData.empDetailRequest.isTaxPayerUs =
            event.empDetailRequest.isTaxPayerUs;
        walletOnBoardingData.walletUserData.empDetailRequest.sourceOfIncome =
            event.empDetailRequest.sourceOfIncome;
        walletOnBoardingData
                .walletUserData.empDetailRequest.expectedTransactionMode =
            event.empDetailRequest.expectedTransactionMode;
        walletOnBoardingData.walletUserData.empDetailRequest.marketingRefCode =
            event.empDetailRequest.marketingRefCode;
        walletOnBoardingData
                .walletUserData.empDetailRequest.anticipatedDepositPerMonth =
            event.empDetailRequest.anticipatedDepositPerMonth;

        walletOnBoardingData.walletUserData.empDetailRequest
            .isInvolvedInPolitics = event.empDetailRequest.isInvolvedInPolitics;
        walletOnBoardingData.walletUserData.empDetailRequest.isPositionInParty =
            event.empDetailRequest.isPositionInParty;
        walletOnBoardingData.walletUserData.empDetailRequest.isMemberOfInst =
            event.empDetailRequest.isMemberOfInst;

        // Store the Wallet Data
        final savedResult = await storeWalletOnBoardingData(Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperValue: event.stepValue,
                stepperName: event.stepName,
                walletUserData: walletOnBoardingData.walletUserData)));
        yield savedResult.fold((l) {
          return UserOtherInfoFailedState(message: "Failed to load data");
        }, (r) {
          return UserOtherInfoSubmittedSuccessState(
              isBackButtonClick: event.isBackButtonClick);
        });
      } else {
        yield UserOtherInfoFailedState(message: "Failed to load data");
      }
    }

    /// GetContactInformationEvent
    else if (event is GetUserOtherInformationEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      yield result.fold(
        (failure) {
          return UserOtherInfoFailedState(message: "Failed to load data");
        },
        (response) {
          return UserOtherInfoLoadedState(walletOnBoardingData: response);
        },
      );
    }

    /// Send API Request
    else if (event is SubmitOtherAndEmpDetailsEvent) {
      // Get the Wallet Data
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      final obj = result.fold(
        (failure) => failure,
        (response) => response,
      );
      if (obj is Failure) {
        yield UserOtherInfoFailedState(message: "Failed to load data");
      } else {
        // Send API request
        final WalletOnBoardingData data = obj as WalletOnBoardingData;

        final apiResult = await empDetails(EmpDetailsParam(
            empDetailsRequestEntity: EmpDetailsRequestEntity(
          isTaxPayerUs: event.taxPayeeInUS ?? "false",
          messageType: kMessageTypeEmpDetailReq,
          purposeOfAcc: event.purposeOfAccOpening.getAccountPurpose(),
          empType:
              data.walletUserData.empDetailRequest.empType.getCustomerType(),
          filedOfEmp: data.walletUserData.empDetailRequest.filedOfEmp
              .getFieldOfEmployment(),
          designation: data.walletUserData.empDetailRequest.designation,
          nameOfEmp: data.walletUserData.empDetailRequest.nameOfEmp,
          addressOfEmp: data.walletUserData.empDetailRequest.addressOfEmp,
          annualIncome: data.walletUserData.empDetailRequest.annualIncome
              .getMonthlyIncome(),
          marketingRefCode: event.referralCode,
          sourceOfIncome: event.sourceOfFunds.getSourceOfFunds(),
          expectedTransactionMode: event.expectedTransMode.getTransactionMode(),
          anticipatedDepositPerMonth: event.amountDepositPerMonth,
          isPoliticallyExposed: event.isPoliticallyExposed ?? "false",
          isInvolvedInPolitics: event.isPoliticsInvolved.toString(),
          isPositionInParty: event.isPositionParty.toString(),
          isMemberOfInst: event.isMP.toString(),
        )));

        // if(apiResult.isLeft()) {
        //   data.stepperValue = KYCStep.OTHERINFO.getStep();
        //   data.stepperName = KYCStep.OTHERINFO.toString();
        //
        //
        //   // Store the reset data
        //   final savedResult = await storeWalletOnBoardingData(Parameter(
        //       walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
        //           stepperValue: data.stepperValue,
        //           stepperName: data.stepperName,
        //           walletUserData: data.walletUserData)));
        //
        //   if(savedResult is Left) {
        //     log("Could not save Data");
        //   }
        //
        // }

        yield apiResult.fold((l) {
          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else {
            return UserOtherInfoFailedState(
                message: ErrorMessages().mapFailureToMessage(l));
          }
        }, (r) {
          return SuccessSubmitOtherDetailsAndEmpInfo();
        });
      }
    }
  }
}
