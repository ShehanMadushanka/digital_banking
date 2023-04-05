import 'dart:convert';
import 'dart:io';

import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/models/requests/document_verification_request.dart';
import 'package:cdb_mobile/features/domain/entities/request/document_verification_api_request_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/document_verification/document_verification.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_utils.dart';

import '../../../../../error/failures.dart';
import '../../../../data/datasources/local_data_source.dart';
import '../../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../../domain/entities/request/wallet_onboarding_data_entity.dart';
import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'document_verification_event.dart';
import 'document_verification_state.dart';
import '../../../../../utils/app_extensions.dart';

class DocumentVerificationBloc extends BaseBloc<DocumentVerificationEvent,
    BaseState<DocumentVerificationState>> {
  final LocalDataSource appSharedData;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final DocumentVerification useCaseDocumentVerification;

  DocumentVerificationBloc(
      {this.appSharedData,
      this.getWalletOnBoardingData,
      this.storeWalletOnBoardingData,
      this.useCaseDocumentVerification})
      : super(InitialDocumentVerificationState());

  @override
  Stream<BaseState<DocumentVerificationState>> mapEventToState(
      DocumentVerificationEvent event) async* {
    /// StoreDocumentVerificationInformationEvent
    if (event is StoreDocumentVerificationInformationEvent) {
      // Get the Wallet Data
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Set the New Values
        final WalletOnBoardingData walletOnBoardingData =
            result.getOrElse(() => null);
        if (walletOnBoardingData.walletUserData.documentVerificationRequest !=
            null) {
          walletOnBoardingData.walletUserData.documentVerificationRequest
              .selfie = event.documentVerificationRequest.selfie;
          walletOnBoardingData.walletUserData.documentVerificationRequest
              .billingProof = event.documentVerificationRequest.billingProof;
          walletOnBoardingData.walletUserData.documentVerificationRequest
              .icFront = event.documentVerificationRequest.icFront;
          walletOnBoardingData.walletUserData.documentVerificationRequest
              .icBack = event.documentVerificationRequest.icBack;
          walletOnBoardingData.walletUserData.documentVerificationRequest
              .proofType = event.documentVerificationRequest.proofType;
        } else {
          final DocumentVerificationRequest documentVerificationRequest =
              DocumentVerificationRequest(
                  selfie: event.documentVerificationRequest.selfie,
                  icFront: event.documentVerificationRequest.icFront,
                  icBack: event.documentVerificationRequest.icBack,
                  billingProof: event.documentVerificationRequest.billingProof,
                  proofType: event.documentVerificationRequest.proofType);
          walletOnBoardingData.walletUserData.documentVerificationRequest =
              documentVerificationRequest;
        }

        // Store the Wallet Data
        final savedResult = await storeWalletOnBoardingData(Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperValue: event.stepValue,
                stepperName: event.stepName,
                walletUserData: walletOnBoardingData.walletUserData)));
        final obj = savedResult.fold((l) => l, (r) => r);
        if (obj is Failure) {
          yield DocumentVerificationInformationFailedState(
              message: "Failed to load data");
        } else {
          yield DocumentVerificationInformationSubmittedSuccessState(
              isBackButtonClick: event.isBackButtonClick);
        }
      } else {
        yield DocumentVerificationInformationFailedState(
            message: "Failed to load data");
      }
    } else if (event is SendDocumentVerificationInformationEvent) {
      yield APILoadingState();
      List<ImageListEntity> dataSet = [];
      dataSet.add(ImageListEntity(name: 'SELFIE', image: AppUtils.convertBase64(base64Encode(File(event.selfie).readAsBytesSync()))));

      if(event.proofType!=null){
        if(event.proofType == 'nic'){
          dataSet.add(ImageListEntity(name: 'NIC_FRONT', image: AppUtils.convertBase64(base64Encode(File(event.icFront).readAsBytesSync()))));
          dataSet.add(ImageListEntity(name: 'NIC_BACK', image: AppUtils.convertBase64(base64Encode(File(event.icBack).readAsBytesSync()))));
        }else if(event.proofType == 'driving'){
          dataSet.add(ImageListEntity(name: 'DRIVING_LICENSE', image: AppUtils.convertBase64(base64Encode(File(event.icFront).readAsBytesSync()))));
        }else if(event.proofType == 'passport'){
          dataSet.add(ImageListEntity(name: 'PASSPORT', image: AppUtils.convertBase64(base64Encode(File(event.icFront).readAsBytesSync()))));
        }
      }

      if (event.billingProof != null && event.billingProof.isNotEmpty) {
        dataSet.add(
            ImageListEntity(name: 'BILLING_PROOF', image: AppUtils.convertBase64(base64Encode(File(event.billingProof).readAsBytesSync()))));
      }

      final result = await useCaseDocumentVerification(
        DocumentVerificationApiRequestEntity(
          messageType: kDocumentVerificationRequestType,
          imageList: dataSet,
        ),
      );

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return DocumentVerificationAPIFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return DocumentVerificationAPISuccessState();
      });
    } else if (event is GetDocumentVerificationInformationEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      final obj = result.fold(
        (failure) => failure,
        (response) => response,
      );
      if (obj is Failure) {
        yield DocumentVerificationInformationFailedState(
            message: "Failed to load data");
      } else {
        print(jsonEncode(obj));
        yield DocumentVerificationInformationLoadedState(
            walletOnBoardingData: obj);
      }
    }
  }
}
