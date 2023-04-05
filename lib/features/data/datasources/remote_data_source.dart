import 'dart:core';

import 'package:cdb_mobile/features/data/models/requests/add_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/biometric_login_request.dart';
import 'package:cdb_mobile/features/data/models/requests/change_password_request.dart';
import 'package:cdb_mobile/features/data/models/requests/check_acc_no_nic_request.dart';
import 'package:cdb_mobile/features/data/models/requests/delete_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/favourite_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/edit_user_biller_request.dart';
import 'package:cdb_mobile/features/data/models/requests/forgot_password_username_request.dart';
import 'package:cdb_mobile/features/data/models/requests/forgot_pw_create_new_password_request.dart';
import 'package:cdb_mobile/features/data/models/requests/un_favorite_biller_request.dart';
import 'package:cdb_mobile/features/data/models/responses/check_acc_no_nic_response.dart';
import 'package:cdb_mobile/features/data/models/responses/edit_user_biller_response.dart';
import 'package:cdb_mobile/features/data/models/responses/add_biller_response.dart';
import 'package:cdb_mobile/features/data/models/responses/forgot_password_user_name_response.dart';
import 'package:cdb_mobile/features/data/models/responses/forgot_pw_reset_security_questions_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_biller_category_list_response.dart';
import 'package:cdb_mobile/features/data/models/responses/get_biller_list_response.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/network/api_helper.dart';
import '../../domain/entities/request/terms_accept_request_entity.dart';
import '../models/common/base_response.dart';
import '../models/requests/biometric_enable_request.dart';
import '../models/requests/challenge_request.dart';
import '../models/requests/common_request.dart';
import '../models/requests/contact_us_request.dart';
import '../models/requests/create_user_request.dart';
import '../models/requests/customer_reg_request.dart';
import '../models/requests/document_verification_api_request.dart';
import '../models/requests/emp_detail_request.dart';
import '../models/requests/forgot_pw_reset_security_questions_request.dart';
import '../models/requests/get_schedule_time_request.dart';
import '../models/requests/get_terms_request.dart';
import '../models/requests/language_request.dart';
import '../models/requests/mobile_login_request.dart';
import '../models/requests/set_security_questions_request.dart';
import '../models/requests/submit_products_request.dart';
import '../models/requests/submit_schedule_data_request.dart';
import '../models/requests/verify_nic_request.dart';
import '../models/responses/biometric_enable_response.dart';
import '../models/responses/city_response.dart';
import '../models/responses/contact_us_response.dart';
import '../models/responses/create_user_response.dart';
import '../models/responses/get_other_products_response.dart';
import '../models/responses/get_schedule_time_response.dart';
import '../models/responses/get_terms_response.dart';
import '../models/responses/mobile_login_response.dart';
import '../models/responses/otp_response.dart';
import '../models/responses/schedule_date_response.dart';
import '../models/responses/sec_question_response.dart';
import '../models/responses/splash_response.dart';
import '../models/responses/submit_other_products_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse> getSplash(CommonRequest splashRequest);

  Future<BaseResponse> getTerms(GetTermsRequest getTermsRequest);

  Future<BaseResponse> acceptTerms(
      TermsAcceptRequestEntity termsAcceptRequestEntity);

  Future<BaseResponse<CreateUserResponse>> createUser(
      CreateUserRequest createUserRequest);

  Future<BaseResponse> verifyNIC(VerifyNicRequest verifyNicRequest);

  Future<BaseResponse<ScheduleDateResponse>> getScheduleDates(
      CommonRequest scheduleDateRequest);

  Future<BaseResponse<GetOtherProductsResponse>> getOtherProducts(
      CommonRequest otherProductsRequest);

  Future<BaseResponse<SubmitProductsResponse>> submitOtherProducts(
      SubmitProductsRequest submitProductsRequest);

  Future<BaseResponse<CityDetailResponse>> getCityData(
      CommonRequest commonRequest);

  Future<BaseResponse<CityDetailResponse>> getDesignationData(
      CommonRequest commonRequest);

  Future<BaseResponse> registerCustomer(
      CustomerRegistrationRequest customerRegistrationRequest);

  Future<BaseResponse<SecurityQuestionResponse>> getSecurityQuestions(
      CommonRequest commonRequest);

  Future<BaseResponse> submitEmpDetails(EmpDetailRequest empDetailRequest);

  Future<BaseResponse> setSecurityQuestions(
      SetSecurityQuestionsRequest commonRequest);

  Future<BaseResponse> otpVerification(ChallengeRequest challengeRequest);

  Future<BaseResponse> documentVerification(
      DocumentVerificationApiRequest documentVerificationApiRequest);

  Future<BaseResponse<GetScheduleTimeResponse>> getScheduleTimeSlots(
      GetScheduleTimeRequest scheduleTimeRequest);

  Future<BaseResponse> submitScheduleData(SubmitScheduleDataRequest request);

  Future<BaseResponse> setPreferredLanguage(LanguageRequest params);

  Future<BaseResponse<MobileLoginResponse>> mobileLogin(
      MobileLoginRequest mobileLoginRequest);

  Future<BaseResponse> changePassword(
      ChangePasswordRequest changePasswordRequest);

  Future<BaseResponse<BiometricEnableResponse>> biometricEnable(
      BiometricEnableRequest biometricEnableRequest);

  Future<BaseResponse<ForgotPwResetSecQuestionsResponseModel>>
      getForgotPwResetSecQuestions(
          ForgotPwResetSecQuestionsRequestModel
              forgotPwResetSecQuestionsRequestModel);

  Future<BaseResponse<OTPResponse>> otpRequest(
      CommonRequest biometricEnableRequest);

  Future<BaseResponse<ContactUsResponseModel>> getContactUs(
      ContactUsRequestModel contactUsRequestModel);

  Future<BaseResponse<ForgotPasswordUserNameResponseModel>> getForgotPwUsername(
      ForgotPasswordUserNameRequestModel usernameIdentityRequestModel);

  Future<BaseResponse<MobileLoginResponse>> biometricLogin(
      BiometricLoginRequest biometricLoginRequest);

  Future<BaseResponse<GetSavedBillersResponse>> getSavedBillers(
      CommonRequest commonRequest);

  Future<BaseResponse<AddBillerResponse>> addBiller(
      AddBillerRequest addBillerRequest);

  Future<BaseResponse> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest);

  Future<BaseResponse<GetBillerCategoryListResponse>> getBillerCategoryList(
      CommonRequest commonRequest);

  Future<BaseResponse> deleteBiller(FavouriteBillerRequest deleteBillerRequest);

  Future<BaseResponse> editBiller(EditUserBillerRequest editUserBillerRequest);

  Future<BaseResponse> forgotPwCreateNewPassword(
      ForgotPwCreateNewPasswordRequestModel
          forgotPwCreateNewPasswordRequestModel);

  Future<BaseResponse> unFavoriteBiller(
      UnFavoriteBillerRequest unFavoriteBillerRequest);

  Future<BaseResponse<CheckAccountNoNicResponse>> checkAccountNumberNIC(
      CheckAccountNoNicRequest checkAccountNoNicRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final APIHelper apiHelper;

  RemoteDataSourceImpl({@required this.apiHelper});

  /// Splash Request
  @override
  Future<BaseResponse> getSplash(CommonRequest splashRequest) async {
    try {
      final response = await apiHelper.post(
        "splash/",
        body: splashRequest.toJson(),
      );
      return BaseResponse<SplashResponse>.fromJson(
          response, (data) => SplashResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  /// Verify NIC Request
  @override
  Future<BaseResponse<Serializable>> verifyNIC(
      VerifyNicRequest verifyNicRequest) async {
    try {
      final response = await apiHelper.post(
        "customerNicVerify/",
        body: verifyNicRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Get Terms and Conditions
  @override
  Future<BaseResponse> getTerms(GetTermsRequest getTermsRequest) async {
    try {
      final response = await apiHelper.post(
        "tnc/",
        body: getTermsRequest.toJson(),
      );
      return BaseResponse<GetTermsResponse>.fromJson(
          response, (data) => GetTermsResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  /// Accept Terms and Conditions
  @override
  Future<BaseResponse> acceptTerms(
      TermsAcceptRequestEntity termsAcceptRequestEntity) async {
    try {
      final response = await apiHelper.post(
        "tnc-acceptance/",
        body: termsAcceptRequestEntity.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Get City
  @override
  Future<BaseResponse<CityDetailResponse>> getCityData(
      CommonRequest commonRequest) async {
    try {
      final response =
          await apiHelper.post("cityDetail/", body: commonRequest.toJson());
      return BaseResponse<CityDetailResponse>.fromJson(
          response, (data) => CityDetailResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CreateUserResponse>> createUser(
      CreateUserRequest createUserRequest) async {
    try {
      final response = await apiHelper.post(
        "userCreation/",
        body: createUserRequest.toJson(),
      );
      return BaseResponse<CreateUserResponse>.fromJson(
          response, (data) => CreateUserResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  ///Get Schedule Dates
  @override
  Future<BaseResponse<ScheduleDateResponse>> getScheduleDates(
      CommonRequest scheduleDateRequest) async {
    try {
      final response = await apiHelper.post(
        "customerConfSchDate/",
        body: scheduleDateRequest.toJson(),
      );
      return BaseResponse<ScheduleDateResponse>.fromJson(
          response, (data) => ScheduleDateResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetOtherProductsResponse>> getOtherProducts(
      CommonRequest otherProductsRequest) async {
    try {
      final response = await apiHelper.post(
        "insProductList/",
        body: otherProductsRequest.toJson(),
      );
      return BaseResponse<GetOtherProductsResponse>.fromJson(
          response, (data) => GetOtherProductsResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SubmitProductsResponse>> submitOtherProducts(
      SubmitProductsRequest submitProductsRequest) async {
    try {
      final response = await apiHelper.post(
        "saveInsProduct/",
        body: submitProductsRequest.toJson(),
      );
      return BaseResponse<SubmitProductsResponse>.fromJson(
          response, (data) => SubmitProductsResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  /// Get Designation
  @override
  Future<BaseResponse<CityDetailResponse>> getDesignationData(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper.post(
        "designationDetail/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<CityDetailResponse>.fromJson(
          response, (data) => CityDetailResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  /// Customer Registration API
  @override
  Future<BaseResponse<Serializable>> registerCustomer(
      CustomerRegistrationRequest customerRegistrationRequest) async {
    try {
      final response = await apiHelper.post(
        "customerReg/",
        body: customerRegistrationRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> submitEmpDetails(
      EmpDetailRequest empDetailRequest) async {
    try {
      final response = await apiHelper.post(
        "employeeDetail/",
        body: empDetailRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SecurityQuestionResponse>> getSecurityQuestions(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper.post(
        "securityQuestionList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<SecurityQuestionResponse>.fromJson(
          response, (data) => SecurityQuestionResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> setSecurityQuestions(
      SetSecurityQuestionsRequest securityQuestionsRequest) async {
    try {
      final response = await apiHelper.post(
        "answerSecurityQuestion/",
        body: securityQuestionsRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> otpVerification(
      ChallengeRequest challengeRequest) async {
    try {
      final response = await apiHelper.post(
        "challengeReq/",
        body: challengeRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> documentVerification(
      DocumentVerificationApiRequest documentVerificationApiRequest) async {
    try {
      final response = await apiHelper.post(
        "imgUpload/",
        body: documentVerificationApiRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> setPreferredLanguage(
      LanguageRequest params) async {
    try {
      final response = await apiHelper.post(
        "language/",
        body: params.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<MobileLoginResponse>> mobileLogin(
      MobileLoginRequest mobileLoginRequest) async {
    try {
      final response = await apiHelper.post(
        "mobile/login",
        body: mobileLoginRequest.toJson(),
      );
      return BaseResponse<MobileLoginResponse>.fromJson(
          response, (data) => MobileLoginResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    try {
      final response = await apiHelper.post(
        "changePassword/",
        body: changePasswordRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetScheduleTimeResponse>> getScheduleTimeSlots(
      GetScheduleTimeRequest scheduleTimeRequest) async {
    try {
      final response = await apiHelper.post(
        "customerConfSchTime/",
        body: scheduleTimeRequest.toJson(),
      );
      return BaseResponse<GetScheduleTimeResponse>.fromJson(
          response, (data) => GetScheduleTimeResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> submitScheduleData(
      SubmitScheduleDataRequest request) async {
    try {
      final response = await apiHelper.post(
        "customerConfSchDetail/",
        body: request.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<BiometricEnableResponse>> biometricEnable(
      BiometricEnableRequest biometricEnableRequest) async {
    try {
      final response = await apiHelper.post(
        "enableBiometric",
        body: biometricEnableRequest.toJson(),
      );
      return BaseResponse<BiometricEnableResponse>.fromJson(
          response, (data) => BiometricEnableResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<OTPResponse>> otpRequest(CommonRequest request) async {
    try {
      final response = await apiHelper.post(
        "otpSend/",
        body: request.toJson(),
      );
      return BaseResponse<OTPResponse>.fromJson(
          response, (data) => OTPResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  ///Contact Us
  @override
  Future<BaseResponse<ContactUsResponseModel>> getContactUs(
      ContactUsRequestModel contactUsRequestModel) async {
    try {
      final response = await apiHelper.post(
        "contactUs/",
        body: contactUsRequestModel.toJson(),
      );
      return BaseResponse<ContactUsResponseModel>.fromJson(
          response, (data) => ContactUsResponseModel.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  ///Forgot Password Reset Method using Security Questions
  @override
  Future<BaseResponse<ForgotPwResetSecQuestionsResponseModel>>
      getForgotPwResetSecQuestions(
          ForgotPwResetSecQuestionsRequestModel
              forgotPwResetSecQuestionsRequestModel) async {
    try {
      final response = await apiHelper.post(
        "checkSQAnswer/",
        body: forgotPwResetSecQuestionsRequestModel.toJson(),
      );
      return BaseResponse<ForgotPwResetSecQuestionsResponseModel>.fromJson(
          response,
          (data) => ForgotPwResetSecQuestionsResponseModel.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  ///Forgot Password User Name
  @override
  Future<BaseResponse<ForgotPasswordUserNameResponseModel>> getForgotPwUsername(
      ForgotPasswordUserNameRequestModel
          forgotPasswordUserNameRequestModel) async {
    try {
      final response = await apiHelper.post(
        "checkUsernameIdentity",
        body: forgotPasswordUserNameRequestModel.toJson(),
      );

      return BaseResponse<ForgotPasswordUserNameResponseModel>.fromJson(
          response,
          (data) => ForgotPasswordUserNameResponseModel.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<MobileLoginResponse>> biometricLogin(
      BiometricLoginRequest biometricLoginRequest) async {
    try {
      final response = await apiHelper.post(
        "biometric/login",
        body: biometricLoginRequest.toJson(),
      );
      return BaseResponse<MobileLoginResponse>.fromJson(
          response, (data) => MobileLoginResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  /// Edit Biller
  @override
  Future<BaseResponse<EditUserBillerResponse>> editBiller(
      EditUserBillerRequest editUserBillerRequest) async {
    try {
      final response = await apiHelper.post(
        "userBiller/",
        httpMethod: HttpMethods.PUT,
        body: editUserBillerRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetSavedBillersResponse>> getSavedBillers(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper.post(
        "userBillerList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<GetSavedBillersResponse>.fromJson(
          response, (data) => GetSavedBillersResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AddBillerResponse>> addBiller(
      AddBillerRequest addBillerRequest) async {
    try {
      final response = await apiHelper.post(
        "userBiller/",
        body: addBillerRequest.toJson(),
      );
      return BaseResponse<AddBillerResponse>.fromJson(
          response, (data) => AddBillerResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<Serializable>> favouriteBiller(
      FavouriteBillerRequest favouriteBillerRequest) async {
    try {
      final response = await apiHelper.post(
        "billerFavorites/",
        body: favouriteBillerRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<GetBillerCategoryListResponse>> getBillerCategoryList(
      CommonRequest commonRequest) async {
    try {
      final response = await apiHelper.post(
        "bspCategoryList/",
        body: commonRequest.toJson(),
      );
      return BaseResponse<GetBillerCategoryListResponse>.fromJson(
          response, (data) => GetBillerCategoryListResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }

  ///Delete Biller
  @override
  Future<BaseResponse<Serializable>> deleteBiller(
      FavouriteBillerRequest deleteBillerRequest) async {
    try {
      final response = await apiHelper.delete(
        "userBiller/",
        body: deleteBillerRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  /// Forgot Password - Create New Password
  @override
  Future<BaseResponse> forgotPwCreateNewPassword(
      ForgotPwCreateNewPasswordRequestModel
          forgotPwCreateNewPasswordRequestModel) async {
    try {
      final response = await apiHelper.post(
        "/forgotPasswordReset",
        body: forgotPwCreateNewPasswordRequestModel.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  ///UnFavorite Biller
  @override
  Future<BaseResponse<Serializable>> unFavoriteBiller(
      UnFavoriteBillerRequest unFavoriteBillerRequest) async {
    try {
      final response = await apiHelper.put(
        "billerFavorites/",
        body: unFavoriteBillerRequest.toJson(),
      );
      return BaseResponse.fromJson(response, (_) {});
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<CheckAccountNoNicResponse>> checkAccountNumberNIC(
      CheckAccountNoNicRequest checkAccountNoNicRequest) async {
    try {
      final response = await apiHelper.post(
        "checkNicIdentity/",
        body: checkAccountNoNicRequest.toJson(),
      );
      return BaseResponse<CheckAccountNoNicResponse>.fromJson(
          response, (data) => CheckAccountNoNicResponse.fromJson(data));
    } on Exception {
      rethrow;
    }
  }
}
