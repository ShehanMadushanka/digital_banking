import 'package:flutter/cupertino.dart';

import 'app_localizations.dart';

extension LocalizeString on String {
  String localize(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}

class AppString {
  ///App permission Dialog
  static const String appPermissionRequest = 'dv_app_permission_request';
  static const String appNavigateSettings = 'dv_app_permission_settings';
  static const String appSessionTimeout = 'appSessionTimeout';

  /// Personal Info
  static const String personalInformation = 'personal_information';
  static const String title = "title";
  static const String menu = "menu";
  static const String nameInitials = "initials_name";
  static const String representName = "represent_name";
  static const String selectTitle = "select_title";
  static const String lastName = "last_name";
  static const String language = "language";
  static const String nationality = "nationality";
  static const String religion = "religion";
  static const String nic = "nic";
  static const String gender = "gender";
  static const String male = "male";
  static const String female = "female";
  static const String dob = "dob";
  static const String martialStatus = "martial_status";
  static const String single = "single";
  static const String married = "married";
  static const String selectLanguage = "select_language";
  static const String selectReligion = "select_religion";
  static const String mothersMaidenName = "mother_maiden_name";

  /// Contact Info
  static const String contactInfo = "contact_info";
  static const String mobileNo = "mobile_no";
  static const String email = "email";
  static const String city = "city";
  static const String selectCity = "select_city";
  static const String contactInfoRadioLabel = "contact_info_radio_label";
  static const String permAddress = "perm_address";
  static const String addressOne = "address_1";
  static const String addressTwo = "address_2";
  static const String addressThree = "address_3";

  ///Document Verification
  static const String selfieImage = "dv_selfie";
  static const String dvIdCaptureSelfie = "dv_idCapture_selfie";
  static const String dvIdCaptureFontID = "dv_id_capture_front_id";
  static const String dvIdCaptureBackID = "dv_id_capture_back_id";
  static const String dvIdCaptureBilling = "dv_id_capture_billing";
  static const String dvIdSelectionDescription = "dv_id_selection";
  static const String radioNIC = "dv_radio_nic";
  static const String radioDriving = "dv_radio_driving";
  static const String radioPassport = "dv_radio_passport";
  static const String dvProofAddress = "dv_proof_address";
  static const String dvAcceptedDoc = "dv_accepted_doc";
  static const String dvEditSelfieTitle = "dv_edit_selfie_title";
  static const String dvEditFIDTitle = "dv_edit_fid_title";
  static const String dvEditBIDTitle = "dv_edit_bid_title";
  static const String dvEditBillTitle = "dv_edit_bill_title";
  static const String dvButtonCamera = "dv_btn_camera";
  static const String dvButtonUpload = "dv_btn_upload";

  /// Schedule Verification
  static const String titleScheduleVerification = "schedule_verification_title";
  static const String svDescription = "sv_description";
  static const String svPickTime = "sv_pick_time";
  static const String svPickDate = "sv_pick_date";

  /// Employment Details
  static const String empDetails = "emp_details";
  static const String empType = "emp_type";
  static const String employerName = "employer_name";
  static const String employerAddress = "employer_address";
  static const String employmentField = "employment_field";
  static const String designation = "designation";
  static const String income = "annual_income";
  static const String selectEmploymentField = "emp_field_select";
  static const String selectEmploymentType = "select_emp_type";
  static const String selectDesignation = "select_designation";
  static const String selectIncome = "select_income";

  /// User Reg In Progress View
  static const String userRegProgress = "user_reg_progress";
  static const String completeReg = "complete_reg";
  static const String registerWith = "register_with";

  /// User Reg New View
  static const String newWallet = "create_new_wallet";
  static const String cdbAccCard = "cdb_acc_card";
  static const String otherBank = "other_bank";
  static const String chooseOptionReg = "choose_option_register";

  /// Alert Dialog
  static const String leaveRegForm = "leave_reg_form";

  /// Common
  static const String next = "next";
  static const String completeLater = "complete_later";
  static const String search = "search";
  static const String yes = "yes";
  static const String yesCancel = "button_yes_cancel";
  static const String no = "no";
  static const String tryAgain = "try_again";
  static const String done = "done";
  static const String login = "login";

  ///Bio Metric
  static const String turnOnFaceId = "turn_on_Face_ID";
  static const String turnOnTouchId = "turn_on_Touch_ID";
  static const String skip = "skip";
  static const String addYourBiometric = "add_Your_Biometrics";
  static const String biometricPageDescription = "login_using_biometric";
  static const String scan = "scan";
  static const String faceIDInitial = "bio_mertic_configarations";
  static const String touchIDInitial = "touch_your_fingerprint_scanner";
  static const String touchIDConfigurationSuccessful =
      "fingerprint_successfully";
  static const String touchIDConfigurationFailed =
      "fingerprint_not_successfully";
  static const String faceIDConfigurationSuccessful = "faceId_successfully";
  static const String titlePasswordExpired = "title_pwd_expired";
  static const String descriptionPasswordExpired = "desc_pwd_expired";
  static const String labelCreateNewPassword = "label_create_new_pwd";

  /// Security Questions
  static const String securityQuestions = "security_questions";
  static const String securityQuestionsDes = "security_question_des";
  static const String selectSecurityQuestion = "select_sec_question";
  static const String securityQuestion = "security_question";
  static const String answer = "answer";

  /// Create A Profile
  static const String createProfile = "create_profile";
  static const String cusRegSuccess = "cus_reg_success";
  static const String cusRegDes1 = "cus_reg_des1";
  static const String cusRegDes2 = "cus_reg_des2";
  static const String notNow = "not_now";
  static const String createYourProfile = "create_your_profile";

  static const String selectYourPreferredMethod =
      "select_your_preferred_method";
  static const String myCdbCard = "my_cdb_card";
  static const String myCdbAcc = "my_cdb_acc";
  static const String enterCdbAccNumber = "enter_cdb_acc_number";
  static const String accNumber = "acc_number";

  /// Quick Access
  static const String close = "close";

  ///Biller Management
  static const String titleBillers = "title_billers";
  static const String titleBillPayees = "title_bill_payees";
  static const String titlePayBills = "title_pay_bills";
  static const String titleBillPayment = "title_bill_payment";
  static const String titleBillPaymentStatus = "title_bill_payment_status";
  static const String billerCategory = "biller_category";
  static const String billerName = "biller_name";
  static const String nickName = "nick_name";
  static const String remarkss = "remarks";
  static const String titleBillPaymentSummary = "title_bill_payment_summary";

  ///User Other Info
  static const String politicallyExposed = "politically_exposed";
  static const String purposeAccountOpening = "purpose_account_opening";
  static const String politicalExposure = "political_exposure";
  static const String involvedInPolitics = "involved_in_politics";
  static const String holdingPosition = "holding_position";
  static const String memberParliament = "member_parliment";
  static const String taxPayerUsa = "tax_payer_USA";
  static const String sourceOfFunds = "source_of_Funds";
  static const String transactionMode = "transaction_Mode";
  static const String anticipatedDeposits = "anticipated_Deposits";
  static const String marketingReference = "marketing_Reference";

  /// Other Products
  static const String otherProducts = "other_products";
  static const String addMoreProducts = "add_more_products";
  static const String applyLoan = "apply_loan";
  static const String applyLease = "apply_lease";
  static const String openFd = "open_fd";
  static const String openCurrentAcc = "open_ca";
  static const String openSavingAcc = "open_sa";
  static const String titleOtherProductSubmitSuccess =
      "title_other_product_submit";
  static const String descriptionOtherProductSubmitSuccess =
      "description_other_product_submit";

  /// Add Username password View
  static const String setUpLoginDetails = "set_up_login";
  static const String userName = "user_name";
  static const String password = "password";
  static const String confirmPassword = "confirm_Password";
  static const String setUpLoginDescription = "set_up_login_desc";

  /// Login View
  static const String forgetPassword = "button_forget_password";
  static const String registerNewUser = "button_new_user_register";
  static const String or = "label_or";
  static const String emptyUsername = "error_empty_username";
  static const String emptyPassword = "error_empty_password";
  static const String welcomeTo = "login_label_welcome_to";

  ///Login View

  static const String success = "success";
  static const String failed = "failed";
  static const String cancel = "cancel";
  static const String saveExit = "save_exit";
  static const String save = "save";
  static const String confirm = "confirm";
  static const String home = "button_home";

  ///Update Password
  static const String emptyOldPassword = "error_empty_old_password";
  static const String emptyNewPassword = "error_empty_new_password";
  static const String emptyConfirmNewPassword =
      "error_empty_confirm_new_password";
  static const String notMatchNewPasswordAndConfirmPassword =
      "not_match_new_password_and_confirm_password";

  ///Marketing Banners
  static const String payFast = "pay_fast";
  static const String payEasy = "pay_easy";
  static const String easySafe = "easy_safe";
  static const String transactionWithCdb = "transaction_with_cdb";
  static const String qr = "qr";
  static const String payments = "payments";
  static const String youCanJustScanAndPay = "you_can_just_scan_and_pay";
  static const String withCdbIpay = "with_cdb_ipay";
  static const String digital = "digital";
  static const String wallet = "wallet";
  static const String keepEasyAndKeepSafe = "keep_easy_and_keep_safe";
  static const String withAllWalletFeatures = "with_all_wallet_features";

  /// Validation Messages
  // static const String validMobile = "enter_valid_mobile_no";
  static const String validMobile = "Enter a valid mobile number";

  // static const String validEmail = "enter_valid_email";
  static const String validEmail = "Enter a valid email";

  static const String validNicKey = "enter_valid_nic";
  static const String validNic = "Enter a valid NIC";
  static const String validNicDob = "NIC does not match with DOB";

  /// Forgot Password Reset Method
  static const String forgotPasswordTitle = "forgot_password";
  static const String forgotPasswordSecQuesTitle = "forgot_password_sec_ques";
  static const String forgotPasswordResetMethod =
      "forgot_password_reset_method";
  static const String cdbAccount = "cdb_account";
  static const String forgotPwSecurityQuestionsDes =
      "forgot_pw_security_question_des";
  static const String labelIncorrectPassword = "label_incorrect_pwd";
  static const String descIncorrectPassword = "desc_incorrect_pwd";
  static const String contactUsOn = "contact_us_on";
  static const String passwordCreationSuccess = "pwd_creation_success";
  static const String invalidCredentials = "invalid_credentials";
  static const String errorDetailsNotFound = "err_details_not_found";

  /// Forgot Password
  static const String forgotPwUserName = "forgot_pw_user_name";
  static const String forgotUserName = "forgot_username";
  static const String createNewPw = "create_new_pw";
  static const String createNewPwDesc = "create_new_pw_desc";
  static const String newPassword = "new_pw";
  static const String confirmNewPassword = "confirm_new_pw";

  /// Contact Us
  static const String cUsTitle = "contact_us_title";
  static const String cUsWelcomeMessage = "contact_us_welcome_message";
  static const String cUsWebEmail = "contact_us_web_and_email";
  static const String cUsFindUsSocialMedia = "contact_us_find_us_social_media";
  static const String cUsGetInTouch = "contact_us_get_in_touch";
  static const String cUsGeneralNumber = "contact_us_general_number";
  static const String cUsCenterContact = "contact_us_center_contact";
  static const String cUsFaxNumber = "contact_us_fax_number";

  /// Pre Login View
  static const String faqTitle = "faq_title";
  static const String moreDetails = "more_details";

  /// Home Main View
  static const String portfolio = "portfolio";
  static const String history = "history";
  static const String settings = "settings";

  /// Home Wallet View
  static const String recentTransactions = "recent_transaction";
  static const String seeAll = "see_all";
  static const String add = "add";
  static const String myFavourites = "my_favourites";
  static const String goodMorning = "good_morning";
  static const String goodAfternoon = "good_afternoon";
  static const String goodEvening = "good_evening";
  static const String accountBalance = "account_balance";
  static const String topUp = "top_up";
  static const String payBill = "pay_bill";
  static const String qrPay = "qr_pay";
  static const String transfer = "transfer";

  /// Bill Payments and Biller Management
  static const String serviceProvider = "service_provider";
  static const String favourite = "favourite";
  static const String edit = "edit";
  static const String delete = "delete";
  static const String nickname = "nickname";
  static const String billPayment = "bill_payment";
  static const String mobileBillPlan = "mobile_bill_plan";
  static const String payFrom = "pay_from";
  static const String payTo = "pay_to";
  static const String payNow = "pay_now";
  static const String amountLkr = "amountLkr";
  static const String saveBiller = "button_save_biller";
  static const String statusPaymentSuccess = "status_payment_success";
  static const String statusPaymentFailed = "status_payment_failed";
  static const String descriptionPaymentFailed = "desc_payment_failed";
  static const String buttonDownload = "button_download";
  static const String buttonShare = "button_share";
  static const String amount = "label_amount";
  static const String serviceCharge = "label_service_charge";
  static const String lkr = "label_lkr";
  static const String date = "label_date";
  static const String referenceNumber = "label_reference_number";
  static const String remarks = "label_remarks";
  static const String cdbSalaryPlus = "cdb_salary_plus";
  static const String billPaymentSummaryFirst = "bill_payment_summary_first";
  static const String billPaymentSummarySecond = "bill_payment_summary_second";
  static const String billerAddeddSuccessfully = "biller_added_successfully";
  static const String nickNameEditedSuccessfully =
      "nickname_edited_successfully";
  static const String deleteSaved = "delete_saved";
  static const String deleteBillerDes = "delete_biller_desc";
  static const String cancelEdit = "cancel_edit";
  static const String cancelEditDesc = "cancel_edit_desc";
  static const String deleteBillerSuccess = "delete_biller_success";

  /// Transaction Limit
  static const String titleTransactionLimit = "title_transaction_limit";
  static const String dailyTransactionLimit = "daily_transaction_limit";
  static const String maxTransaction = "max_transaction";
  static const String secondaryVerification = "secondary_verification";

  ///Profile
  static const String titleProfile = "appbar_title_profile";
  static const String titleProfileImage = "appbar_title_profile_image";
  static const String walletID = "label_wallet_it";

  /// Change Password
  static const String currentPassword = "current_password";
  static const String settingsChangePwsTitle = "settings_change_pws_title";
  static const String settingsChangePwsDecs = "settings_change_pws_desc";
  static const String settingsChangePwsSuccessToast =
      "settings_change_pws_success_toast";

  /// Biometrics Settings
  static const String biometricSettings = "biometric_settings";
  static const String biometricSettingsDecs = "biometric_settings_desc";
  static const String fingerprint = "fingerprint";
  static const String biometricsVerificationTitle =
      "biometrics_verification_title";
  static const String saveFingerprint = "save_fingerprint";
  static const String biometricEnablePswDesc = "biometric_enable_psw_desc";
  static const String continueTxt = "continue";

  /// Notification
  static const String notificationsTitle = "notifications_title";
  static const String offerAndPromotions = "offer_and_promotions";
  static const String offerPromotionsHeadline = "offer_promotions_headline";
  static const String offerPromotionsDesc = "offer_promotions_desc";
  static const String offerPromotionsDate = "offer_promotions_date";
  static const String noNotifications = "no_notifications";
  static const String noNotificationsDescription =
      "no_notifications_description";
  static const String payToMobile = "pay_to_mobile";
  static const String youHaveSuccessfully = "you_have_successfully";
  static const String from = "from";
  static const String to = "to";
  static const String ok = "ok";
  static const String dateAndTime = "date_and_time";
  static const String remarksNotification = "remarks_notification";
  static const String referenceNumberNotification =
      "reference_number_notification";

  /// Payment instrument manage
  static const String titleAddPaymentInstrumentRoot = "payment_options";
  static const String titlePaymentOptionsCDBBank = "payment_options_cdb_bank";
  static const String titlePaymentOptionsOtherBank =
      "payment_options_other_bank";
  static const String titleAddNewPaymentOption =
      "title_add_new_payment_options";
  static const String decriptionAddNewCDB = "desc_add_cdb_payment_options";
  static const String decriptionAddNewOther = "desc_add_other_payment_options";
  static const String titleAccountAddSuccess = "title_account_add_successful";
  static const String labelAvailableBalance = "label_available_balance";
  static const String labelAccountNickName = "label_account_nickname";
  static const String labelAccountNumber = "label_account_number";
  static const String labelTotalAvailableBalance =
      "label_total_account_balance";
  static const String labelPrimaryAccount = "label_primary_account";
  static const String labelHideFromPaymentOptions =
      "label_hide_from_payment_options";
  static const String changeNickname = "button_change_nickname";

  ///Lanka QR Payment
  static const String labelQRScanner = "label_qr_scanner";

  /// QR Payment Status
  static const String qrPaymentStatusTitle = "qr_payment_status_title";

  /// Transaction History
  static const String transactionHistoryTitle = "transaction_history_title";
  static const String transactionStatus = "transaction_status";
  static const String filterTransactionsTitle = "filter_transactions_title";
  static const String applyFilters = "apply_filters";
  static const String resetAll = "reset_all";
  static const String fromDate = "from_date";
  static const String toDate = "to_date";
  static const String amountRange = "amount_range";
  static const String transactionType = "transaction_type";
  static const String adjustFilters = "adjust_filters";
  static const String instrumentNickname = "instrument_nickname";
  static const String titleQrPaymentSummary = "title_qr_payment_summary";

  static const String titleQRPayment = "title_qr_payment";
  static const String titleCancelQRPayment = "title_cancel_qr_payment";
  static const String descCancelQRPayment = "desc_cancel_qr_payment";

  ///Gold Loan
  static const String ticketNumber = "ticket_number";
  static const String active = "active";
  static const String auction = "auction";
  static const String outstandingAmount = "outstanding_amount";
  static const String titleGoldLoans = "title_gold_loans";
  static const String titleLoanDetails = "title_loan_details";
  static const String titleLoanPayment = "title_loan_payment";
  static const String titleGoldLoanTopUp = "title_gold_loan_top_up";
  static const String additionalChargesApplied = "additional_charges_applied";
  static const String auctionError = "auction_error";
  static const String articleDetails = "article_details";
  static const String status = "status";
  static const String loanPeriodInMonths = "loan_period_in_month";
  static const String expiryDate = "expiry_date";
  static const String interestBalance = "interest_balance";
  static const String maximumAdvanceLimit = "maximum_advance_limit";
  static const String capitalBalance = "capital_balance";
  static const String remainingAdvanceLimit = "remaining_advance_limit";
  static const String makeAPayment = "make_a_payment";
  static const String makeATopUp = "make_a_top_up";
  static const String noRemainingLimitTopUp = "no_remaining_limit_top_up";
  static const String noTopUpThisMonth = "no_top_up_for_this_month";
  static const String creditTo = "credit_to";
  static const String topUpAmount = "top_up_amount";
  static const String summaryDate = "summary_date";
  static const String goldLoanTopUpAmountHint = "gold_loan_top_up_amount_hint";
  static const String goldLoanTopUpAmountError =
      "gold_loan_top_up_amount_Error";

  static const String loanPaymentReceiptTitle = "loan_payment_receipt_title";
  static const String loanPaymentReceiptSuccessfulTitle =
      "loan_payment_receipt_successful_title";
  static const String loanPaymentReceiptFailTitle =
      "loan_payment_receipt_fail_title";
  static const String loanPaymentReceiptFailDescription =
      "loan_payment_receipt_fail_description";

  /// Gold Loan
  static const String loanPaymentSummaryTitle = "loan_payment_summary_title";

  ///Payee Management
  static const String savedPayeeListTitle = "saved_payee_list_title";
  static const String noPayeeTitle = "no_payee_title";
  static const String noPayeeDesc = "no_payee_desc";
  static const String titleDeletePayee = "title_delete_payee";
  static const String titleDeletePayees = "title_delete_payees";
  static const String descriptionDeletePayee = "desc_delete_payee";
  static const String descriptionDeletePayees = "desc_delete_payees";
  static const String buttonYesDelete = "button_yes_delete";

  /// Fund Transfer
  static const String addPayeeViewTitle = "add_payee_view_title";
  static const String editPayeeViewTitle = "edit_payee_view_title";
  static const String bank = "bank";
  static const String addAsAFavorite = "add_as_a_favorite";
  static const String fundTransferStatusTitle = "fund_transfer_status_title";
  static const String fundTransferSuccessful = "fund_transfer_successful";
  static const String fundTransferFailure = "fund_transfer_failure";
  static const String fundTransferFailureDescription =
      "fund_transfer_failure_description";
  static const String fundTransferPaidFrom = "fund_transfer_paid_from";
  static const String fundTransferPaidTo = "fund_transfer_paid_to";
  static const String fundTransferAmount = "fund_transfer_amount";
  static const String fundTransferServiceCharge =
      "fund_transfer_service_charge";
  static const String fundTransferTransactionCategory =
      "fund_transfer_transaction_category";
  static const String fundTransferReference = "fund_transfer_reference";
  static const String fundTransferRemark = "fund_transfer_remark";
  static const String fundTransferEmail = "fund_transfer_email";
  static const String fundTransferMobile = "fund_transfer_Mobile";
  static const String fundTransferDate = "fund_transfer_date";
  static const String fundTransferReferenceId = "fund_transfer_reference_id";
  static const String fundTransferSavePayees = "fund_transfer_save_payees";

  ///Fund Transfer
  static const String fundTransferSummeryTitle = "title_ft_summery";
  static const String fundTransferScreenInputTitle =
      "fund_transfer_screen_input_title";
  static const String scheduleType = "schedule_type";
  static const String startDate = "start_date";
  static const String frequency = "frequency";
  static const String endDate = "end_date";
  static const String noOfTransfers = "no_of_transfers";
  static const String transactionCategory = "transaction_category";
  static const String reference = "reference";
  static const String remark = "remark";
  static const String benefEmail = "benef_email";
  static const String benefMobile = "benef_mobile";
  static const String balanceBeforeTransfer = "balance_before_transfer";
  static const String balanceAfterTransfer = "balance_after_transfer";
  static const String payeeManagement = "payeeManagement";
  static const String ft2faCommonPinTitle = "ft_2fa_pin_title";
  static const String ft2faCommonPinDescription = "ft_2fa_pin_desc";
  static const String proceed = "proceed";
  static const String fundTransferName = "fund_transfer_name";
  static const String fundTransferCategory = "fund_transfer_category";
  static const String fundTransferRemarksOpt = "fund_transfer_remarks_opt";
  static const String fundTransferNotifyTheBeneficiary = "fund_transfer_notify";
  static const String name = "name";
  static const String savePayee = "save_payee";
  static const String addAsFavorite = "add_as_favorite";
  static const String fundTransferScheduleTitle =
      "fund_transfer_schedule_title";
  static const String pay = "pay";
  static const String transactionDate = "transaction_date";
  static const String selectPayee = "select_payee";

  ///Payee Management
  static const String payeeDetails = "payee_details";
  static const String accHolderName = "acc_holder_name";
  static const String addedAsFavorite = "added_as_favorite";
  static const String cancelAddPayeeTitle = "cancel_add_payee_title";
  static const String cancelAddPayeeDesc = "cancel_add_payee_desc";
  static const String cancelEditPayeeTitle = "cancel_edit_payee_title";
  static const String cancelEditPayeeDesc = "cancel_edit_payee_desc";

  ///Promotions & Offers
  static const String promotionAndOffers = "promotion_and_offers";

  //Schedules
  static const String titleDeleteSchedule = "title_delete_schedule";
  static const String descriptionDeleteSchedule = "desc_delete_schedule";
  static const String noteDescriptionDeleteSchedule = "note_description_delete_schedule";
  static const String noteDeleteSchedule = "note_delete_schedule";
}
