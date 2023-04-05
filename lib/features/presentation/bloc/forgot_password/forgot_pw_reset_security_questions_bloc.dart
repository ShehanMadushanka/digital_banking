import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/datasources/local_data_source.dart';
import 'package:cdb_mobile/features/domain/entities/request/forgot_pw_reset_security_questions_request_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/forgot_password/forgot_pw_reset_security_question.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_pw_reset_security_questions_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_pw_reset_security_questions_state.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';

class ForgotPwResetSecQuestionsBloc extends BaseBloc<
    ForgotPwResetSecQuestionsEvent, BaseState<ForgotPwResetSecQuestionsState>> {

  final GetForgotPwResetSecQuestions useCaseForgotPwResetSecQuestions;
  final LocalDataSource localDataSource;

  ForgotPwResetSecQuestionsBloc({this.localDataSource, this.useCaseForgotPwResetSecQuestions})
      : super(InitialForgotPwResetSecQuestionsState());

  @override
  Stream<BaseState<ForgotPwResetSecQuestionsState>> mapEventToState(
      ForgotPwResetSecQuestionsEvent event) async* {
    if (event is GetForgotPwResetSecQuestionsEvent) {
      yield APILoadingState();

      final username = await localDataSource.getUsername();
      final _result = await useCaseForgotPwResetSecQuestions(
          ForgotPwResetSecQuestionsRequestEntity(
              messageType: kMessageTypeAnswerSecurityQuestionForgotPwdReq,
              username: username,
              answers: event.answers));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return GetForgotPwResetSecQuestionsFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return GetForgotPwResetSecQuestionsSuccessState();
      });

      yield _result.fold((l) {
        return SaveForgotPwResetSecQuestionsFailedState(
            message: ErrorMessages().mapFailureToMessage(l));
      }, (r) {
        return SaveForgotPwResetSecQuestionsSuccessState(
          otpReferenceNo: r.data.otpReferenceNo,
          mobile: r.data.mobile,
          email: r.data.email,
        );
      });
    } else {
      yield SaveForgotPwResetSecQuestionsFailedState(
          message: ErrorMessages.errorSomethingWentWrong);
    }
  }
}
