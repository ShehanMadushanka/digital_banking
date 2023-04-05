import 'package:cdb_mobile/features/data/datasources/local_data_source.dart';
import 'package:cdb_mobile/features/data/models/requests/biometric_login_request.dart';
import 'package:cdb_mobile/features/data/models/requests/wallet_onboarding_data.dart';
import 'package:cdb_mobile/features/domain/usecases/biometric/biometric_login.dart';
import 'package:cdb_mobile/features/domain/usecases/epicuser_id/save_epicuser_id.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../../../../error/failures.dart';
import '../../../../error/messages.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_strings.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/mobile_login_request.dart';
import '../../../domain/usecases/login/mobile_login.dart';
import '../base_bloc.dart';
import '../base_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, BaseState<LoginState>> {
  final MobileLogin mobileLogin;
  final BiometricLogin biometricLogin;
  final LocalDataSource localDataSource;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final SetEpicUserID setEpicUserID;

  LoginBloc(
      {this.mobileLogin,
      this.localDataSource,
      this.getWalletOnBoardingData,
      this.biometricLogin,
      this.setEpicUserID})
      : super(InitialLoginState());

  @override
  Stream<BaseState<LoginState>> mapEventToState(LoginEvent event) async* {





    if (event is MobileLoginEvent) {

      if (event.username.isEmpty) {
        yield MobileLoginFailedState(message: AppString.emptyUsername);
      }

      else if (event.password.isEmpty) {
        yield MobileLoginFailedState(message: AppString.password);
      }

      else {
        yield APILoadingState();

        final _result = await mobileLogin(
          MobileLoginRequest(
            messageType: kMobileLoginRequestType,
            username: event.username,
            password: event.password.toBase64(),
          ),
        );

        yield _result.fold((l) {
          return MobileLoginAPIFailedState(message: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          localDataSource.setUserName(event.username);
          setEpicUserID(r.epicUserID);
          localDataSource.setAccessToken(r.data.accessToken);
          localDataSource.setRefreshToken(r.data.refreshToken);

          AppConstants.IS_USER_LOGGED = true;
          AppConstants.TOKEN_EXPIRE_TIME =
              DateTime.now().add(Duration(seconds: r.data.tokenExpiresIn));

          return MobileLoginSuccessState(
              mobileLoginResponse: r.data,
              responseCode: r.responseCode,
              responseDescription: r.responseDescription);
        });
      }
    }
    else if (event is BiometricLoginEvent) {
      yield APILoadingState();
      final _result = await biometricLogin(
        BiometricLoginRequest(
            messageType: kBiometricLoginRequestType,
            uniqueCode: AppConstants.BIOMETRIC_CODE),
      );

      yield _result.fold((l) {
        if (l is AuthorizedFailure) {
          return SessionExpireState();
        } else {
          return MobileLoginAPIFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }
      }, (r) {
        setEpicUserID(r.epicUserID);
        return MobileLoginSuccessState(
            mobileLoginResponse: r.data,
            responseCode: r.responseCode,
            responseDescription: r.responseDescription);
      });
    }
    else if (event is CheckCredentialAvailability) {
      final availability = await localDataSource.hasUsername();
      if (availability) {
        final username = await localDataSource.getUsername();
        yield GetLoginCredentials(isAvailable: true, username: username);
      } else {
        yield GetLoginCredentials(isAvailable: false);
      }
    }
    else if (event is GetStepperValueEvent) {
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));

      final obj = result.fold(
        (failure) => failure,
        (response) => response,
      );
      if (obj is Failure) {
        yield MobileLoginAPIFailedState(
            message: "Could not load data from local Storage");
      } else {
        final WalletOnBoardingData walletOnBoardingData = obj;

        if (walletOnBoardingData != null) {
          if (walletOnBoardingData.stepperValue > 0) {
            yield StepperValueLoadedState(
                routeString: Routes.kRegProgress,
                stepperName: walletOnBoardingData.stepperName,
                stepperValue: walletOnBoardingData.stepperValue,
                initialLaunchDone: false);
          } else {
            yield StepperValueLoadedState(
                routeString: Routes.kNewRegView, initialLaunchDone: false);
          }
        } else {
          yield StepperValueLoadedState(
              routeString: Routes.kNewRegView, initialLaunchDone: false);
        }
      }
    }
    else if (event is RequestBiometricPromptEvent) {
      yield BiometricPromptSuccessState();
    }
  }
}
