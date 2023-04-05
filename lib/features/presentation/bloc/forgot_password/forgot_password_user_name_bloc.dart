import 'package:cdb_mobile/features/data/models/requests/check_acc_no_nic_request.dart';
import 'package:cdb_mobile/utils/app_validator.dart';

import '../../../../core/network/network_config.dart';
import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../domain/entities/request/forgot_password_user_name_request_entity.dart';
import '../../../domain/usecases/forgot_password/forgot_pw_using_acc_no.dart';
import '../../../domain/usecases/forgot_password_user_name/forgot_password_user_name.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'forgot_password_user_name_event.dart';
import 'forgot_password_user_name_state.dart';

class ForgotPasswordUserNameBloc extends BaseBloc<ForgotPasswordUserNameEvent,
    BaseState<ForgotPasswordUserNameState>> {
  final GetForgotPasswordUserName useCaseForgotPasswordUserName;
  final LocalDataSource localDataSource;
  final ForgotPwUsingAccountNumber forgotPwUsingAccountNumber;

  ForgotPasswordUserNameBloc(
      {this.localDataSource,
      this.useCaseForgotPasswordUserName,
      this.forgotPwUsingAccountNumber})
      : super(InitialForgotPasswordUserNameState());

  @override
  Stream<BaseState<ForgotPasswordUserNameState>> mapEventToState(
      ForgotPasswordUserNameEvent event) async* {
    if (event is GetForgotPasswordUserNameEvent) {
      yield APILoadingState();

      final _result = await useCaseForgotPasswordUserName(
          ForgotPasswordUserNameRequestEntity(
              messageType: kForgotPasswordUserNameRequestType,
              username: event.username,
              nic: event.nic));

      yield _result.fold((l) {
        final failure = l as ServerFailure;
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          if (failure.errorResponse.errorCode ==
                  APIResponse.RESPONSE_FORGOT_PWD_INVALID_USERNAME ||
              failure.errorResponse.errorCode ==
                  APIResponse.RESPONSE_FORGOT_PWD_INVALID_NIC) {
            return GetForgotPasswordUserNameAPIFailedState(
                message: ErrorMessages().mapFailureToMessage(l));
          } else {
            return GetForgotPasswordUserNameFailedState(
                message: ErrorMessages().mapFailureToMessage(l));
          }
        }
      }, (r) {
        return GetForgotPasswordUserNameSuccessState(forgetPasswordResponse: r);
      });
    } else if (event is ForgotPasswordUsingAccountNumber) {
      if(AppValidator().advancedNicValidation(event.nic)){
        yield APILoadingState();

        final _result = await forgotPwUsingAccountNumber(
          CheckAccountNoNicRequest(
              messageType: kForgotPwUsingAccNumberRequestType,
              accountNumber: event.accountNumber,
              nic: event.nic),
        );

        yield _result.fold((l) {
          final failure = l as ServerFailure;
          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else {
            return ForgotPWUsingAccountNumberFailState(
                errorMessage: ErrorMessages().mapFailureToMessage(l));
          }
        }, (r) {
          return ForgotPWUsingAccountNumberSuccessState(
              otpRef: r.data.otpReferenceNo);
        });
      }else{
        yield NICValidationFailedState();
      }
    }
  }
}
