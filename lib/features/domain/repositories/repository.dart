import 'package:cdb_mobile/error/failures.dart';
import 'package:cdb_mobile/features/data/models/common/base_response.dart';
import 'package:cdb_mobile/features/data/models/requests/add_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/biometric_enable_request.dart';
import 'package:cdb_mobile/features/data/models/requests/biometric_login_request.dart';
import 'package:cdb_mobile/features/data/models/requests/change_password_request.dart';
import 'package:cdb_mobile/features/data/models/requests/check_acc_no_nic_request.dart';
import 'package:cdb_mobile/features/data/models/requests/favourite_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/edit_user_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/forgot_pw_create_new_password_request.dart';
import 'package:cdb_mobile/features/data/models/requests/get_schedule_time_request.dart';
import 'package:cdb_mobile/features/data/models/requests/mobile_login_request.dart';
import 'package:cdb_mobile/features/data/models/requests/submit_products_request.dart';
import 'package:cdb_mobile/features/data/models/requests/submit_schedule_data_request.dart';
import 'package:cdb_mobile/features/data/models/requests/wallet_onboarding_data.dart';
import 'package:cdb_mobile/features/data/models/responses/add_biller_response.dart';
import 'package:cdb_mobile/features/data/models/responses/biometric_enable_response.dart';
import 'package:cdb_mobile/features/data/models/responses/check_acc_no_nic_response.dart';
import 'package:cdb_mobile/features/data/models/responses/edit_user_biller_response.dart';
import 'package:cdb_mobile/features/data/models/responses/forgot_password_user_name_response.dart';
import 'package:cdb_mobile/features/data/models/responses/city_response.dart';
import 'package:cdb_mobile/features/data/models/responses/contact_us_response.dart';
import 'package:cdb_mobile/features/data/models/responses/create_user_response.dart';
import 'package:cdb_mobile/features/data/models/responses/forgot_pw_reset_security_questions_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_biller_category_list_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_biller_list_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_other_products_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_schedule_time_response.dart';
import 'package:cdb_mobile/features/data/models/responses/mobile_login_response.dart';
import 'package:cdb_mobile/features/data/models/responses/otp_response.dart';
import 'package:cdb_mobile/features/data/models/responses/schedule_date_response.dart';
import 'package:cdb_mobile/features/data/models/responses/sec_question_response.dart';
import 'package:cdb_mobile/features/data/models/responses/submit_other_products_response.dart';
import 'package:cdb_mobile/features/domain/entities/request/challenge_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/delete_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/favourite_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/forgot_password_user_name_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/common_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/contact_us_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/create_user_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/customer_reg_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/document_verification_api_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/forgot_pw_reset_security_questions_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/get_terms_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/language_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/set_security_questions_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/terms_accept_request_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/un_favorite_biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/request/verify_nic_request_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../data/models/common/base_response.dart';
import '../../data/models/requests/submit_products_request.dart';
import '../../data/models/requests/wallet_onboarding_data.dart';
import '../../data/models/responses/city_response.dart';
import '../../data/models/responses/create_user_response.dart';
import '../../data/models/responses/get_other_products_response.dart';
import '../../data/models/responses/schedule_date_response.dart';
import '../../data/models/responses/sec_question_response.dart';
import '../../data/models/responses/submit_other_products_response.dart';
import '../entities/request/common_request_entity.dart';
import '../entities/request/create_user_entity.dart';
import '../entities/request/customer_reg_request_entity.dart';
import '../entities/request/emp_details_request_entity.dart';
import '../entities/request/get_terms_request_entity.dart';
import '../entities/request/set_security_questions_request_entity.dart';
import '../entities/request/terms_accept_request_entity.dart';
import '../entities/request/verify_nic_request_entity.dart';

abstract class Repository {
  Future<Either<Failure, BaseResponse>> getSplash(CommonRequestEntity params);

  Future<Either<Failure, BaseResponse>> verifyNIC(
      VerifyNICRequestEntity params);

  Future<Either<Failure, BaseResponse>> getTerms(GetTermsRequestEntity params);

  Future<Either<Failure, BaseResponse>> acceptTerms(
      TermsAcceptRequestEntity params);

  Future<Either<Failure, BaseResponse<CreateUserResponse>>> createUser(
      CreateUserEntity params);

  Future<Either<Failure, BaseResponse<CityDetailResponse>>> cityRequest(
      CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<CityDetailResponse>>> designationRequest(
      CommonRequestEntity params);

  Future<Either<Failure, WalletOnBoardingData>> getWalletOnBoardingData();

  Future<Either<Failure, bool>> storeWalletOnBoardingData(
      WalletOnBoardingData walletOnBoardingData);

  Future<Either<Failure, BaseResponse<ScheduleDateResponse>>> getScheduleDates(
      CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<GetOtherProductsResponse>>>
      getOtherProducts(CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<SubmitProductsResponse>>>
      submitOtherProducts(SubmitProductsRequest params);

  Future<Either<Failure, BaseResponse>> registerCustomer(
      CustomerRegistrationRequestEntity params);

  Future<Either<Failure, BaseResponse>> submitEmpDetails(
      EmpDetailsRequestEntity params);

  Future<Either<Failure, BaseResponse<SecurityQuestionResponse>>>
      getSecurityQuestions(CommonRequestEntity params);

  Future<Either<Failure, BaseResponse>> setSecurityQuestions(
      SetSecurityQuestionsEntity params);

  Future<Either<Failure, BaseResponse>> otpVerification(
      ChallengeRequestEntity params);

  Future<Either<Failure, BaseResponse>> documentVerification(
      DocumentVerificationApiRequestEntity params);

  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> mobileLogin(
      MobileLoginRequest params);

  Future<Either<Failure, BaseResponse>> changePassword(
      ChangePasswordRequest params);

  Future<Either<Failure, BaseResponse>> setPreferredLanguage(
      LanguageEntity params);

  Future<Either<Failure, String>> getEpicUserID();

  Future<Either<Failure, bool>> setEpicUserID(String epicUserID);

  Future<Either<Failure, BaseResponse<GetScheduleTimeResponse>>>
      getScheduleTimeSlot(GetScheduleTimeRequest params);

  Future<Either<Failure, BaseResponse>> submitScheduleData(
      SubmitScheduleDataRequest params);

  Future<Either<Failure, BaseResponse<BiometricEnableResponse>>>
      enableBiometric(BiometricEnableRequest params);

  Future<Either<Failure, BaseResponse<OTPResponse>>> otpRequest(
      CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<ContactUsResponseModel>>> getContactUs(
      ContactUsRequestEntity params);

  Future<Either<Failure, BaseResponse<ForgotPwResetSecQuestionsResponseModel>>>
      getForgotPwResetSecQuestions(
          ForgotPwResetSecQuestionsRequestEntity params);

  Future<Either<Failure, bool>> savePreferredLanguage();

  Future<Either<Failure, BaseResponse<ForgotPasswordUserNameResponseModel>>>
      getForgotPwUsername(ForgotPasswordUserNameRequestEntity params);

  Future<Either<Failure, BaseResponse<MobileLoginResponse>>> biometricLogin(
      BiometricLoginRequest params);

  Future<Either<Failure, BaseResponse<GetSavedBillersResponse>>>
      getSavedBillerList(CommonRequestEntity params);

  Future<Either<Failure, BaseResponse<AddBillerResponse>>> addBiller(
      AddBillerRequest addBillerRequest);

  Future<Either<Failure, BaseResponse>> favouriteBiller(
      FavouriteBillerEntity favouriteBillerRequest);

  Future<Either<Failure, BaseResponse<GetBillerCategoryListResponse>>>
      getBillerCategoryList(CommonRequestEntity commonRequestEntity);

  Future<Either<Failure, BaseResponse>> deleteBiller(
      DeleteBillerEntity deleteBillerEntity);

  Future<Either<Failure, BaseResponse>> editBiller(
      EditUserBillerRequest editUserBillerRequest);

  Future<Either<Failure, BaseResponse>> forgotPwCreateNewPassword(
      ForgotPwCreateNewPasswordRequestModel
          forgotPwCreateNewPasswordRequestModel);

  Future<Either<Failure, BaseResponse>> unFavoriteBiller(
      UnFavoriteBillerEntity unFavoriteBillerEntity);

  Future<Either<Failure, BaseResponse<CheckAccountNoNicResponse>>>
      checkAccountNumberNIC(CheckAccountNoNicRequest checkAccountNoNicRequest);
}
