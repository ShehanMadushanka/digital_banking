import '../../../../utils/enums.dart';
import 'saved_payee_entity.dart';

class FundTransferEntity {
  ///Fund Transfer Type (Saved, Unsaved or Scheduled)
  final FTType fundTransferType;

  SavedPayeeEntity payTo;
  final int transactionCategoryId;
  String transactionCategory;
  String reference;
  String amount;
  String remark;
  String beneficiaryEmail;
  String beneficiaryMobile;

  String accountNumber;
  String bankName;
  int bankCode;
  String name;

  String scheduleType;
  String scheduleFrequency;
  int scheduleTypeId;
  int scheduleFrequencyId;
  String scheduleTitle;
  String startDate;
  String endDate;
  bool notifyTheBeneficiary;
  String transactionDate;

  FundTransferEntity(
      {this.transactionDate,
      this.fundTransferType,
      this.payTo,
      this.transactionCategoryId,
      this.transactionCategory,
      this.reference,
      this.amount,
      this.remark,
      this.beneficiaryEmail,
      this.beneficiaryMobile,
      this.accountNumber,
      this.bankName,
      this.bankCode,
      this.name,
      this.notifyTheBeneficiary,
      this.scheduleType,
      this.scheduleFrequency,
      this.scheduleTypeId,
      this.scheduleFrequencyId,
      this.scheduleTitle,
      this.startDate,
      this.endDate});
}
