import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../../../../utils/app_extensions.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_validator.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/customer_reg_request_entity.dart';
import '../../../../domain/entities/request/verify_nic_request_entity.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/customer_registration/customer_registration.dart';
import '../../../../domain/usecases/verify_nic/verify_nic.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'personal_information_event.dart';
import 'personal_information_state.dart';

class PersonalInformationBloc extends BaseBloc<PersonalInformationEvent,
    BaseState<PersonalInformationState>> {
  final LocalDataSource appSharedData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final VerifyNIC verifyNIC;
  final CustomerRegistration customerRegistration;
  final AppValidator appValidator;

  PersonalInformationBloc({
    this.appSharedData,
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.verifyNIC,
    this.customerRegistration,
    this.appValidator,
  }) : super(InitialPersonalInformationState());

  @override
  Stream<BaseState<PersonalInformationState>> mapEventToState(
      PersonalInformationEvent event) async* {
    if (event is StorePersonalInformationEvent) {
      // Get the Wallet Data
      final getResult = await getWalletOnBoardingData(const WalletParams(walletOnBoardingDataEntity: null));

      if (getResult.isRight()) {WalletOnBoardingData walletOnBoardingData = getResult.getOrElse(() => null);


        if (walletOnBoardingData == null) {

          walletOnBoardingData = WalletOnBoardingData();
          // Set Stepper Values
          walletOnBoardingData.stepperValue = event.stepValue;
          walletOnBoardingData.stepperName = event.stepName;

          if(walletOnBoardingData.walletUserData == null) {
            final WalletUserData walletUserData = WalletUserData();
            walletUserData.customerRegistrationRequest = event.customerRegistrationRequest;
            walletOnBoardingData.walletUserData = walletUserData;
          }
        } else {
          if(walletOnBoardingData.walletUserData == null) {
            final WalletUserData walletUserData = WalletUserData();
            walletUserData.customerRegistrationRequest = event.customerRegistrationRequest;
            walletOnBoardingData.walletUserData = walletUserData;
          } else {
            walletOnBoardingData.walletUserData.customerRegistrationRequest.nic = event.customerRegistrationRequest.nic;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.title = event.customerRegistrationRequest.title;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.initials = event.customerRegistrationRequest.initials;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.initialsInFull = event.customerRegistrationRequest.initialsInFull;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.lastName = event.customerRegistrationRequest.lastName;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.language = event.customerRegistrationRequest.language;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.religion = event.customerRegistrationRequest.religion;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.gender = event.customerRegistrationRequest.gender;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.dateOfBirth = event.customerRegistrationRequest.dateOfBirth;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.maritalStatus = event.customerRegistrationRequest.maritalStatus;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.mothersMaidenName = event.customerRegistrationRequest.mothersMaidenName;
            walletOnBoardingData.walletUserData.customerRegistrationRequest.nationality = event.customerRegistrationRequest.nationality;


          }
          walletOnBoardingData.stepperName = event.stepName;
          walletOnBoardingData.stepperValue = event.stepValue;
        }

        final savedResult = await storeWalletOnBoardingData(Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperValue: walletOnBoardingData.stepperValue,
                stepperName: walletOnBoardingData.stepperName,
                walletUserData: walletOnBoardingData.walletUserData)));

        yield savedResult.fold(
          (l) {
            return PersonalInformationFailedState(
                message: "Failed to load data");
          },
          (r) {
            return PersonalInformationStoredState(
                isBackButtonClick: event.isBackButtonClick);
          },
        );
      } else {
        yield PersonalInformationFailedState(message: "Failed to load data");
      }
    } else if (event is GetPersonalInformationEvent) {
      final result = await getWalletOnBoardingData(const WalletParams(walletOnBoardingDataEntity: null));


      yield result.fold(
        (failure) {
          return PersonalInformationFailedState(message: "Failed");
        },
        (response) {
          return PersonalInformationLoadedState(walletOnBoardingData: response);
        },
      );
    } else if (event is VerifyNICEvent) {

      if(!appValidator.advancedNicValidation(event.nic)) {
        yield PersonalInformationFailedState(message: AppString.validNic);
        return;
      } else if (!appValidator.nicDobValidate(event.nic, event.dob)) {
        yield PersonalInformationFailedState(message: AppString.validNicDob);
        return;
      }

      yield APILoadingState();
      final result = await verifyNIC(Params(
          verifyNicRequest: VerifyNICRequestEntity(
              messageType: kNICVerifyRequestType, nic: event.nic, dob: event.dob)));

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return PersonalInformationFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return VerifyNICSuccessState();
      });
    } else if (event is SubmitPersonalInfoEvent) {

      if(!appValidator.advancedNicValidation(event.nic)) {
        yield PersonalInformationFailedState(message: AppString.validNic);
        return;
      } else if (!appValidator.nicDobValidate(event.nic, event.dateOfBirth)) {
        yield PersonalInformationFailedState(message: AppString.validNicDob);
        return;
      }


      yield APILoadingState();
      final result = await getWalletOnBoardingData(const WalletParams(walletOnBoardingDataEntity: null));
      final obj = result.fold((failure) => failure, (response) => response,);
      if(result.isLeft()) {
        yield PersonalInformationFailedState(message: "Failed to load data");
      } else {
        // Send Customer Reg Request
        final WalletOnBoardingData data = obj as WalletOnBoardingData;

        final apiResult = await customerRegistration(CustomerRegParams(
            customerRegistrationRequestEntity:
            CustomerRegistrationRequestEntity(
                messageType: data.walletUserData.customerRegistrationRequest.messageType,
                title: event.title.getTitle(),
                initials: event.initials,
                initialsInFull: event.initialsInFull,
                lastName: event.lastName,
                nationality:event.nationality,
                gender: event.gender,
                language: event.language
                    .getLanguage(),
                religion:event.religion
                    .getReligion(),
                nic: event.nic,
                dateOfBirth: event.dateOfBirth,
                mobileNo: data.walletUserData.customerRegistrationRequest.mobileNo,
                email: data.walletUserData.customerRegistrationRequest.email,
                maritalStatus: event.martialStatus,
                mothersMaidenName: event.mothersMaidenName,
                perAddress: data.walletUserData.customerRegistrationRequest.perAddress,
              // perAddress:
              //     data.walletUserData.customerRegistrationRequest.perAddress,
            )));

        yield apiResult.fold((l) {

          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else {

            return PersonalInformationFailedState(
                message: ErrorMessages().mapFailureToMessage(l));
          }
        }, (r) {
          return SubmitPersonalInfoSuccessState();
        });

      }

    }
  }
}
