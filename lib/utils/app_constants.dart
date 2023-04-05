import 'package:cdb_mobile/features/data/models/responses/city_response.dart';

const String kPNGImagePath = 'images/pngs/';
const String kSVGImagePath = 'images/svgs/';
const String kAnimImagePath = 'animations/';

const String kSVGType = '.svg';
const String kPngType = '.png';
const String kPDFType = '.pdf';
const String kAnimType = '.json';

const int kAppSessionTimeout = 3 * 60;

const kVendorAndroid = 'com.android.vending';
const kVendorHuawei = 'com.huawei.appmarket';
const kVendorApple = 'com.apple.AppStore';
const kVendorTestFlight = 'com.apple.TestFlight';

// Encryption
const String XOR = "4C32945B5D34C7732F2AF7C751D0BFB6";

const kAppMaxTimeout = "05";
const kReferenceNumber = "EPIC_CDB_APP_DBP_020100_00007";
const kDeviceChannel = "01"; // Mobile Channel
const kMessageVersion = "2.2";

const String kLocaleEN = 'en';
const String kLocaleSI = 'si';
const String kLocaleTA = 'ta';

const kAppName = 'CDB Digital Banking';
const kFontFamily = 'PublicSans';

/// UI ->  Margin, Opacity, Width
const kAppOpacity = 0.25;
const double kLeftRightMarginOnBoarding = 16;
const double kTopMarginOnBoarding = 32;
const double kBottomMargin = 20;
const double kTextFieldBottomBorderHeight = 2;
const double kOnBoardingMarginBetweenFields = 25;

// OnBoarding Types
const kAccountOnBoarding = 'AC';
const kCreditCardOnBoarding = 'CC';
const kDebitCardOnBoarding = 'DC';
const kJustPayOnBoarding = 'JP';
const kDigitalOnBoarding = 'DO';

//Term Type
const kJustPayTerms = 'justPay';
const kAccountTerms = 'account';
const kCardTerms = 'card';
const kGeneralTerms = 'general';

//Field Type
const fieldTypeTextField = 'TEXT FIELD';
const fieldTypeOneLineLabelField = 'ONE LINE LABEL FIELD';
const fieldTypeLableField = 'LABEL FIELD';
const fieldTypeDropDown = 'DROP DOWN';

//OTP Types
const kOtpMessageTypeOnBoarding = 'digitalOnboarding';
const kOtpMessageTypeNewDevice = 'newDevice';
const kOtpMessageTypeInactiveDevice = 'inactiveDevice';
const kOtpMessageTypeFundTransfer = 'ftr';
const kOtpMessageTypeBillPayment = 'billPayment';

/// App UI Constants
final List<CommonDropDownResponse> kTitleList = List.unmodifiable(
  [
    CommonDropDownResponse(id: 1, description: "COL", key: "col"),
    CommonDropDownResponse(id: 2, description: "DR", key: "dr"),
    CommonDropDownResponse(id: 3, description: "M/S", key: "mS"),
    CommonDropDownResponse(id: 4, description: "Master", key: 'mas'),
    CommonDropDownResponse(id: 5, description: "Miss", key: 'miss'),
    CommonDropDownResponse(id: 6, description: "MRS", key: 'mrs'),
    CommonDropDownResponse(id: 7, description: "MS", key: 'ms'),
    CommonDropDownResponse(id: 8, description: "Prof", key: 'prof'),
    CommonDropDownResponse(id: 9, description: "REV", key: 'rev'),
    CommonDropDownResponse(id: 10, description: "SIR", key: 'sir'),
    CommonDropDownResponse(id: 11, description: "Sister", key: 'sis'),
    CommonDropDownResponse(id: 12, description: "MR", key: 'mr'),
  ],
);
final List<CommonDropDownResponse> kLanguageList = List.unmodifiable([
  CommonDropDownResponse(id: 2, description: "Sinhala", key: "si"),
  CommonDropDownResponse(id: 3, description: "English", key: "en"),
  CommonDropDownResponse(id: 4, description: "Tamil", key: "ta"),
  CommonDropDownResponse(id: 5, description: "Hindi", key: "hin"),
  CommonDropDownResponse(id: 6, description: "Japanese", key: "jap"),
  CommonDropDownResponse(id: 7, description: "French", key: "chi"),
  CommonDropDownResponse(id: 8, description: "German", key: "ger"),
]);

final List<CommonDropDownResponse> kReligionList = List.unmodifiable([
  CommonDropDownResponse(id: 1, description: "Buddhism", key: "buddhism"),
  CommonDropDownResponse(id: 2, description: "Hindu", key: "hindu"),
  CommonDropDownResponse(id: 3, description: "Islamic", key: "muslim"),
  CommonDropDownResponse(id: 4, description: "Moor", key: "moor"),
  CommonDropDownResponse(
      id: 5, description: "Roman Catholic", key: "roCatholic"),
  CommonDropDownResponse(id: 6, description: "Other", key: "other"),
]);

final List<CommonDropDownResponse> kFieldOfEmployment = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Banking & Finance", key: "BankingAndFinance"),
  CommonDropDownResponse(
      id: 2, description: "Medical & Healthcare", key: "MedicalAndHealthcare"),
  CommonDropDownResponse(
      id: 3,
      description: "Information Technology",
      key: "BusinessTransactions"),
  CommonDropDownResponse(id: 4, description: "Legal", key: "Legal"),
  CommonDropDownResponse(id: 5, description: "Other", key: "Other"),
]);

final List<CommonDropDownResponse> kMonthlyIncome = List.unmodifiable([
  CommonDropDownResponse(id: 1, description: "<50,000", key: "Income1"),
  CommonDropDownResponse(
      id: 2, description: "50,000 – 100,000", key: "Income2"),
  CommonDropDownResponse(
      id: 3, description: "100,001 – 200,000", key: "Income3"),
  CommonDropDownResponse(
      id: 4, description: "200,001 – 300,000", key: "Income4"),
  CommonDropDownResponse(
      id: 5, description: "300,001 – 600,000", key: "Income5"),
  CommonDropDownResponse(id: 6, description: "600,001 < Above", key: "Income6"),
]);

final List<CommonDropDownResponse> kCustomerType = List.unmodifiable([
  CommonDropDownResponse(id: 1, description: "Salaries", key: "Salaries"),
  CommonDropDownResponse(
      id: 2, description: "Self-Employed", key: "SelfEmployed"),
  CommonDropDownResponse(id: 3, description: "Unemployed", key: "Unemployed"),
]);

final List<CommonDropDownResponse> kAccountPurpose = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Business Transactions", key: "BusinessTransactions"),
  CommonDropDownResponse(
      id: 2, description: "Investment purpose", key: "InvestmentPurpos"),
  CommonDropDownResponse(id: 3, description: "Savings", key: "Savings"),
  CommonDropDownResponse(
      id: 4,
      description: "Employment/Professional Income",
      key: "EmploymentIncome"),
  CommonDropDownResponse(
      id: 5,
      description: "Social and Charity work",
      key: "SocialAndCharityWork"),
  CommonDropDownResponse(id: 6, description: "Other", key: "Other"),
]);

final List<CommonDropDownResponse> kSourceOfFunds = List.unmodifiable([
  CommonDropDownResponse(
      id: 1, description: "Savings Income", key: "SavingsIncome"),
  CommonDropDownResponse(id: 2, description: "Savings", key: "Savings"),
  CommonDropDownResponse(
      id: 3, description: "Business Profit", key: "BusinessProfit"),
  CommonDropDownResponse(id: 4, description: "Remittances", key: "Remittances"),
  CommonDropDownResponse(
      id: 5, description: "Donation/ Charity", key: "DonationCharity"),
  CommonDropDownResponse(
      id: 6, description: "Commission Income", key: "CommissionIncome"),
  CommonDropDownResponse(
      id: 7,
      description: "Interest/ Income from Investments",
      key: "EmploymentIncome"),
  CommonDropDownResponse(
      id: 8, description: "Sales of Assets", key: "SalesOfAssets"),
  CommonDropDownResponse(id: 9, description: "Others", key: "Others")
]);

final List<CommonDropDownResponse> kTransactionMode = List.unmodifiable([
  CommonDropDownResponse(id: 1, description: "Bill Payments"),
  CommonDropDownResponse(id: 2, description: "QR Payments"),
  CommonDropDownResponse(id: 3, description: "P2P Payments"),
]);

List<CommonDropDownResponse> kBillerCategoryList = [];
List<CommonDropDownResponse> kBillerList = [];

const basicAuthUsername = 'mobile';
const basicAuthPassword = 'pin';

class AppConstants {
  static bool IS_USER_LOGGED = false;
  static String BIOMETRIC_CODE;
  static bool Notification_selected_view = false;
  static DateTime TOKEN_EXPIRE_TIME;
}
