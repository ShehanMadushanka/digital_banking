import 'package:cdb_mobile/features/presentation/views/biller_management/add_biller/add_biller_confirm_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/add_biller/add_biller_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/bill_payees_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/bill_payment_summary_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/bill_payment_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/billpayment_main_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/favourites_billers_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payment/pay_bills_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/bill_payments_not_filled_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/edit_biller_confirm_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/edit_biller_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/more_detail_biller_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/saved_biller_list_view.dart';
import 'package:cdb_mobile/features/presentation/views/billpayment/bill_payment_status_view.dart';
import 'package:cdb_mobile/features/presentation/views/billpayment/save_biller_view.dart';
import 'package:cdb_mobile/features/presentation/views/forgot_password/forgot_password_account.dart';
import 'package:cdb_mobile/features/presentation/views/forgot_password/forgot_password_create_new_password.dart';
import 'package:cdb_mobile/features/presentation/views/forgot_password/forgot_password_reset_method_view.dart';
import 'package:cdb_mobile/features/presentation/views/fund_transfer/fund_transfer_recipt_view.dart';
import 'package:cdb_mobile/features/presentation/views/fund_transfer/transaction_history_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/gold_loan_list_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/gold_loan_payment_summary_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/gold_loan_payment_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/gold_loan_top_up_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/loan_details_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/loan_payment_receipt_view.dart';
import 'package:cdb_mobile/features/presentation/views/gold_loan/select_account_view.dart';
import 'package:cdb_mobile/features/presentation/views/home/home_main_view.dart';
import 'package:cdb_mobile/features/presentation/views/home/home_quick_access_menu_view.dart';
import 'package:cdb_mobile/features/presentation/views/home/portfolio/home_portfolio_view.dart';
import 'package:cdb_mobile/features/presentation/views/lanka_qr_scenarios/qr_payment_status_other_bank_view.dart';
import 'package:cdb_mobile/features/presentation/views/notifications/offer_and_promotion_view.dart';
import 'package:cdb_mobile/features/presentation/views/notifications/transaction_offer_notifications_view.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/add_payee_view.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/edit_payee_view.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/payee_confirm_view.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/payee_details_view.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/payee_management_list_view.dart';
import 'package:cdb_mobile/features/presentation/views/payee_management/saved_payee_list_view.dart';
import 'package:cdb_mobile/features/presentation/views/payment_instrument_management/account_list_view.dart';
import 'package:cdb_mobile/features/presentation/views/payment_instrument_management/add_payment_instrument/add_instrument_view.dart';
import 'package:cdb_mobile/features/presentation/views/payment_instrument_management/edit_account_data/account_detail_view.dart';
import 'package:cdb_mobile/features/presentation/views/payment_instrument_management/edit_account_data/edit_account_nickname_view.dart';
import 'package:cdb_mobile/features/presentation/views/pre_login/pre_login_view.dart';
import 'package:cdb_mobile/features/presentation/views/promotion_&_offers/promotions_&_offers_view.dart';
import 'package:cdb_mobile/features/presentation/views/qr_payment/qr_payment_summary_view.dart';
import 'package:cdb_mobile/features/presentation/views/qr_payment/qr_payment_view.dart';
import 'package:cdb_mobile/features/presentation/views/qr_payment/qr_scanner_view.dart';
import 'package:cdb_mobile/features/presentation/views/settings/biometric/biometrics_scanning_view.dart';
import 'package:cdb_mobile/features/presentation/views/settings/biometric/enable_biometric_view.dart';
import 'package:cdb_mobile/features/presentation/views/settings/biometric/enable_biometrics_password_view.dart';
import 'package:cdb_mobile/features/presentation/views/settings/change_password/change_password_view.dart';
import 'package:cdb_mobile/features/presentation/views/settings/language/language_selection_view.dart';
import 'package:cdb_mobile/features/presentation/views/settings/profile/profile_view.dart';
import 'package:cdb_mobile/features/presentation/views/transaction_history/transaction_history.dart';
import 'package:cdb_mobile/features/presentation/views/transaction_history/transaction_history_filter_view.dart';
import 'package:cdb_mobile/features/presentation/views/transaction_history/transaction_status.dart';
import 'package:cdb_mobile/features/presentation/views/transaction_limit/transaction_limit.dart';
import 'package:cdb_mobile/features/presentation/views/view_schedules/all_schedules_view.dart';
import 'package:cdb_mobile/features/presentation/views/view_schedules/edit_schedule_view.dart';
import 'package:cdb_mobile/features/presentation/views/view_schedules/schedules_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/transitions/fade_route.dart';
import 'package:flutter/material.dart';

import '../features/presentation/views/biller_management/add_biller/add_biller_confirm_view.dart';
import '../features/presentation/views/biller_management/add_biller/add_biller_view.dart';
import '../features/presentation/views/biller_management/bill_payment/bill_payees_view.dart';
import '../features/presentation/views/biller_management/bill_payment/bill_payment_summary_view.dart';
import '../features/presentation/views/biller_management/bill_payment/bill_payment_view.dart';
import '../features/presentation/views/biller_management/bill_payment/billpayment_main_view.dart';
import '../features/presentation/views/biller_management/bill_payment/favourites_billers_view.dart';
import '../features/presentation/views/biller_management/bill_payment/pay_bills_view.dart';
import '../features/presentation/views/biller_management/bill_payments_not_filled_view.dart';
import '../features/presentation/views/biller_management/edit_biller_confirm_view.dart';
import '../features/presentation/views/biller_management/edit_biller_view.dart';
import '../features/presentation/views/biller_management/more_detail_biller_view.dart';
import '../features/presentation/views/biller_management/saved_biller_list_view.dart';
import '../features/presentation/views/billpayment/bill_payment_status_view.dart';
import '../features/presentation/views/billpayment/save_biller_view.dart';
import '../features/presentation/views/common/common_pin_auth_view.dart';
import '../features/presentation/views/forgot_password/forgot_password_account.dart';
import '../features/presentation/views/forgot_password/forgot_password_create_new_password.dart';
import '../features/presentation/views/forgot_password/forgot_password_user_name.dart';
import '../features/presentation/views/forgot_password/forgot_password_using_security_questions_view.dart';
import '../features/presentation/views/fund_transfer/fund_transfer_screen_input.dart';
import '../features/presentation/views/fund_transfer/fund_transfer_summery_view.dart';
import '../features/presentation/views/fund_transfer/save_payee_view.dart';
import '../features/presentation/views/fund_transfer/unsaved_pay_view.dart';
import '../features/presentation/views/gold_loan/gold_loan_list_view.dart';
import '../features/presentation/views/gold_loan/gold_loan_payment_summary_view.dart';
import '../features/presentation/views/gold_loan/gold_loan_top_up_view.dart';
import '../features/presentation/views/gold_loan/loan_details_view.dart';
import '../features/presentation/views/gold_loan/loan_payment_receipt_view.dart';
import '../features/presentation/views/gold_loan/select_account_view.dart';
import '../features/presentation/views/home/home_main_view.dart';
import '../features/presentation/views/home/home_quick_access_menu_view.dart';
import '../features/presentation/views/home/portfolio/home_portfolio_view.dart';
import '../features/presentation/views/intro/intro_slider_view.dart';
import '../features/presentation/views/language/language_view.dart';
import '../features/presentation/views/lanka_qr_scenarios/qr_payment_status_other_bank_view.dart';
import '../features/presentation/views/login/login_view.dart';
import '../features/presentation/views/notifications/offer_and_promotion_view.dart';
import '../features/presentation/views/notifications/transaction_offer_notifications_view.dart';
import '../features/presentation/views/on_boarding/add_username_password_view.dart';
import '../features/presentation/views/on_boarding/bio_metric_configaration_view.dart';
import '../features/presentation/views/on_boarding/bio_metric_information_view.dart';
import '../features/presentation/views/on_boarding/contact_information_view.dart';
import '../features/presentation/views/on_boarding/create_profile_by_select_acc_or_card.dart';
import '../features/presentation/views/on_boarding/create_profile_using_cdb_acc.dart';
import '../features/presentation/views/on_boarding/create_profile_view.dart';
import '../features/presentation/views/on_boarding/document_edit_view.dart';
import '../features/presentation/views/on_boarding/document_verification_view.dart';
import '../features/presentation/views/on_boarding/employment_detail_view.dart';
import '../features/presentation/views/on_boarding/new_registration_view.dart';
import '../features/presentation/views/on_boarding/other_products_view.dart';
import '../features/presentation/views/on_boarding/personal_information_view.dart';
import '../features/presentation/views/on_boarding/registration_progress_view.dart';
import '../features/presentation/views/on_boarding/review_view.dart';
import '../features/presentation/views/on_boarding/schedule_verification_view.dart';
import '../features/presentation/views/on_boarding/security_questions_view.dart';
import '../features/presentation/views/on_boarding/user_other_information_view.dart';
import '../features/presentation/views/otp/otp_view.dart';
import '../features/presentation/views/payee_management/add_payee_view.dart';
import '../features/presentation/views/payee_management/edit_payee_view.dart';
import '../features/presentation/views/payee_management/payee_confirm_view.dart';
import '../features/presentation/views/payee_management/payee_details_view.dart';
import '../features/presentation/views/payee_management/payee_management_list_view.dart';
import '../features/presentation/views/payee_management/saved_payee_list_view.dart';
import '../features/presentation/views/payment_instrument_management/account_list_view.dart';
import '../features/presentation/views/payment_instrument_management/add_payment_instrument/add_instrument_view.dart';
import '../features/presentation/views/payment_instrument_management/edit_account_data/account_detail_view.dart';
import '../features/presentation/views/payment_instrument_management/edit_account_data/edit_account_nickname_view.dart';
import '../features/presentation/views/pre_login/pre_login_contact_us_view.dart';
import '../features/presentation/views/pre_login/pre_login_faq_view.dart';
import '../features/presentation/views/pre_login/pre_login_view.dart';
import '../features/presentation/views/qr_payment/qr_payment_summary_view.dart';
import '../features/presentation/views/qr_payment/qr_payment_view.dart';
import '../features/presentation/views/qr_payment/qr_scanner_view.dart';
import '../features/presentation/views/settings/biometric/biometrics_scanning_view.dart';
import '../features/presentation/views/settings/biometric/enable_biometric_view.dart';
import '../features/presentation/views/settings/biometric/enable_biometrics_password_view.dart';
import '../features/presentation/views/settings/change_password/change_password_view.dart';
import '../features/presentation/views/settings/language/language_selection_view.dart';
import '../features/presentation/views/settings/profile/profile_view.dart';
import '../features/presentation/views/splash/splash_view.dart';
import '../features/presentation/views/tnc/tnc_view.dart';
import '../features/presentation/views/transaction_history/transaction_history.dart';
import '../features/presentation/views/transaction_history/transaction_history_filter_view.dart';
import '../features/presentation/views/transaction_history/transaction_status.dart';
import '../features/presentation/views/transaction_limit/transaction_limit.dart';
import '../features/presentation/widgets/cdb_drop_down/drop_down_view.dart';
import '../features/presentation/widgets/transitions/fade_route.dart';
import 'app_colors.dart';
import 'app_styling.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kPersonalInformationView = "kPersonalInformationView";
  static const String kDropDownView = "kDropDownView";
  static const String kContactInformation = "kContactInfo";
  static const String kEmploymentDetail = "kEmpDetail";
  static const String kBioMetricInformation = "kBioMetricInfo";
  static const String kBioMetricConfiguration = "kBioMetricConfiguration";
  static const String kRegProgress = "kRegProgress";
  static const String kNewRegView = "kNewRegView";
  static const String kSecurityQuestionsView = "kSecurityQuestionsView";
  static const String kCreateProfileView = "kCreateProfileView";
  static const String kCommonOTPView = "kCommonOTPView";
  static const String kReviewView = "kReviewView";
  static const String kUserOtherInfoView = "kUserOtherInfoView";
  static const String kOtherProducts = "kOtherProducts";
  static const String kAddUserNamePasswordView = "kAddUserNamePasswordView";
  static const String kDocumentVerificationView = "kDocumentVerificationView";
  static const String kDocumentEditView = "kDocumentEditView";
  static const String kScheduleVerificationView = "kScheduleVerificationView";
  static const String kTermsAndConditionsView = "kTermsAndConditionsView";
  static const String kContactUsView = "kContactUsView";
  static const String kLoginView = "kLoginView";
  static const String kFAQView = "kFAQView";
  static const String kLanguageView = "kLanguageView";
  static const String kCreateProfileBySelectAccOrCard =
      "kCreateProfileBySelectAccOrCard";
  static const String kCreateProfileUsingCdbAcc = "kCreateProfileUsingCdbAcc";
  static const String kIntroductionScreenView = "kIntroductionScreenView";
  static const String kBannerOne = "kBannerOne";
  static const String kBannerTwo = "kBannerTwo";
  static const String kBannerThree = "kBannerThree";
  static const String kIntroductionSlider = "kIntroductionSlider";
  static const String kAccountDetailView = "kAccountDetailView";
  static const String kForgotPwUserName = "kForgotPwUserName";
  static const String kForgotPasswordResetMethodView =
      "kForgotPasswordResetMethodView";
  static const String kForgotPasswordResetUsingSecurityQuestionsView =
      "kForgotPasswordResetUsingSecurityQuestionsView";
  static const String kForgotPasswordCreateNewPassword =
      "kForgotPasswordCreateNewPassword";
  static const String kForgotPasswordAccount = "kForgotPasswordAccount";
  static const String kPreLoginMenu = "kPreLoginMenu";
  static const String kHomeView = "kHomeView";
  static const String kQuickAccessMenu = "kQuickAccessMenu";
  static const String kPortfolioView = "kPortfolioView";
  static const String kOneTimeBPSaveBillerView = "kOneTimeBPSaveBillerView";
  static const String kSavedBillerListView = "kSavedBillerListView";
  static const String kBillPayeesView = "kBillPayeesView";
  static const String kMoreDetailOfBillerView = "kMoreDetailOfBillerView";
  static const String kPayBillsView = "kPayBillsView";
  static const String kBillPaymentView = "kBillPaymentView";
  static const String kEditBillerView = "kEditBillerView";
  static const String kEditBillerConfirmView = "kEditBillerConfirmView";
  static const String kBillPaymentsPlanNotFilledView =
      "kBillPaymentsPlanNotFilledView";
  static const String kAddBillerView = "kAddBillerView";
  static const String kBillerAddConfirmView = "kBillerAddConfirmView";
  static const String kBillPaymentMainView = "kBillPaymentMainView";
  static const String kBillPaymentStatusView = "kBillPaymentStatusView";
  static const String kBillPaymentSummaryView = "kBillPaymentSummaryView";
  static const String kProfileView = "kProfileView";
  static const String kTransactionLimit = "kTransactionLimit";
  static const String kSettingsLanguageSelectionView =
      "kSettingsLanguageSelectionView";
  static const String kSettingsChangePasswordView =
      "kSettingsChangePasswordView";
  static const String kEnableBiometricsView = "kEnableBiometricsView";

  static const String kFavouriteBillersView = "kFavouriteBillersView";

  static const String kGoldLoanPaymentSummaryView =
      "kGoldLoanPaymentSummaryView";
  static const String kGoldLoanTopUpView = "kGoldLoanTopUpView";
  static const String kGoldLoanListView = "kGoldLoanListView";
  static const String kGoldLoanPaymentReceipt = "kGoldLoanPaymentReceipt";

  static const String kBiometricsScanningView = "kBiometricsScanningView";
  static const String kEnableBiometricsPasswordView =
      "kEnableBiometricsPasswordView";
  static const String kNotificationsView = "kNotificationsView";
  static const String kAddPaymentInstrumentRootView =
      "kAddPaymentInstrumentRootView";
  static const String kAccountListView = "kAccountListView";
  static const String kEditAccountNicknameView = "kEditAccountNicknameView";
  static const String kQRScannerView = "kQRScannerView";
  static const String kQRPaymentView = "kQRPaymentView";
  static const String kOfferAndNotificationView = "kOfferAndNotificationView";
  static const String kQrPaymentSummaryView = "kQrPaymentSummaryView";
  static const String kQRPaymentStatusOtherBankView =
      "QRPaymentStatusOtherBankView";
  static const String kTransactionStatusView = "kTransactionStatusView";
  static const String kTransactionHistoryView = "kTransactionHistoryView";
  static const String kTransactionHistoryFilterView =
      "kTransactionHistoryFilterView";
  static const String kTransactionFilteredResultView =
      "kTransactionFilteredResultView";
  static const String kGoldLoadListView = "kGoldLoadListView";
  static const String kGoldLoadDetailView = "kGoldLoadDetailView";
  static const String kGoldLoanPaymentView = "kGoldLoanPaymentView";
  static const String kAddPayeeView = "kAddPayeeView";
  static const String kEditPayeeView = "kEditPayeeView";
  static const String kGoldLoadSelectAccount = "kGoldLoadSelectAccount";
  static const String kSavedPayeeListView = "kSavedPayeeListView";
  static const String kFundTransferReceiptView = "kFundTransferReceiptView";
  static const String kPayeeManagementListView = "kPayeeManagementListView";
  static const String kFundTransferSummeryView = "kFundTransferSummeryView";
  static const String kPayeeDetailsView = "kPayeeDetailsView";
  static const String kPayeeConfirmView = "kPayeeConfirmView";
  static const String kCommonPINAuthViewView = "kCommonPINAuthViewView";
  static const String kFundTransferScreenInput = "kFundTransferScreenInput";
  static const String kFundTransferUnSavedPayView =
      "kFundTransferUnSavedPayView";
  static const String kSavePayeeView = "kSavePayeeView";
  static const String kScheduleTransactionHistory =
      "kScheduleTransactionHistory";
  static const String kSchedulesView = "kSchedulesView";
  static const String kAllSchedulesView = "kAllSchedulesView";
  static const String kEditScheduleView = "kEditScheduleView";
  static const String kPromotionsOffersView = "kPromotionsOffersView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: const RouteSettings(name: Routes.kSplashView),
        );
      case Routes.kPersonalInformationView:
        return MaterialPageRoute(
          builder: (_) =>
              PersonalInformationView(isEditingEnabled: settings.arguments),
          settings: const RouteSettings(name: Routes.kPersonalInformationView),
        );
      case Routes.kOtherProducts:
        return MaterialPageRoute(
          builder: (_) => const OtherProductsView(),
          settings: const RouteSettings(name: Routes.kPersonalInformationView),
        );
      case Routes.kContactInformation:
        return MaterialPageRoute(
          builder: (_) =>
              ContactInformationView(isEditingEnabled: settings.arguments),
          settings: const RouteSettings(name: Routes.kContactInformation),
        );
      case Routes.kEmploymentDetail:
        return MaterialPageRoute(
          builder: (_) =>
              EmploymentDetailView(isEditingEnabled: settings.arguments),
          settings: const RouteSettings(name: Routes.kEmploymentDetail),
        );
      case Routes.kAddUserNamePasswordView:
        return MaterialPageRoute(
          builder: (_) => const AddUserNamePasswordView(),
          settings: const RouteSettings(name: Routes.kAddUserNamePasswordView),
        );
      case Routes.kRegProgress:
        return MaterialPageRoute(
          builder: (_) => const RegistrationProgressView(),
          settings: const RouteSettings(name: Routes.kRegProgress),
        );
      case Routes.kCreateProfileView:
        return MaterialPageRoute(
          builder: (_) => const CreateProfileView(),
          settings: const RouteSettings(name: Routes.kCreateProfileView),
        );
      case Routes.kSecurityQuestionsView:
        return MaterialPageRoute(
          builder: (_) => const SecurityQuestionView(),
          settings: const RouteSettings(name: Routes.kSecurityQuestionsView),
        );
      case Routes.kNewRegView:
        return MaterialPageRoute(
          builder: (_) => const NewRegistrationView(),
          settings: const RouteSettings(name: Routes.kNewRegView),
        );
      case Routes.kDropDownView:
        return MaterialPageRoute(
          builder: (_) => DropDownView(settings.arguments),
          fullscreenDialog: true,
          settings: const RouteSettings(name: Routes.kDropDownView),
        );
      case Routes.kBioMetricInformation:
        return MaterialPageRoute(
          builder: (_) => const BiometricInformationView(),
          settings: const RouteSettings(name: Routes.kBioMetricInformation),
        );
      case Routes.kBioMetricConfiguration:
        return MaterialPageRoute(
          builder: (_) => const BioMetricConfigurationView(),
          settings: const RouteSettings(name: Routes.kBioMetricConfiguration),
        );
      case Routes.kForgotPasswordCreateNewPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordCreateNewPassword(),
          settings: const RouteSettings(
              name: Routes.kForgotPasswordCreateNewPassword),
        );
      case Routes.kCommonOTPView:
        return MaterialPageRoute(
          builder: (_) => OTPView(args: settings.arguments),
          settings: const RouteSettings(name: Routes.kCommonOTPView),
        );
      case Routes.kReviewView:
        return MaterialPageRoute(
          builder: (_) => const ReviewView(),
          settings: const RouteSettings(name: Routes.kReviewView),
        );
      case Routes.kUserOtherInfoView:
        return MaterialPageRoute(
          builder: (_) =>
              UserOtherInformationView(isEditingEnabled: settings.arguments),
          settings: const RouteSettings(name: Routes.kUserOtherInfoView),
        );
      case Routes.kDocumentVerificationView:
        return MaterialPageRoute(
          builder: (_) =>
              DocumentVerificationView(isEditingEnabled: settings.arguments),
          settings: const RouteSettings(name: Routes.kDocumentVerificationView),
        );
      case Routes.kDocumentEditView:
        return MaterialPageRoute(
          builder: (_) => DocumentEditView(
            documentEditArguments: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kDocumentVerificationView),
        );
      case Routes.kScheduleVerificationView:
        return MaterialPageRoute(
          builder: (_) =>
              ScheduleVerificationView(isEditingEnabled: settings.arguments),
          settings: const RouteSettings(name: Routes.kScheduleVerificationView),
        );
      case Routes.kTermsAndConditionsView:
        return MaterialPageRoute(
          builder: (_) => TnCView(termsType: settings.arguments),
          settings: const RouteSettings(name: Routes.kTermsAndConditionsView),
        );
      case Routes.kLoginView:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: const RouteSettings(name: Routes.kLoginView),
        );
      case Routes.kForgotPasswordResetMethodView:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordResetMethodView(),
          settings:
              const RouteSettings(name: Routes.kForgotPasswordResetMethodView),
        );
      case Routes.kCreateProfileBySelectAccOrCard:
        return MaterialPageRoute(
          builder: (_) => const CreateProfileBySelectAccOrCard(),
          settings:
              const RouteSettings(name: Routes.kCreateProfileBySelectAccOrCard),
        );
      case Routes.kCreateProfileUsingCdbAcc:
        return MaterialPageRoute(
          builder: (_) => const CreateProfileUsingCdbAcc(),
          settings: const RouteSettings(name: Routes.kCreateProfileUsingCdbAcc),
        );
      case Routes.kIntroductionSlider:
        return MaterialPageRoute(
          builder: (_) => IntroductionSliderView(),
          settings: const RouteSettings(name: Routes.kIntroductionSlider),
        );
      case Routes.kForgotPwUserName:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordUserNameView(),
          settings: const RouteSettings(name: Routes.kForgotPwUserName),
        );
      case Routes.kLanguageView:
        return MaterialPageRoute(
          builder: (_) => const LanguageView(),
          settings: const RouteSettings(name: Routes.kLanguageView),
        );
      case Routes.kContactUsView:
        return MaterialPageRoute(
          builder: (_) => const ContactUsView(),
          settings: const RouteSettings(name: Routes.kContactUsView),
        );
      case Routes.kFAQView:
        return MaterialPageRoute(
          builder: (_) => const FAQView(),
          settings: const RouteSettings(name: Routes.kFAQView),
        );
      case Routes.kForgotPasswordResetUsingSecurityQuestionsView:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordRestUsingSecurityQuestionsView(),
          settings: const RouteSettings(
              name: Routes.kForgotPasswordResetUsingSecurityQuestionsView),
        );
      case Routes.kPreLoginMenu:
        return FadeRoute(
          page: PreLoginMenuView(false),
          settings: const RouteSettings(name: Routes.kPreLoginMenu),
        );
      case Routes.kForgotPasswordAccount:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordAccount(),
          settings: const RouteSettings(name: Routes.kForgotPasswordAccount),
        );
      case Routes.kHomeView:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: const RouteSettings(name: Routes.kHomeView),
        );
      case Routes.kQuickAccessMenu:
        return FadeRoute(
          page: QuickAccessMenuView(false),
          settings: const RouteSettings(name: Routes.kQuickAccessMenu),
        );
      case Routes.kPortfolioView:
        return MaterialPageRoute(
          builder: (_) => const PortfolioView(),
          settings: const RouteSettings(name: Routes.kPortfolioView),
        );
      case Routes.kOneTimeBPSaveBillerView:
        return MaterialPageRoute(
          builder: (_) => const SaveBillerView(),
          settings: const RouteSettings(name: Routes.kOneTimeBPSaveBillerView),
        );
      case Routes.kSavedBillerListView:
        return MaterialPageRoute(
          builder: (_) => SavedBillerListView(),
          settings: const RouteSettings(name: Routes.kSavedBillerListView),
        );
      case Routes.kBillPayeesView:
        return MaterialPageRoute(
          builder: (_) => BIllPayeesView(
            biller: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kBillPayeesView),
        );
      case Routes.kAddBillerView:
        return MaterialPageRoute(
          builder: (_) => AddBillerView(),
          settings: const RouteSettings(name: Routes.kSavedBillerListView),
        );
      case Routes.kBillerAddConfirmView:
        return MaterialPageRoute(
          builder: (_) => AddBillerConfirmView(
            addBillerArgs: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kSavedBillerListView),
        );
      case Routes.kMoreDetailOfBillerView:
        return MaterialPageRoute(
          builder: (_) => MoreDetailOfBillerView(
            savedBillerEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kMoreDetailOfBillerView),
        );
      case Routes.kPayBillsView:
        return MaterialPageRoute(
          builder: (_) => PayBillsView(),
          settings: const RouteSettings(name: Routes.kPayBillsView),
        );
      case Routes.kBillPaymentView:
        return MaterialPageRoute(
          builder: (_) => BillPaymentView(
            billerEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kBillPaymentView),
        );
      case Routes.kEditBillerView:
        return MaterialPageRoute(
          builder: (_) => EditBillerView(
            savedBillerEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kEditBillerView),
        );
      case Routes.kEditBillerConfirmView:
        return MaterialPageRoute(
          builder: (_) => EditBillerConfirmView(
            savedBillerEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kEditBillerConfirmView),
        );
      case Routes.kBillPaymentsPlanNotFilledView:
        return MaterialPageRoute(
          builder: (_) => const BillPaymentsPlanNotFilledView(),
          settings:
              const RouteSettings(name: Routes.kBillPaymentsPlanNotFilledView),
        );
      case Routes.kBillPaymentMainView:
        return MaterialPageRoute(
          builder: (_) => const BillPaymentMainView(),
          settings: const RouteSettings(name: Routes.kBillPaymentMainView),
        );
      case Routes.kBillPaymentStatusView:
        return MaterialPageRoute(
          builder: (_) => BillPaymentStatusView(),
          settings: const RouteSettings(name: Routes.kBillPaymentMainView),
        );
      case Routes.kBillPaymentSummaryView:
        return MaterialPageRoute(
          builder: (_) =>
              BillPaymentSummaryView(billPaymentArgs: settings.arguments),
          settings: const RouteSettings(name: Routes.kBillPaymentSummaryView),
        );
      case Routes.kProfileView:
        return MaterialPageRoute(
          builder: (_) => ProfileView(),
          settings: const RouteSettings(name: Routes.kProfileView),
        );
      case Routes.kTransactionLimit:
        return MaterialPageRoute(
          builder: (_) => const TransactionLimit(),
          settings: const RouteSettings(name: Routes.kTransactionLimit),
        );
      case Routes.kSettingsLanguageSelectionView:
        return MaterialPageRoute(
          builder: (_) => const LanguageSelectionView(),
          settings:
              const RouteSettings(name: Routes.kSettingsLanguageSelectionView),
        );
      case Routes.kSettingsChangePasswordView:
        return MaterialPageRoute(
          builder: (_) => const SettingsChangePasswordView(),
          settings:
              const RouteSettings(name: Routes.kSettingsChangePasswordView),
        );
      case Routes.kEnableBiometricsView:
        return MaterialPageRoute(
          builder: (_) => const EnableBiometricView(),
          settings: const RouteSettings(name: Routes.kEnableBiometricsView),
        );
      case Routes.kBiometricsScanningView:
        return MaterialPageRoute(
          builder: (_) => const BiometricsScanningView(),
          settings: const RouteSettings(name: Routes.kBiometricsScanningView),
        );
      case Routes.kEnableBiometricsPasswordView:
        return MaterialPageRoute(
          builder: (_) => const EnableBiometricsPasswordView(),
          settings:
              const RouteSettings(name: Routes.kEnableBiometricsPasswordView),
        );
      case Routes.kAddPaymentInstrumentRootView:
        return MaterialPageRoute(
          builder: (_) => const AddPaymentInstrumentView(),
          settings:
              const RouteSettings(name: Routes.kAddPaymentInstrumentRootView),
        );
      case Routes.kNotificationsView:
        return MaterialPageRoute(
          builder: (_) => const NotificationsView(),
          settings: const RouteSettings(name: Routes.kNotificationsView),
        );
      case Routes.kAccountListView:
        return MaterialPageRoute(
          builder: (_) => AccountListView(),
          settings: const RouteSettings(name: Routes.kAccountListView),
        );
      case Routes.kAccountDetailView:
        return MaterialPageRoute(
          builder: (_) => AccountDetailView(
            accountEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kAccountDetailView),
        );
      case Routes.kEditAccountNicknameView:
        return MaterialPageRoute(
          builder: (_) => EditAccountNicknameView(
            accountEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kEditAccountNicknameView),
        );
      case Routes.kOfferAndNotificationView:
        return MaterialPageRoute(
          builder: (_) => const OfferAndPromotionView(),
          settings: const RouteSettings(name: Routes.kOfferAndNotificationView),
        );

      case Routes.kQRScannerView:
        return MaterialPageRoute(
          builder: (_) => QRScannerView(),
          settings: const RouteSettings(name: Routes.kQRScannerView),
        );
      case Routes.kQrPaymentSummaryView:
        return MaterialPageRoute(
          builder: (_) => const QrPaymentSummaryView(),
          settings: const RouteSettings(name: Routes.kQrPaymentSummaryView),
        );
      case Routes.kQRPaymentStatusOtherBankView:
        return MaterialPageRoute(
          builder: (_) => QRPaymentStatusOtherBankView(),
          settings:
              const RouteSettings(name: Routes.kQRPaymentStatusOtherBankView),
        );
      case Routes.kTransactionStatusView:
        return MaterialPageRoute(
          builder: (_) => TransactionStatusView(
            transactionHistoryArgs: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kTransactionStatusView),
        );
      case Routes.kTransactionHistoryView:
        return MaterialPageRoute(
          builder: (_) => const TransactionHistoryView(),
          settings: const RouteSettings(name: Routes.kTransactionHistoryView),
        );
      case Routes.kTransactionHistoryFilterView:
        return MaterialPageRoute(
          builder: (_) => const TransactionHistoryFilterView(),
          settings:
              const RouteSettings(name: Routes.kTransactionHistoryFilterView),
        );
      case Routes.kQRPaymentView:
        return MaterialPageRoute(
          builder: (_) => QrPaymentView(
            lankaQrPayload: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kQRPaymentView),
        );

      case Routes.kGoldLoanPaymentSummaryView:
        return MaterialPageRoute(
          builder: (_) => GoldLoanPaymentSummaryView(
            goldLoanPaymentSummeryArgs: settings.arguments,
          ),
          settings:
              const RouteSettings(name: Routes.kGoldLoanPaymentSummaryView),
        );
      case Routes.kGoldLoanTopUpView:
        return MaterialPageRoute(
          builder: (_) => GoldLoanTopUpView(
            goldLoanEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kGoldLoanTopUpView),
        );
      case Routes.kGoldLoanListView:
        return MaterialPageRoute(
          builder: (_) => GoldLoanListView(),
          settings: const RouteSettings(name: Routes.kGoldLoanListView),
        );
      case Routes.kGoldLoanPaymentReceipt:
        return MaterialPageRoute(
          builder: (_) => LoanPaymentReceipt(
            goldLoanPaymentSummeryArgs: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kGoldLoanPaymentReceipt),
        );

      case Routes.kFavouriteBillersView:
        return MaterialPageRoute(
          builder: (_) => const FavouriteBillersView(),
          settings: const RouteSettings(name: Routes.kFavouriteBillersView),
        );
      case Routes.kGoldLoadListView:
        return MaterialPageRoute(
          builder: (_) => GoldLoanListView(),
          settings: const RouteSettings(name: Routes.kGoldLoadListView),
        );
      case Routes.kGoldLoadDetailView:
        return MaterialPageRoute(
          builder: (_) => LoanDetailsView(
            goldLoanEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kGoldLoadDetailView),
        );
      case Routes.kGoldLoadSelectAccount:
        return MaterialPageRoute(
          builder: (_) => SelectAccountView(
            selectAccountViewParam: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kGoldLoadSelectAccount),
        );
      case Routes.kGoldLoanPaymentView:
        return MaterialPageRoute(
          builder: (_) => const GoldLoanPaymentView(),
          settings: const RouteSettings(name: Routes.kGoldLoanPaymentView),
        );
      case Routes.kFundTransferScreenInput:
        return MaterialPageRoute(
          builder: (_) => const FundTransferScreenInput(),
          settings: const RouteSettings(name: Routes.kFundTransferScreenInput),
        );
      case Routes.kFundTransferReceiptView:
        return MaterialPageRoute(
          builder: (_) => FundTransferReceiptView(
            fundTransferEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kFundTransferReceiptView),
        );
      case Routes.kAddPayeeView:
        return MaterialPageRoute(
            builder: (context) => AddPayeeView(),
            settings: const RouteSettings(name: Routes.kAddPayeeView));

      case Routes.kEditPayeeView:
        return MaterialPageRoute(
            builder: (context) => EditPayeeView(
                  savedPayeeEntity: settings.arguments,
                ),
            settings: const RouteSettings(name: Routes.kEditPayeeView));

      case Routes.kSavedPayeeListView:
        return MaterialPageRoute(
            builder: (context) => SavedPayeeListView(
                  isFromFundTransfer: settings.arguments,
                ),
            settings: const RouteSettings(name: Routes.kSavedPayeeListView));

      case Routes.kPayeeDetailsView:
        return MaterialPageRoute(
          builder: (_) => PayeeDetails(
            payeeDetails: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kPayeeDetailsView),
        );
      case Routes.kPayeeConfirmView:
        return MaterialPageRoute(
            settings: const RouteSettings(name: Routes.kPayeeDetailsView),
            builder: (context) {
              final text = settings.arguments as PayeeConfirmView;
              return PayeeConfirmView(
                payeeDetails: text.payeeDetails,
                isEditView: text.isEditView,
              );
            });
      case Routes.kFundTransferSummeryView:
        return MaterialPageRoute(
          builder: (_) => FundTransferSummaryView(
            fundTransferEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kFundTransferSummeryView),
        );
      case Routes.kCommonPINAuthViewView:
        return MaterialPageRoute(
          builder: (_) => CommonPinAuthView(
            commonPinAuthArguments: CommonPinAuthArguments(),
          ),
          settings: const RouteSettings(name: Routes.kCommonPINAuthViewView),
        );
      case Routes.kPayeeManagementListView:
        return MaterialPageRoute(
          builder: (_) => PayeeManagementListView(),
          settings: const RouteSettings(name: Routes.kPayeeManagementListView),
        );
      case Routes.kFundTransferUnSavedPayView:
        return MaterialPageRoute(
          builder: (_) => const UnsavedPayeeView(),
          settings:
              const RouteSettings(name: Routes.kFundTransferUnSavedPayView),
        );
      case Routes.kSavePayeeView:
        return MaterialPageRoute(
          builder: (_) => SavePayee(
            fundTransferEntity: settings.arguments,
          ),
          settings: const RouteSettings(name: Routes.kSavePayeeView),
        );
      case Routes.kScheduleTransactionHistory:
        return MaterialPageRoute(
          builder: (_) => ScheduleTransactionHistory(),
          settings:
              const RouteSettings(name: Routes.kScheduleTransactionHistory),
        );
      case Routes.kSchedulesView:
        return MaterialPageRoute(
          builder: (_) => SchedulesView(),
          settings: const RouteSettings(name: Routes.kSchedulesView),
        );
      case Routes.kAllSchedulesView:
        return MaterialPageRoute(
          builder: (_) => AllSchedulesView(),
          settings: const RouteSettings(name: Routes.kAllSchedulesView),
        );
      case Routes.kEditScheduleView:
        return MaterialPageRoute(
          builder: (_) => const EditScheduleView(),
          settings: const RouteSettings(name: Routes.kEditScheduleView),
        );
      case Routes.kPromotionsOffersView:
        return MaterialPageRoute(
          builder: (_) => const PromotionsOffersView(),
          settings: const RouteSettings(name: Routes.kPromotionsOffersView),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Center(
              child: Text("Invalid Route",
                  style: AppStyling.boldTextSize16
                      .copyWith(color: AppColors.accentColor)),
            ),
          ),
        );
    }
  }
}
