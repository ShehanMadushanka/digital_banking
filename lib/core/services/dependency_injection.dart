import 'package:cdb_mobile/features/domain/usecases/biller_management/add_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/delete_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/edit_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/favourite_biller.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/get_biller_categories.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/saved_billers.dart';
import 'package:cdb_mobile/features/domain/usecases/biller_management/unFavoriteBiller.dart';
import 'package:cdb_mobile/features/domain/usecases/biometric/biometric_login.dart';
import 'package:cdb_mobile/features/domain/usecases/biometric/enable_biometric.dart';
import 'package:cdb_mobile/features/domain/usecases/change_password/change_password.dart';
import 'package:cdb_mobile/features/domain/usecases/contact_us/contact_us.dart';
import 'package:cdb_mobile/features/domain/usecases/document_verification/document_verification.dart';
import 'package:cdb_mobile/features/domain/usecases/drop_down/schedule/schedule_get_time.dart';
import 'package:cdb_mobile/features/domain/usecases/epicuser_id/save_epicuser_id.dart';
import 'package:cdb_mobile/features/domain/usecases/forgot_password/forgot_pw_create_new_password.dart';
import 'package:cdb_mobile/features/domain/usecases/forgot_password/forgot_pw_reset_security_question.dart';
import 'package:cdb_mobile/features/domain/usecases/forgot_password/forgot_pw_using_acc_no.dart';
import 'package:cdb_mobile/features/domain/usecases/forgot_password_user_name/forgot_password_user_name.dart';
import 'package:cdb_mobile/features/domain/usecases/language/save_language.dart';
import 'package:cdb_mobile/features/domain/usecases/language/set_language.dart';
import 'package:cdb_mobile/features/domain/usecases/login/mobile_login.dart';
import 'package:cdb_mobile/features/domain/usecases/otp/request_otp.dart';
import 'package:cdb_mobile/features/domain/usecases/schedule/submit_schedule_data.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_password_user_name_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_pw_create_new_password_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/forgot_password/forgot_pw_reset_security_questions_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/language/language_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/biometric/biometric_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/otp/otp_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/payee_management/payee_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/pre_login/contact_us/contact_us_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/user_login/login_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/data/datasources/local_data_source.dart';
import '../../features/data/datasources/remote_data_source.dart';
import '../../features/data/repositories/repository_impl.dart';
import '../../features/domain/repositories/repository.dart';
import '../../features/domain/usecases/create_user/create_user.dart';
import '../../features/domain/usecases/customer_registration/customer_registration.dart';
import '../../features/domain/usecases/document_verification/document_verification.dart';
import '../../features/domain/usecases/drop_down/city/get_city_data.dart';
import '../../features/domain/usecases/drop_down/designation/get_designation_data.dart';
import '../../features/domain/usecases/drop_down/schedule/schedule_get_dates.dart';
import '../../features/domain/usecases/emp_details/emp_details.dart';
import '../../features/domain/usecases/other_products/get_other_products.dart';
import '../../features/domain/usecases/other_products/submit_other_products.dart';
import '../../features/domain/usecases/otp/verify_otp.dart';
import '../../features/domain/usecases/security_questions/get_security_questions.dart';
import '../../features/domain/usecases/security_questions/set_security_questions.dart';
import '../../features/domain/usecases/splash/get_splash_data.dart';
import '../../features/domain/usecases/terms/accept_terms_data.dart';
import '../../features/domain/usecases/terms/get_terms_data.dart';
import '../../features/domain/usecases/verify_nic/verify_nic.dart';
import '../../features/domain/usecases/wallet_onboarding_data/get_wallet_on_boarding_data.dart';
import '../../features/domain/usecases/wallet_onboarding_data/store_wallet_on_boarding_data.dart';
import '../../features/presentation/bloc/drop_down/drop_down_bloc.dart';
import '../../features/presentation/bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../features/presentation/bloc/on_boarding/create_user/create_user_bloc.dart';
import '../../features/presentation/bloc/on_boarding/document_verification/document_verification_bloc.dart';
import '../../features/presentation/bloc/on_boarding/employment_details/employment_details_bloc.dart';
import '../../features/presentation/bloc/on_boarding/other_products/other_products_bloc.dart';
import '../../features/presentation/bloc/on_boarding/personal_information/personal_information_bloc.dart';
import '../../features/presentation/bloc/on_boarding/reg_progress/reg_progress_bloc.dart';
import '../../features/presentation/bloc/on_boarding/review/review_bloc.dart';
import '../../features/presentation/bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import '../../features/presentation/bloc/on_boarding/security_questions/security_questions_bloc.dart';
import '../../features/presentation/bloc/on_boarding/tnc/tnc_bloc.dart';
import '../../features/presentation/bloc/on_boarding/user_other_info/user_other_info_bloc.dart';
import '../../features/presentation/bloc/otp/otp_bloc.dart';
import '../../features/presentation/bloc/splash/splash_bloc.dart';
import '../../utils/app_sync_data.dart';
import '../../utils/app_validator.dart';
import '../../utils/device_data.dart';
import '../network/api_helper.dart';
import '../network/network_info.dart';
import 'cloud_notification_services.dart';
import 'push_notification_manager.dart';

final inject = GetIt.instance;

Future<void> setupLocator() async {
  final _sharedPreferences = await SharedPreferences.getInstance();
  final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
  const _secureStorage = FlutterSecureStorage();

  inject.registerSingleton(DeviceInfoPlugin());

  inject.registerLazySingleton(() => _sharedPreferences);
  inject.registerLazySingleton(() => _secureStorage);
  inject.registerLazySingleton(() => _packageInfo);
  inject.registerSingleton(LocalDataSource(
      securePreferences: inject(), sharedPreferences: inject()));
  inject.registerSingleton(DeviceData(
      deviceInfo: inject(), packageInfo: inject(), sharedData: inject()));
  inject.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(apiHelper: inject()),
  );

  inject.registerLazySingleton(() => AppSyncData(localDataSource: inject()));

  /// Firebase
  inject.registerSingleton(FirebaseAnalytics());
  inject.registerSingleton(FirebaseAnalyticsObserver(analytics: inject()));

  inject.registerSingleton(PushNotificationsManager(inject()));
  inject.registerSingleton(CloudMessagingServices(inject()));
  inject.registerSingleton(Dio());
  inject.registerLazySingleton<APIHelper>(() => APIHelper(inject(),
      dio: inject(), deviceData: inject(), appSyncData: inject()));
  inject.registerLazySingleton(() => Connectivity());
  inject.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(inject()));

  /// Repository
  inject.registerLazySingleton<Repository>(
    () => RepositoryImpl(
        remoteDataSource: inject(),
        localDataSource: inject(),
        networkInfo: inject()),
  );

  /// UseCases
  inject.registerLazySingleton(() => GetSplashData(repository: inject()));
  inject.registerLazySingleton(() => VerifyNIC(repository: inject()));
  inject.registerLazySingleton(
      () => GetWalletOnBoardingData(repository: inject()));
  inject.registerLazySingleton(
      () => StoreWalletOnBoardingData(repository: inject()));
  inject.registerLazySingleton(() => GetCityData(repository: inject()));
  inject.registerLazySingleton(() => GetDesignationData(repository: inject()));
  inject.registerLazySingleton(() => GetScheduleDates(repository: inject()));
  inject.registerLazySingleton(() => GetOtherProducts(repository: inject()));
  inject.registerLazySingleton(() => SubmitOtherProducts(repository: inject()));
  inject
      .registerLazySingleton(() => CustomerRegistration(repository: inject()));
  inject.registerLazySingleton(() => CreateUser(repository: inject()));
  inject.registerLazySingleton(() => AcceptTermsData(repository: inject()));
  inject.registerLazySingleton(() => GetTermsData(repository: inject()));

  inject.registerLazySingleton(() => EmpDetails(repository: inject()));

  inject
      .registerLazySingleton(() => GetSecurityQuestions(repository: inject()));
  inject
      .registerLazySingleton(() => SetSecurityQuestions(repository: inject()));
  inject.registerLazySingleton(() => VerifyOTP(repository: inject()));
  inject
      .registerLazySingleton(() => SetPreferredLanguage(repository: inject()));
  inject
      .registerLazySingleton(() => DocumentVerification(repository: inject()));
  inject.registerLazySingleton(() => GetScheduleTime(repository: inject()));
  inject.registerLazySingleton(() => SubmitScheduleData(repository: inject()));
  inject.registerLazySingleton(() => SetEpicUserID(repository: inject()));
  inject.registerLazySingleton(() => MobileLogin(repository: inject()));
  inject.registerLazySingleton(() => EnableBiometric(repository: inject()));
  inject.registerLazySingleton(() => RequestOTP(repository: inject()));
  inject.registerLazySingleton(() => ContactUs(repository: inject()));
  inject.registerLazySingleton(() => BiometricLogin(repository: inject()));
  inject.registerLazySingleton(
      () => GetForgotPwResetSecQuestions(repository: inject()));
  inject
      .registerLazySingleton(() => SavePreferredLanguage(repository: inject()));

  inject.registerLazySingleton(
      () => GetForgotPasswordUserName(repository: inject()));
  inject.registerLazySingleton(() => GetSavedBillers(repository: inject()));
  inject.registerLazySingleton(() => AddBiller(repository: inject()));
  inject.registerLazySingleton(() => FavouriteBiller(repository: inject()));
  inject
      .registerLazySingleton(() => GetBillerCategoryList(repository: inject()));

  inject.registerLazySingleton(() => EditUserBiller(repository: inject()));
  inject.registerLazySingleton(
      () => ForgotPwCreateNewPassword(repository: inject()));
  inject.registerLazySingleton(() => DeleteBiller(repository: inject()));
  inject.registerLazySingleton(() => UnFavoriteBiller(repository: inject()));
  inject.registerLazySingleton(() => ChangePassword(repository: inject()));
  inject.registerLazySingleton(
      () => ForgotPwUsingAccountNumber(repository: inject()));

  /// Utils
  inject.registerLazySingleton(() => AppValidator());

  /// Blocs
  inject.registerFactory(() => SplashBloc(
      appSharedData: inject(),
      useCaseSplashData: inject(),
      getWalletOnBoardingData: inject(),
      cloudMessagingServices: inject()));
  inject.registerFactory(() => DropDownBloc(
      useCaseCityData: inject(),
      useCaseDesignationData: inject(),
      getScheduleDates: inject(),
      getScheduleTime: inject(),
      useCaseGetQuestions: inject()));
  inject.registerFactory(() => PersonalInformationBloc(
        appSharedData: inject(),
        getWalletOnBoardingData: inject(),
        storeWalletOnBoardingData: inject(),
        verifyNIC: inject(),
        customerRegistration: inject(),
        appValidator: inject(),
      ));
  inject.registerFactory(() => ContactInformationBloc(
      appSharedData: inject(),
      getWalletOnBoardingData: inject(),
      storeWalletOnBoardingData: inject(),
      customerRegistration: inject(),
      appValidator: inject()));
  inject.registerFactory(() => DocumentVerificationBloc(
      appSharedData: inject(),
      getWalletOnBoardingData: inject(),
      storeWalletOnBoardingData: inject(),
      useCaseDocumentVerification: inject()));
  inject.registerFactory(() => EmploymentDetailsBloc(
        appSharedData: inject(),
        getWalletOnBoardingData: inject(),
        storeWalletOnBoardingData: inject(),
        empDetails: inject(),
      ));
  inject.registerFactory(() => UserOtherInformationBloc(
        appSharedData: inject(),
        getWalletOnBoardingData: inject(),
        storeWalletOnBoardingData: inject(),
        empDetails: inject(),
      ));
  inject.registerFactory(
      () => RegProgressBloc(getWalletOnBoardingData: inject()));
  inject.registerFactory(() => SecurityQuestionsBloc(
      useCaseSetQuestions: inject(),
      storeWalletOnBoardingData: inject(),
      getWalletOnBoardingData: inject()));

  inject.registerFactory(() => ReviewBloc(
      getWalletOnBoardingData: inject(), storeWalletOnBoardingData: inject()));
  inject.registerFactory(() => ScheduleVerificationBloc(
      getWalletOnBoardingData: inject(),
      appSharedData: inject(),
      submitScheduleData: inject(),
      storeWalletOnBoardingData: inject()));
  inject.registerFactory(() => TnCBloc(
      getWalletOnBoardingData: inject(),
      storeWalletOnBoardingData: inject(),
      useCaseAcceptTerms: inject(),
      useCaseGetTerms: inject()));
  inject.registerFactory(() => OtherProductsBloc(
      getOtherProducts: inject(),
      submitOtherProducts: inject(),
      getWalletOnBoardingData: inject(),
      storeWalletOnBoardingData: inject()));
  inject.registerFactory(() => CreateUserBloc(
      appSharedData: inject(),
      createUser: inject(),
      setEpicUserID: inject(),
      storeWalletOnBoardingData: inject(),
      getWalletOnBoardingData: inject()));
  inject.registerFactory(
      () => OTPBloc(verifyOTP: inject(), requestOTP: inject()));
  inject.registerFactory(() => LoginBloc(
      mobileLogin: inject(),
      biometricLogin: inject(),
      localDataSource: inject(),
      setEpicUserID: inject(),
      getWalletOnBoardingData: inject()));
  inject.registerFactory(() => LanguageBloc(
      setPreferredLanguage: inject(), savePreferredLanguage: inject()));
  inject.registerFactory(() => BiometricBloc(
      appSharedData: inject(),
      enableBiometric: inject(),
      storeWalletOnBoardingData: inject(),
      getWalletOnBoardingData: inject()));
  inject.registerFactory(() => ContactUsBloc(contactUs: inject()));
  inject.registerFactory(() => BillerManagementBloc(
      getSavedBillers: inject(),
      addBiller: inject(),
      favouriteBiller: inject(),
      getBillerCategoryList: inject(),
      editUserBiller: inject(),
      deleteBiller: inject(),
      unFavoriteBiller: inject()));
  inject.registerFactory(() => ForgotPwResetSecQuestionsBloc(
      useCaseForgotPwResetSecQuestions: inject(), localDataSource: inject()));
  inject.registerFactory(() => ForgotPasswordUserNameBloc(
      useCaseForgotPasswordUserName: inject(),
      localDataSource: inject(),
      forgotPwUsingAccountNumber: inject()));
  inject.registerFactory(() => ForgotPwCreateNewPasswordBloc(
        localDataSource: inject(),
        forgotPwCreateNewPassword: inject(),
        setEpicUserID: inject(),
      ));
  inject.registerFactory(() => ChangePasswordBloc(
        changePassword: inject(),
      ));
  inject.registerFactory(
    () => PayeeManagementBloc(),
  );
}
