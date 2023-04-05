import 'dart:async';
import 'package:cdb_mobile/core/network/network_config.dart';
import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/models/requests/change_password_request.dart';
import 'package:cdb_mobile/features/domain/usecases/change_password/change_password.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';

import '../base_bloc.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends BaseBloc<ChangePasswordEvent, BaseState<ChangePasswordState>> {
  final ChangePassword changePassword;

  ChangePasswordBloc({this.changePassword}) : super(ChangePasswordInitial());

  @override
  Stream<BaseState<ChangePasswordState>> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangeCurrentPasswordEvent) {
      if (event.oldPassword.isEmpty) {
        yield ChangePasswordFailState(message: AppString.emptyOldPassword);
      }
      else if (event.newPassword.isEmpty) {
        yield ChangePasswordFailState(message: AppString.emptyNewPassword);
      }
      else if (event.confirmPassword.isEmpty) {
        yield ChangePasswordFailState(
            message: AppString.emptyConfirmNewPassword);
      }
      else if (event.newPassword != event.confirmPassword) {
        yield ChangePasswordConfirmPasswordWrong(errorMessage: "Password does not match with new password");
      }
      else {
        yield APILoadingState();
        final _result = await changePassword(
          ChangePasswordRequest(
              messageType: kChangePasswordRequestType,
              oldPassword: event.oldPassword,
              newPassword: event.newPassword,
              confirmPassword: event.confirmPassword),
        );

        yield _result.fold((l) {
          final failure = l as ServerFailure;
          if (l is AuthorizedFailure) {
            return SessionExpireState();
          } else {
            if (failure.errorResponse.errorCode == APIResponse.WRONG_CURRENT_PASSWORD_ERROR_MESSAGE) {
              return ChangePasswordWrongCurrentPassword(
                  errorMessage: "Password does not match try again"
              );
            }else{
              return ChangePasswordApiFailState(
                  message: ErrorMessages().mapFailureToMessage(l));
            }
          }
        }, (r) {
          return ChangePasswordSuccessState(
            responseDescription: r.responseDescription,
            responseCode: r.responseCode,
          );
        });
      }
    }
  }
}
