import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/promo_and_offers_category_entity.dart';

class PromoCategories extends StatefulWidget {
  final PromoAndOffersCategoryEntity offerDetails;
  const PromoCategories(this.offerDetails);
  @override
  State<PromoCategories> createState() => _PromoCategoriesState();
}

class _PromoCategoriesState extends State<PromoCategories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.offerDetails.isSelected == true
          ? const EdgeInsets.only(
              right: 12.0,
              top: 23.0,
              bottom: 23.0,
            )
          : const EdgeInsets.only(
              right: 12.0,
              top: 25.0,
              bottom: 25.0,
            ),
      child: Container(
        decoration: widget.offerDetails.isSelected
            ? BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentColor.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColors.accentColor,
                ),
              )
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColors.grayColor,
                ),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (widget.offerDetails.isSelected)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 9.0, horizontal: 17.0),
                    child: SvgPicture.asset(
                      widget.offerDetails.image,
                      color: AppColors.accentColor,
                      height: 40.0,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 9.0, horizontal: 17.0),
                    child: SvgPicture.asset(
                      widget.offerDetails.image,
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.offerDetails.isSelected)
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          widget.offerDetails.label,
                          style: AppStyling.normal500Size16.copyWith(
                            color: AppColors.accentColor,
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          widget.offerDetails.label,
                          style: AppStyling.normal500Size12,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
