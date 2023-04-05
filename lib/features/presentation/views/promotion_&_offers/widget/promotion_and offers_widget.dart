import 'package:cdb_mobile/features/domain/entities/response/promotion_and_offers_entity.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PromotionAndOffersWidget extends StatefulWidget {
  final PromotionAndOffersEntity selectedPromo;
  const PromotionAndOffersWidget({this.selectedPromo});

  @override
  State<PromotionAndOffersWidget> createState() =>
      _PromotionAndOffersWidgetState();
}

class _PromotionAndOffersWidgetState extends State<PromotionAndOffersWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kLeftRightMarginOnBoarding,
        right: kLeftRightMarginOnBoarding,
        bottom: kBottomMargin,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: AspectRatio(
                      aspectRatio: 17 / 7,
                      child: Image.network(
                        widget.selectedPromo.imageURL,
                        fit: BoxFit.fitWidth,
                      )),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      child: Text(
                        widget.selectedPromo.promotionType,
                        style: AppStyling.normal600Size14
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.selectedPromo.title,
                style: AppStyling.normal600Size18,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.selectedPromo.description,
                style: AppStyling.normal400Size16,
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Offer valid till  ",
                    style: AppStyling.normal400Size14
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    widget.selectedPromo.endDate,
                    style: AppStyling.normal700Size16
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
