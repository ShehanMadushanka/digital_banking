import 'package:cdb_mobile/error/messages.dart';
import 'package:cdb_mobile/features/data/datasources/local_data_source.dart';
import 'package:cdb_mobile/features/domain/entities/request/create_user_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/wallet_onboarding_data_entity.dart';
import 'package:cdb_mobile/features/domain/usecases/epicuser_id/save_epicuser_id.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import 'package:cdb_mobile/utils/api_msg_types.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/enums.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../domain/usecases/create_user/create_user.dart';
import '../../base_bloc.dart';
import '../../base_state.dart';
import 'create_user_event.dart';
import 'create_user_state.dart';

class CreateUserBloc
    extends BaseBloc<CreateUserParentEvent, BaseState<CreateUserState>> {
  final LocalDataSource appSharedData;
  final CreateUser createUser;
  final SetEpicUserID setEpicUserID;
  final GetWalletOnBoardingData getWalletOnBoardingData;
  final StoreWalletOnBoardingData storeWalletOnBoardingData;

  CreateUserBloc(
      {this.appSharedData,
      this.createUser,
      this.setEpicUserID,
      this.getWalletOnBoardingData,
      this.storeWalletOnBoardingData})
      : super(InitialCreateUserState());

  @override
  Stream<BaseState<CreateUserState>> mapEventToState(
      CreateUserParentEvent event) async* {
    if (event is CreateUserEvent) {
      yield APILoadingState();
      final _result = await createUser(CreateUserEntity(
          username: event.username,
          password: event.password.toBase64(),
          confirmPassword: event.confirmPassword.toBase64(),
          onBoardedType: kDigitalOnBoarding,
          messageType: kCreateUserRequestType));

      if (_result.isRight()) {
        final _eitherSuccessOrFailed = await setEpicUserID(
            _result.getOrElse(() => null).data.data.epicUserId);
        yield _eitherSuccessOrFailed.fold(
            (l) => CreateUserFailedState(
                message: ErrorMessages().mapFailureToMessage(l)),
            (r){
              appSharedData.setUserName(event.username);
              return CreateUserSuccessState();
            });
      } else {
        yield CreateUserFailedState(
          message: ErrorMessages.errorSomethingWentWrong,
        );
      }
    } else if (event is SaveUserEvent) {
      yield APILoadingState();
      final result = await getWalletOnBoardingData(
          const WalletParams(walletOnBoardingDataEntity: null));
      // Check if result is (right)
      if (result.isRight()) {
        // Store the Wallet Data
        final _result = await storeWalletOnBoardingData(
          Parameter(
            walletOnBoardingDataEntity: WalletOnBoardingDataEntity(
              stepperName: KYCStep.BIOMETRIC.toString(),
              stepperValue: KYCStep.BIOMETRIC.getStep(),
              walletUserData: result
                  .getOrElse(
                    () => null,
                  )
                  .walletUserData,
            ),
          ),
        );

        yield _result.fold((l) {
          return SaveUserFailedState(
              message: ErrorMessages().mapFailureToMessage(l));
        }, (r) {
          return SaveUserSuccessState();
        });
      } else {
        yield SaveUserFailedState(
            message: ErrorMessages.errorSomethingWentWrong);
      }
    }
  }
}
