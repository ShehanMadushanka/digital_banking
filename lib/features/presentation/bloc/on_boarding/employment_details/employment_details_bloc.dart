import 'dart:convert';
import 'dart:developer';

import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:dartz/dartz.dart';

import '../../../../../error/failures.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/emp_detail_request.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/emp_details_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/emp_details/emp_details.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'employemnt_details_state.dart';
import 'employment_details_event.dart';

class EmploymentDetailsBloc extends BaseBloc<EmploymentDetailsEvent,
    BaseState<EmploymentDetailsState>> {
  final LocalDataSource appSharedData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final EmpDetails empDetails;

  EmploymentDetailsBloc({
    this.appSharedData,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.empDetails,
  }) : super(InitialEmploymentDetailsState());

  @override
  Stream<BaseState<EmploymentDetailsState>> mapEventToState(
      EmploymentDetailsEvent event) async* {
    /// StoreEmploymentDetailsEvent
    if (event is StoreEmploymentDetailsEvent) {
      // Get the Wallet Data
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Set the New Values
        final WalletOnBoardingData walletOnBoardingData =
            result.getOrElse(() => null);

        // Check if Emp Detail Request is Null
        if (walletOnBoardingData.walletUserData.empDetailRequest == null) {
          // If null create new object and set it to -> walletOnBoardingData.walletUserData.empDetailRequest
          final EmpDetailRequest empDetailRequest = EmpDetailRequest();
          empDetailRequest.empType = event.empDetailRequest.empType;
          empDetailRequest.nameOfEmp = event.empDetailRequest.nameOfEmp;
          empDetailRequest.filedOfEmp = event.empDetailRequest.filedOfEmp;
          empDetailRequest.designationUiValue =
              event.empDetailRequest.designationUiValue;
          empDetailRequest.annualIncome = event.empDetailRequest.annualIncome;
          empDetailRequest.addressOfEmp = event.empDetailRequest.addressOfEmp;
          empDetailRequest.designation = event.empDetailRequest.designation;
          walletOnBoardingData.walletUserData.empDetailRequest =
              empDetailRequest;
        } else {
          // If not null update the existing values
          walletOnBoardingData.walletUserData.empDetailRequest.empType =
              event.empDetailRequest.empType;
          walletOnBoardingData.walletUserData.empDetailRequest.nameOfEmp =
              event.empDetailRequest.nameOfEmp;
          walletOnBoardingData.walletUserData.empDetailRequest.filedOfEmp =
              event.empDetailRequest.filedOfEmp;
          walletOnBoardingData.walletUserData.empDetailRequest
              .designationUiValue = event.empDetailRequest.designationUiValue;
          walletOnBoardingData.walletUserData.empDetailRequest.designation =
              event.empDetailRequest.designation;
          walletOnBoardingData.walletUserData.empDetailRequest.annualIncome =
              event.empDetailRequest.annualIncome;
          walletOnBoardingData.walletUserData.empDetailRequest.addressOfEmp =
              event.empDetailRequest.addressOfEmp;
        }
        // Store the Wallet Data
        final savedResult = await storeWalletOnBoardingData(Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperValue: event.stepValue,
                stepperName: event.stepName,
                walletUserData: walletOnBoardingData.walletUserData)));
        yield savedResult.fold((l) {
          return EmploymentDetailsFailedState(message: "Failed to load data");
        }, (r) {
            return EmploymentDetailsSuccessState(
                isBackButtonClick: event.isBackButtonClick);
        });
      } else {
        yield EmploymentDetailsFailedState(message: "Failed to load data");
      }
    }

    /// GetEmploymentDetailsEvent
    else if (event is GetEmploymentDetailsEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      yield result.fold(
        (failure) {
          return EmploymentDetailsFailedState(message: "Failed to load data");
        },
        (response) {
          return EmploymentDetailsLoadedState(walletOnBoardingData: response);
        },
      );
    }

    /// Update Employee Details Event
    else if (event is UpdateEmployeeDetailsEvent) {

      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      final obj = result.fold(
            (failure) => failure,
            (response) => response,
      );

      if(obj is Failure) {
        yield EmploymentDetailsFailedState(message: "Failed to load data");
      } else {


        final WalletOnBoardingData data = obj as WalletOnBoardingData;

        final apiResult = await  empDetails(EmpDetailsParam(empDetailsRequestEntity: EmpDetailsRequestEntity(
          isTaxPayerUs: data.walletUserData.empDetailRequest.isTaxPayerUs,
          messageType: kMessageTypeEmpDetailReq,
          purposeOfAcc: data.walletUserData.empDetailRequest.purposeOfAcc.getAccountPurpose(),
          empType: data.walletUserData.empDetailRequest.empType.getCustomerType(),
          filedOfEmp:  data.walletUserData.empDetailRequest.filedOfEmp.getFieldOfEmployment(),
          designation:  data.walletUserData.empDetailRequest.designation,
          nameOfEmp: data.walletUserData.empDetailRequest.nameOfEmp,
          addressOfEmp: data.walletUserData.empDetailRequest.addressOfEmp,
          annualIncome: data.walletUserData.empDetailRequest.annualIncome.getMonthlyIncome(),
          marketingRefCode: data.walletUserData.empDetailRequest.marketingRefCode,
          sourceOfIncome: data.walletUserData.empDetailRequest.sourceOfIncome.getSourceOfFunds(),
          expectedTransactionMode: data.walletUserData.empDetailRequest.expectedTransactionMode.getTransactionMode(),
          anticipatedDepositPerMonth: data.walletUserData.empDetailRequest.anticipatedDepositPerMonth,
          isPoliticallyExposed: data.walletUserData.empDetailRequest.isPoliticallyExposed ?? "false",
          isInvolvedInPolitics: data.walletUserData.empDetailRequest.isInvolvedInPolitics ?? "false",
          isPositionInParty:  data.walletUserData.empDetailRequest.isPositionInParty ?? "false",
          isMemberOfInst: data.walletUserData.empDetailRequest.isMemberOfInst ?? "false",
        )));

        if(apiResult.isLeft()) {
          data.stepperValue = KYCStep.REVIEW.getStep();
          data.stepperName = KYCStep.REVIEW.toString();


          // Store the reset data
          final savedResult = await storeWalletOnBoardingData(Parameter(
              walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                  stepperValue: data.stepperValue,
                  stepperName: data.stepperName,
                  walletUserData: data.walletUserData)));

          if(savedResult.isLeft()) {
            log("Could not save Data");
          }
        }

        yield apiResult.fold((l) {

          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else {
            return EmploymentDetailsFailedState(
                message: ErrorMessages().mapFailureToMessage(l));
          }
        }, (r) {
          return UpdateEmployeeDetailsSuccess();
        });

      }
    }
  }
}
