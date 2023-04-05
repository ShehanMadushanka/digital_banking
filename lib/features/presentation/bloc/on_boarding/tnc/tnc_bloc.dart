import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/models/responses/get_terms_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/get_terms_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/terms_accept_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/terms/accept_terms_data.dart';
import 'package:cdb_mobile/features/domain/usecases/terms/get_terms_data.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/enums.dart';

import '../../../../domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../../../domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'tnc_event.dart';
import 'tnc_state.dart';

class TnCBloc extends BaseBloc<TnCEvent, BaseState<TnCState>> {
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;
  final GetTermsData useCaseGetTerms;
  final AcceptTermsData useCaseAcceptTerms;

  TnCBloc({
    this.getWalletOnBoardingData,
    this.storeWalletOnBoardingData,
    this.useCaseGetTerms,
    this.useCaseAcceptTerms,
  }) : super(InitialTnCState());

  @override
  Stream<BaseState<TnCState>> mapEventToState(TnCEvent event) async* {
    if (event is GetTermsEvent) {
      yield APILoadingState();
      final result = await useCaseGetTerms(
        GetTermsRequestEntity(
          messageType: kMessageTypeTermsAndConditionsGetReq,
          termType: event.termType,
        ),
      );

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return APIFailureState();
        } else {
          return TermsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        final TermsData termsData = r.data.data;
        return TermsLoadedState(termsData: termsData);
      });
    } else if (event is AcceptTermsEvent) {
      yield APILoadingState();

      await storeWalletOnBoardingData(
        Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
                stepperName: KYCStep.PERSONALINFO.toString(),
                stepperValue: KYCStep.PERSONALINFO.getStep())),
      );

      final result = await useCaseAcceptTerms(
        TermsAcceptRequestEntity(
          termId: event.termId,
          acceptedDate: event.acceptedDate,
          messageType: kMessageTypeTermsAndConditionsAcceptReq,
        ),
      );

      yield result.fold((l) {
        if (l is AuthorizedFailure) {
          return APIFailureState();
        } else {
          return TermsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return TermsSubmittedState();
      });
    }
  }
}
