import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/responses/forgot_password_user_name_response.dart';

import '../base_state.dart';

abstract class ForgotPasswordUserNameState
    extends BaseState<ForgotPasswordUserNameState> {}

class InitialForgotPasswordUserNameState extends ForgotPasswordUserNameState {}

class GetForgotPasswordUserNameSuccessState
    extends ForgotPasswordUserNameState {
  final BaseResponse<ForgotPasswordUserNameResponseModel> forgetPasswordResponse;

  GetForgotPasswordUserNameSuccessState({this.forgetPasswordResponse});
}

class GetForgotPasswordUserNameFailedState extends ForgotPasswordUserNameState {
  final String message;

  GetForgotPasswordUserNameFailedState({this.message});
}

class GetForgotPasswordUserNameAPIFailedState extends ForgotPasswordUserNameState {
  final String message;

  GetForgotPasswordUserNameAPIFailedState({this.message});
}

class ForgotPWUsingAccountNumberSuccessState extends ForgotPasswordUserNameState{
  final String otpRef;

  ForgotPWUsingAccountNumberSuccessState({this.otpRef});
}

class ForgotPWUsingAccountNumberFailState extends ForgotPasswordUserNameState{
  final String errorMessage;

  ForgotPWUsingAccountNumberFailState({this.errorMessage});
}

class NICValidationFailedState extends ForgotPasswordUserNameState{}

