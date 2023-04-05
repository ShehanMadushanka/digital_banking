class PromoAndOffersCategoryEntity {
  final String label;
  bool isSelected;
  final bool isInitialItem;
  final String image;
  final String promotionGroup;

  PromoAndOffersCategoryEntity({
    this.image,
    this.label,
    this.isSelected = false,
    this.isInitialItem = false,
    this.promotionGroup,
  });
}