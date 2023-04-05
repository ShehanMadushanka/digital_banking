import 'package:cdb_mobile/features/domain/entities/request/set_security_questions_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/security_questions/set_security_questions.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/enums.dart';

import '../../../../../error/failures.dart';
import '../../../../../error/messages.dart';
import '../../../../../utils/api_msg_types.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'security_questions_event.dart';
import 'security_questions_state.dart';

class SecurityQuestionsBloc extends BaseBloc<SecurityQuestionsEvent,
    BaseState<SecurityQuestionsState>> {
  final SetSecurityQuestions useCaseSetQuestions;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;

  SecurityQuestionsBloc(
      {this.useCaseSetQuestions,
      this.getWalletOnBoardingData,
      this.storeWalletOnBoardingData})
      : super(InitialSecurityQuestionsState());

  @override
  Stream<BaseState<SecurityQuestionsState>> mapEventToState(
      SecurityQuestionsEvent event) async* {
    if (event is SetSecurityQuestionsEvent) {
      yield APILoadingState();

      final _result = await useCaseSetQuestions(SetSecurityQuestionsEntity(
          messageType: kMessageTypeAnswerSecurityQuestionReq,
          answerList: event.answerList));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return SetSecurityQuestionsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return SetSecurityQuestionsSuccessState();
      });
    } else if (event is SaveSecurityQuestionsEvent) {
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Store the Wallet Data
        final _result = await storeWalletOnBoardingData(
          Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.CREATEUSER.toString(),
              stepperValue: KYCStep.CREATEUSER.getStep(),
              walletUserData: result
                  .getOrElse(
                    () => null,
                  )
                  .walletUserData,
            ),
          ),
        );

        yield _result.fold((l) {
          return SaveSecurityQuestionsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          return SaveSecurityQuestionsSuccessState();
        });
      } else {
        yield SaveSecurityQuestionsFailedState(
            message: ErrorMessages.errorSomethingWentWrong);
      }
    }
  }
}
