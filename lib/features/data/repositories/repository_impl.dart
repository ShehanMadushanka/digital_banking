import 'package:cdb_mobile/features/data/models/requests/change_password_request.dart';
import 'package:cdb_mobile/features/data/models/requests/check_acc_no_nic_request.dart';
import 'package:cdb_mobile/features/data/models/responses/check_acc_no_nic_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/network_info.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../domain/entities/request/challenge_request_entity.dart';
import '../../domain/entities/request/common_request_entity.dart';
import '../../domain/entities/request/contact_us_request_entity.dart';
import '../../domain/entities/request/create_user_entity.dart';
import '../../domain/entities/request/customer_reg_request_entity.dart';
import '../../domain/entities/request/delete_biller_entity.dart';
import '../../domain/entities/request/document_verification_api_request_entity.dart';
import '../../domain/entities/request/emp_details_request_entity.dart';
import '../../domain/entities/request/forgot_password_user_name_request_entity.dart';
import '../../domain/entities/request/forgot_pw_reset_security_questions_request_entity.dart';
import '../../domain/entities/request/get_terms_request_entity.dart';
import '../../domain/entities/request/language_entity.dart';
import '../../domain/entities/request/set_security_questions_request_entity.dart';
import '../../domain/entities/request/terms_accept_request_entity.dart';
import '../../domain/entities/request/verify_nic_request_entity.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/common/base_response.dart';
import '../models/requests/add_biller_request.dart';
import '../models/requests/biometric_enable_request.dart';
import '../models/requests/biometric_login_request.dart';
import '../models/requests/common_request.dart';
import '../models/requests/edit_user_biller_request.dart';
import '../models/requests/favourite_biller_request.dart';
import '../models/requests/forgot_pw_create_new_password_request.dart';
import '../models/requests/get_schedule_time_request.dart';
import '../models/requests/mobile_login_request.dart';
import '../models/requests/submit_products_request.dart';
import '../models/requests/submit_schedule_data_request.dart';
import '../models/requests/un_favorite_biller_request.dart';
import '../models/requests/wallet_onboarding_data.dart';
import '../models/responses/add_biller_response.dart';
import '../models/responses/biometric_enable_response.dart';
import '../models/responses/city_response.dart';
import '../models/responses/contact_us_response.dart';
import '../models/responses/create_user_response.dart';
import '../models/responses/forgot_password_user_name_response.dart';
import '../models/responses/forgot_pw_reset_security_questions_response.dart';
import '../models/responses/get_biller_category_list_response.dart';
import '../models/responses/get_biller_list_response.dart';
import '../models/responses/get_other_products_response.dart';
import '../models/responses/get_schedule_time_response.dart';
import '../models/responses/get_terms_response.dart';
import '../models/responses/mobile_login_response.dart';
import '../models/responses/otp_response.dart';
import '../models/responses/schedule_date_response.dart';
import '../models/responses/sec_question_response.dart';
import '../models/responses/submit_other_products_response.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;

  RepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
    @required this.localDataSource,
  });

  /// Splash
  @override
  Future<Either<Failure, BaseResponse>> getSplash(
      CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getSplash(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Verify NIC
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> verifyNIC(
      VerifyNICRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.verifyNIC(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get Terms and Conditions
  @override
  Future<Either<Failure, BaseResponse<GetTermsResponse>>> getTerms(
      GetTermsRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getTerms(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Accept Terms and Conditions
  @override
  Future<Either<Failure, BaseResponse>> acceptTerms(
      TermsAcceptRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.acceptTerms(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CreateUserResponse>>> createUser(
      CreateUserEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.createUser(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get City Detail
  @override
  Future<Either<Failure, BaseResponse<CityDetailResponse>>> cityRequest(
      CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getCityData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get On Boarding Wallet Data From Local Storage
  @override
  Future<Either<Failure, WalletOnBoardingData>>
      getWalletOnBoardingData() async {
    try {
      final WalletOnBoardingData walletOnBoardingData =
          await localDataSource.getAppWalletOnBoardingData();
      return Right(walletOnBoardingData);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  /// Store On Boarding Wallet Data into Local Storage
  @override
  Future<Either<Failure, bool>> storeWalletOnBoardingData(
      WalletOnBoardingData walletOnBoardingData) async {
    try {
      final bool isDataStored = await localDataSource
          .storeAppWalletOnBoardingData(walletOnBoardingData);
      return Right(isDataStored);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ScheduleDateResponse>>> getScheduleDates(
      CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getScheduleDates(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetOtherProductsResponse>>>
      getOtherProducts(CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getOtherProducts(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Get Designation Data
  @override
  Future<Either<Failure, BaseResponse<CityDetailResponse>>> designationRequest(
      CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getDesignationData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SubmitProductsResponse>>>
      submitOtherProducts(SubmitProductsRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.submitOtherProducts(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Register Customer
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> registerCustomer(
      CustomerRegistrationRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.registerCustomer(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  /// Submit Emp Details
  @override
  Future<Either<Failure, BaseResponse<Serializable>>> submitEmpDetails(
      EmpDetailsRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.submitEmpDetails(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SecurityQuestionResponse>>>
      getSecurityQuestions(CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getSecurityQuestions(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> setSecurityQuestions(
      SetSecurityQuestionsEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.setSecurityQuestions(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> otpVerification(
      ChallengeRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.otpVerification(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> documentVerification(
      DocumentVerificationApiRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.documentVerification(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> setPreferredLanguage(
      LanguageEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.setPreferredLanguage(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getEpicUserID() async {
    try {
      return Right(localDataSource.getEpicUserId());
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setEpicUserID(String epicUserID) async {
    try {
      localDataSource.setEpicUserId(epicUserID);
      return const Right(true);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetScheduleTimeResponse>>>
      getScheduleTimeSlot(GetScheduleTimeRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getScheduleTimeSlots(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> submitScheduleData(
      SubmitScheduleDataRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.submitScheduleData(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> mobileLogin(
      MobileLoginRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.mobileLogin(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> changePassword(
      ChangePasswordRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.changePassword(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<BiometricEnableResponse>>>
      enableBiometric(BiometricEnableRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.biometricEnable(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<OTPResponse>>> otpRequest(
      CommonRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.otpRequest(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  ///Contact Us
  @override
  Future<Either<Failure, BaseResponse<ContactUsResponseModel>>> getContactUs(
      ContactUsRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getContactUs(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  ///Forgot Password Reset Method using Security Questions
  @override
  Future<Either<Failure, BaseResponse<ForgotPwResetSecQuestionsResponseModel>>>
      getForgotPwResetSecQuestions(
          ForgotPwResetSecQuestionsRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters =
            await remoteDataSource.getForgotPwResetSecQuestions(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> savePreferredLanguage() async {
    try {
      localDataSource.setLanguageState();
      return const Right(true);
    } on ServerException catch (e) {
      return Left(CacheFailure());
    } on UnAuthorizedException catch (e) {
      return Left(AuthorizedFailure(e.errorResponseModel));
    }
  }

  ///Forgot Password Using User Name
  @override
  Future<Either<Failure, BaseResponse<ForgotPasswordUserNameResponseModel>>>
      getForgotPwUsername(ForgotPasswordUserNameRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getForgotPwUsername(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> biometricLogin(
      BiometricLoginRequest params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.biometricLogin(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetSavedBillersResponse>>>
      getSavedBillerList(CommonRequestEntity params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.getSavedBillers(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<AddBillerResponse>>> addBiller(
      AddBillerRequest addBillerRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource.addBiller(addBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<GetBillerCategoryListResponse>>>
      getBillerCategoryList(CommonRequestEntity commonRequestEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters =
            await remoteDataSource.getBillerCategoryList(commonRequestEntity);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> editBiller(
      EditUserBillerRequest editUserBillerRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters =
            await remoteDataSource.editBiller(editUserBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> deleteBiller(
      DeleteBillerEntity deleteBillerEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters =
            await remoteDataSource.deleteBiller(deleteBillerEntity);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters =
            await remoteDataSource.favouriteBiller(favouriteBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> forgotPwCreateNewPassword(
      ForgotPwCreateNewPasswordRequestModel
          forgotPwCreateNewPasswordRequestModel) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource
            .forgotPwCreateNewPassword(forgotPwCreateNewPasswordRequestModel);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<Serializable>>> unFavoriteBiller(
      UnFavoriteBillerRequest unFavoriteBillerRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters =
            await remoteDataSource.unFavoriteBiller(unFavoriteBillerRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<CheckAccountNoNicResponse>>>
      checkAccountNumberNIC(
          CheckAccountNoNicRequest checkAccountNoNicRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource
            .checkAccountNumberNIC(checkAccountNoNicRequest);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
