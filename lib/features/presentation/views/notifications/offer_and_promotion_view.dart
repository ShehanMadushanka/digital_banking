import 'package:cdb_mobile/features/presentation/views/notifications/notification_widget/offer_promotion_share_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:flutter/material.dart';

class OfferAndPromotionView extends StatefulWidget {
  const OfferAndPromotionView({Key key}) : super(key: key);

  @override
  _OfferAndPromotionViewState createState() => _OfferAndPromotionViewState();
}

class _OfferAndPromotionViewState extends State<OfferAndPromotionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.offerAndPromotions.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.offerPromotion,
            fit: BoxFit.fitWidth,
            height: 238,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text(
              AppString.offerPromotionsHeadline.localize(context),
              style: AppStyling.normal500Size20
                  .copyWith(color: AppColors.textDarkColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text(
              AppString.offerPromotionsDesc.localize(context),
              style: AppStyling.normal300Size15
                  .copyWith(color: AppColors.textTitleColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
            child: Text(
              AppString.offerPromotionsDate.localize(context),
              style: AppStyling.normal600Size16
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 86),
                child: OfferPromotionShareButton(
                  icon: CDBIcons.ic_share,
                  title: AppString.buttonShare.localize(context),
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
