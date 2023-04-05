class GoldLoanEntity {
  final String ticketNumber;
  final bool isActive;
  final double outstandingAmount;
  final int loanPeriodsInMonths;
  final String expireDate;
  final String nextTopUpDate;
  final double interestBalance;
  final double maximumAdvanceLimit;
  final double capitalBalance;
  final double remainingAdvanceLimit;
  final bool isTopUpAvailable;
  final List<ArticleDetailItem> articleDetailList;


  GoldLoanEntity(
      {this.ticketNumber,
      this.isActive,
      this.outstandingAmount = 0,
      this.loanPeriodsInMonths,
      this.expireDate,
      this.interestBalance = 0,
      this.maximumAdvanceLimit = 0,
      this.capitalBalance = 0,
      this.articleDetailList,
      this.nextTopUpDate,
      this.isTopUpAvailable = true,
      this.remainingAdvanceLimit = 0,
      });
}

class ArticleDetailItem {
  final String title;
  final String description;

  ArticleDetailItem({this.title = '', this.description = ''});
}
