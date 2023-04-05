class AccountEntity {
  final bool isCDBAccount;
  String nickName;
  final double availableBalance;
  final String accountNumber;
  bool isPrimary;

  AccountEntity(
      {this.isCDBAccount = true,
      this.nickName,
      this.availableBalance = 0,
      this.accountNumber,
      this.isPrimary = false});
}
