class SavedPayeeEntity {
  String nickName;
  String accountNumber;
  String payeeImageUrl;
  String accountHolderName;
  String bankName;
  bool isFavorite;
  bool isSelected;

  SavedPayeeEntity(
      {this.nickName,
      this.accountHolderName,
      this.bankName,
      this.payeeImageUrl,
      this.isFavorite = false,
      this.accountNumber,
      this.isSelected = false});
}
