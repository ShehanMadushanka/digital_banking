import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_extensions.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../domain/entities/request/forgot_pw_create_new_password_request_entity.dart';
import '../../../domain/usecases/epicuser_id/save_epicuser_id.dart';
import '../../../domain/usecases/forgot_password/forgot_pw_create_new_password.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'forgot_pw_create_new_password_event.dart';
import 'forgot_pw_create_new_password_state.dart';


class ForgotPwCreateNewPasswordBloc extends BaseBloc<
    ForgotPwCreateNewPasswordEvent, BaseState<ForgotPwCreateNewPasswordState>> {
  final LocalDataSource localDataSource;
  final ForgotPwCreateNewPassword forgotPwCreateNewPassword;
  final SetEpicUserID setEpicUserID;

  ForgotPwCreateNewPasswordBloc({
    this.localDataSource,
    this.forgotPwCreateNewPassword,
    this.setEpicUserID,
  }) : super(InitialForgotPwCreateNewPasswordState());

  @override
  Stream<BaseState<ForgotPwCreateNewPasswordState>> mapEventToState(
      ForgotPwCreateNewPasswordEvent event) async* {
    if (event is ForgotPasswordCreateNewPasswordEvent) {
      yield APILoadingState();

      final username = await localDataSource.getUsername();
      final _result = await forgotPwCreateNewPassword(
          ForgotPwCreateNewPasswordRequestEntity(
              messageType: kForgotPwCreateNewPasswordRequestType,
              username: username,
              newPassword: event.password.toBase64(),
              confirmPassword: event.confirmPassword.toBase64()));

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return ForgotPwCreateNewPasswordFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        return ForgotPwCreateNewPasswordSuccessState();
      });
    } else {
      yield SaveUserFailedState(message: ErrorMessages.errorSomethingWentWrong);
    }
  }
}
