import 'dart:convert';
import 'dart:developer';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/customer_reg_request.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/customer_reg_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/customer_registration/customer_registration.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'contact_information_event.dart';
import 'contact_information_state.dart';

class ContactInformationBloc extends BaseBloc<ContactInformationEvent,
    BaseState<ContactInformationState>> {
  final LocalDataSource appSharedData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final CustomerRegistration customerRegistration;
  final AppValidator appValidator;

  ContactInformationBloc({
    this.appSharedData,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.customerRegistration,
    this.appValidator,
  }) : super(InitialContactInformationState());

  @override
  Stream<BaseState<ContactInformationState>> mapEventToState(
      ContactInformationEvent event) async* {
    /// StoreContactInformationEvent
    if (event is StoreContactInformationEvent) {
      // Get the Wallet Data
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {

        // Set the New Values
        final WalletOnBoardingData walletOnBoardingData =
            result.getOrElse(() => null);
        walletOnBoardingData.walletUserData.customerRegistrationRequest
            .mobileNo = event.customerRegistrationRequest.mobileNo;
        walletOnBoardingData.walletUserData.customerRegistrationRequest.email =
            event.customerRegistrationRequest.email;
        walletOnBoardingData.walletUserData.customerRegistrationRequest
            .perAddress = event.customerRegistrationRequest.perAddress;

        // Store the Wallet Data
        final savedResult = await storeWalletOnBoardingData(Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperValue: event.stepValue,
                stepperName: event.stepName,
                walletUserData: walletOnBoardingData.walletUserData)));
        yield savedResult.fold((l) {
          return ContactInformationFailedState(message: "Failed to load data");
        }, (r) {
          return ContactInformationSubmittedSuccessState(
              isBackButtonClick: event.isBackButtonClick);
        });

      } else {
        yield ContactInformationFailedState(message: "Failed to load data");
      }
    }

    /// GetContactInformationEvent
    else if (event is GetContactInformationEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      yield result.fold(
        (failure) {
          return ContactInformationFailedState(message: "Failed to load data");
        },
        (response) {
          log(jsonEncode(response));
          return ContactInformationLoadedState(walletOnBoardingData: response);
        },
      );
    }

    /// Send API
    else if (event is SubmitCusRegEvent) {

      if(!appValidator.validateEmail(event.email)) {
        yield ContactInformationFailedState(message: AppString.validEmail);
        return;
      } else if(!appValidator.validateMobileNumber(event.mobileNo)) {
        yield ContactInformationFailedState(message: AppString.validMobile);
        return;
      }

      // Get the Wallet Data
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      final obj = result.fold((failure) => failure, (response) => response,);
      if (obj is Failure) {
        yield ContactInformationFailedState(message: "Failed to load data");
      } else {

        // Send Customer Reg Request
        final WalletOnBoardingData data = obj as WalletOnBoardingData;
        
        final apiResult = await customerRegistration(CustomerRegParams(
            customerRegistrationRequestEntity:
                CustomerRegistrationRequestEntity(
          messageType:
              data.walletUserData.customerRegistrationRequest.messageType,
          title:
              data.walletUserData.customerRegistrationRequest.title.getTitle(),
          initials: data.walletUserData.customerRegistrationRequest.initials,
          initialsInFull:
              data.walletUserData.customerRegistrationRequest.initialsInFull,
          lastName: data.walletUserData.customerRegistrationRequest.lastName,
          nationality:
              data.walletUserData.customerRegistrationRequest.nationality,
          gender: data.walletUserData.customerRegistrationRequest.gender,
          language: data.walletUserData.customerRegistrationRequest.language
              .getLanguage(),
          religion: data.walletUserData.customerRegistrationRequest.religion
              .getReligion(),
          nic: data.walletUserData.customerRegistrationRequest.nic,
          dateOfBirth:
              data.walletUserData.customerRegistrationRequest.dateOfBirth,
          mobileNo: event.mobileNo,
          email: event.email,
          maritalStatus:
              data.walletUserData.customerRegistrationRequest.maritalStatus,
          mothersMaidenName:
              data.walletUserData.customerRegistrationRequest.mothersMaidenName,
          perAddress: [PerAddress(addressLine1: event.address1,addressLine2: event.address2,addressLine3: event.address3,city: event.city,equalityWithNic: event.isAddSameAsNIC)]
          // perAddress:
          //     data.walletUserData.customerRegistrationRequest.perAddress,
        )));

        // If API is failed Reset the stepper values
        // if(apiResult.isLeft()) {
        //   // if(!event.isEditing) {
        //     data.stepperValue = KYCStep.CONTACTINFO.getStep();
        //     data.stepperName = KYCStep.CONTACTINFO.toString();
        //
        //     // Store the reset data
        //     final savedResult = await storeWalletOnBoardingData(Parameter(
        //         walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
        //             stepperValue: data.stepperValue,
        //             stepperName: data.stepperName,
        //             walletUserData: data.walletUserData)));
        //
        //     if(savedResult.isLeft()) {
        //       log("Could not save Data");
        //     }
        //   // }
        // }

        yield apiResult.fold((l) {

          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else {

            return ContactInformationFailedState(
                message: ErrorMessages().mapFailureToMessage(l));
          }
        }, (r) {
          return ContactInfoApiSuccessState();
        });
      }
    }
  }
}
