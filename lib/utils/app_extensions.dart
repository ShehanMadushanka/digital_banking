import 'dart:convert';

import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

import 'app_images.dart';
import 'app_strings.dart';
import 'enums.dart';
import 'navigation_routes.dart';

extension SHA1Ext on String {
  String getSHA1() {
    return sha1.convert(utf8.encode(this)).toString();
  }

  String capitalized() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension DeviceOSExt on DeviceOS {
  String getValue() {
    if (this == DeviceOS.ANDROID) {
      return "Android";
    } else {
      return "Huawei";
    }
  }
}

extension Base64Convert on String {
  String toBase64() {
    final str = this;
    final bytes = utf8.encode(str);
    final base64Str = base64.encode(bytes);
    return base64Str;
  }

  String base64ToString() {
    final base64Str = this;
    final bytes = base64.decode(base64Str);
    final str = utf8.decode(bytes);
    return str;
  }
}

extension DropDownKeyValues on String {
  String getTitle() {
    final String titleValue = this;
    for (final title in kTitleList) {
      if (titleValue == title.description) {
        return title.key;
      }
    }
    return "n/a";
  }

  String getLanguage() {
    final String languageValue = this;
    for (final language in kLanguageList) {
      if (languageValue == language.description) {
        return language.key;
      }
    }
    return "n/a";
  }

  String getReligion() {
    final String religionValue = this;
    for (final religion in kReligionList) {
      if (religionValue == religion.description) {
        return religion.key;
      }
    }
    return "n/a";
  }

  String getFieldOfEmployment() {
    final String fieldOfEmp = this;
    for (final emp in kFieldOfEmployment) {
      if (fieldOfEmp == emp.description) {
        return emp.key;
      }
    }
    return "n/a";
  }

  String getMonthlyIncome() {
    final String income = this;
    for (final monthlyIncome in kMonthlyIncome) {
      if (income == monthlyIncome.description) {
        return monthlyIncome.key;
      }
    }
    return "n/a";
  }

  String getCustomerType() {
    final String customerType = this;
    for (final type in kCustomerType) {
      if (customerType == type.description) {
        return type.key;
      }
    }
    return "n/a";
  }

  String getAccountPurpose() {
    final String purpose = this;
    for (final accPurpose in kAccountPurpose) {
      if (purpose == accPurpose.description) {
        return accPurpose.key;
      }
    }
    return "n/a";
  }

  String getSourceOfFunds() {
    final String funds = this;
    for (final sourceFunds in kSourceOfFunds) {
      if (funds == sourceFunds.description) {
        return sourceFunds.key;
      }
    }
    return "n/a";
  }

  String getTransactionMode() {
    final String mode = this;
    for (final transMode in kTransactionMode) {
      if (mode == transMode.description) {
        return transMode.key;
      }
    }
    return "n/a";
  }
}

extension EmptyViewTypeExt on EmptyViewType {
  String getIcon() {
    switch (this) {
      case EmptyViewType.MYFAVOURITE:
        return AppImages.icEmptyFavouriteBillers;
      case EmptyViewType.RECENTTRANSACTIONS:
        return AppImages.icEmptyTransactions;
      case EmptyViewType.BILLER_LIST:
        return AppImages.icEmptyBillers;
      case EmptyViewType.ACCOUNT:
        return AppImages.icEmptyBillers;
      case EmptyViewType.NO_RESULTS:
        return AppImages.icEmptyTransactionHistory;
      case EmptyViewType.NO_ONGOING_SCHEDULES:
        return AppImages.icEmptyOngoing;
      case EmptyViewType.NO_UPCOMING_SCHEDULES:
        return AppImages.icEmptyUpcoming;
      case EmptyViewType.NO_COMPLETED_SCHEDULES:
        return AppImages.icEmptyCompleted;
      case EmptyViewType.NO_DELETED_SCHEDULES:
        return AppImages.icEmptyDelete;
    }
  }

  String getTitle() {
    switch (this) {
      case EmptyViewType.MYFAVOURITE:
        return 'No Favourite Billers Yet';
      case EmptyViewType.RECENTTRANSACTIONS:
        return 'No Transaction Data Yet';
      case EmptyViewType.BILLER_LIST:
        return 'No Saved Billers';
      case EmptyViewType.ACCOUNT:
        return 'No Accounts';
      case EmptyViewType.NO_RESULTS:
        return 'Sorry, No Result Found.';
      case EmptyViewType.NO_ONGOING_SCHEDULES:
        return 'No Ongoing Schedules';
      case EmptyViewType.NO_UPCOMING_SCHEDULES:
        return 'No Upcoming Schedules';
      case EmptyViewType.NO_COMPLETED_SCHEDULES:
        return 'No Completed Schedules';
      case EmptyViewType.NO_DELETED_SCHEDULES:
        return 'No Deleted Schedules';
    }
  }

  String getDescription() {
    switch (this) {
      case EmptyViewType.MYFAVOURITE:
        return 'You haven’t saved any biller as favourites.';
      case EmptyViewType.RECENTTRANSACTIONS:
        return 'You haven’t been using your account recently.';
      case EmptyViewType.BILLER_LIST:
        return "You haven’t created any biller.\nPlease select ‘ + ‘ to add a biller.";
      case EmptyViewType.ACCOUNT:
        return "You haven’t added any account yet.";
      case EmptyViewType.NO_RESULTS:
        return "Adjust your filters and try again";
      case EmptyViewType.NO_ONGOING_SCHEDULES:
        return "There are no ongoing schedules available.";
      case EmptyViewType.NO_UPCOMING_SCHEDULES:
        return "There are no upcoming schedules available.";
      case EmptyViewType.NO_COMPLETED_SCHEDULES:
        return "There are no completed schedules available.";
      case EmptyViewType.NO_DELETED_SCHEDULES:
        return "There are no deleted schedules available.";
    }
  }
}

extension KYCStepsExt on KYCStep {
  String getLabel(BuildContext context) {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return AppString.personalInformation.localize(context);
      case KYCStep.CONTACTINFO:
        return AppString.contactInfo.localize(context);
      case KYCStep.EMPDETAILS:
        return AppString.empDetails.localize(context);
      case KYCStep.OTHERINFO:
        return 'Other Information';
      case KYCStep.DOCUMENTVERIFY:
        return 'Document Verification';
      case KYCStep.SCHEDULEVERIFY:
        return 'Schedule Verification';
      case KYCStep.REVIEW:
        return 'Review Details';
      case KYCStep.TNC:
        return 'Terms and Conditions';
      default:
        return "";
    }
  }

  String getNavigationRouteName() {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return Routes.kPersonalInformationView;
      case KYCStep.CONTACTINFO:
        return Routes.kContactInformation;
      case KYCStep.EMPDETAILS:
        return Routes.kEmploymentDetail;
      case KYCStep.OTHERINFO:
        return Routes.kUserOtherInfoView;
      case KYCStep.DOCUMENTVERIFY:
        return Routes.kDocumentVerificationView;
      case KYCStep.SCHEDULEVERIFY:
        return Routes.kScheduleVerificationView;
      case KYCStep.REVIEW:
        return Routes.kReviewView;
      case KYCStep.TNC:
        return Routes.kTermsAndConditionsView;
      case KYCStep.BIOMETRIC:
        return Routes.kBioMetricInformation;
      case KYCStep.SECURITYQ:
        return Routes.kSecurityQuestionsView;
      case KYCStep.INTERSTEDPROD:
        return Routes.kOtherProducts;
      case KYCStep.CREATEUSER:
        return Routes.kCreateProfileView;
      default:
        return "";
    }
  }

  int getStep() {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return 1;
      case KYCStep.CONTACTINFO:
        return 2;
      case KYCStep.EMPDETAILS:
        return 3;
      case KYCStep.OTHERINFO:
        return 4;
      case KYCStep.DOCUMENTVERIFY:
        return 5;
      case KYCStep.SCHEDULEVERIFY:
        return 11;
      case KYCStep.REVIEW:
        return 6;
      case KYCStep.TNC:
        return 0;
      case KYCStep.BIOMETRIC:
        return 10;
      case KYCStep.SECURITYQ:
        return 8;
      case KYCStep.INTERSTEDPROD:
        return 7;
      case KYCStep.CREATEUSER:
        return 9;
      default:
        return 0;
    }
  }

  String getStepIcon() {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return AppImages.appbarUserIcon;
      case KYCStep.CONTACTINFO:
        return AppImages.appbarContactInfoIcon;
      case KYCStep.EMPDETAILS:
        return AppImages.appbarEmpDetailsIcon;
      case KYCStep.OTHERINFO:
        return AppImages.appbarOtherInfoIcon;
      case KYCStep.DOCUMENTVERIFY:
        return AppImages.appbarDocumentVerifyIcon;
      case KYCStep.SCHEDULEVERIFY:
        return AppImages.appbarScheduleIcon;
      case KYCStep.REVIEW:
        break;
      case KYCStep.TNC:
        break;
    }
  }

  String getStepperIcon() {
    switch (this) {
      case KYCStep.PERSONALINFO:
        return AppImages.userIcon;
      case KYCStep.CONTACTINFO:
        return AppImages.phoneIcon;
      case KYCStep.EMPDETAILS:
        return AppImages.briefcaseIcon;
      case KYCStep.OTHERINFO:
        return AppImages.singleFileIcon;
      case KYCStep.DOCUMENTVERIFY:
        return AppImages.fileCorrectIcon;
      case KYCStep.SCHEDULEVERIFY:
        return AppImages.clockIcon;
      case KYCStep.REVIEW:
        break;
      case KYCStep.TNC:
        break;
    }
  }
}

extension ButtonStatusExt on ButtonStatus {}
