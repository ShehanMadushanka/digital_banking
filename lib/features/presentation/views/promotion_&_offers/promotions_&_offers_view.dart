import 'package:flutter/material.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../domain/entities/response/promo_and_offers_category_entity.dart';
import '../../../domain/entities/response/promotion_and_offers_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/language/language_bloc.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import 'widget/promotion_and%20offers_widget.dart';
import 'widget/promotion_categories_widget.dart';

List<PromotionAndOffersEntity> selectedPromotionList = [];

class PromotionsOffersView extends BaseView {
  const PromotionsOffersView({Key key}) : super(key: key);
  @override
  State<PromotionsOffersView> createState() => _PromotionsOffersView();
}

class _PromotionsOffersView extends BaseViewState<PromotionsOffersView> {
  final _bloc = inject<LanguageBloc>();

  String promotionType = '';

  //Offer category button list.
  List<PromoAndOffersCategoryEntity> offerCategoryList = [
    PromoAndOffersCategoryEntity(
      isInitialItem: true,
      label: "All Offers",
      image: AppImages.icUnion,
      isSelected: true,
    ),
    PromoAndOffersCategoryEntity(
      label: "Seasonal Offers",
      image: AppImages.icSeasonal,
      promotionGroup: "Seasonal",
    ),
    PromoAndOffersCategoryEntity(
      label: "CC Offers",
      image: AppImages.icCreditCard,
      promotionGroup: "Credit Card",
    ),
    PromoAndOffersCategoryEntity(
      label: "Other Offers",
      image: AppImages.icOther,
      promotionGroup: "Other",
    ),
  ];

  //Mock Data List.
  List<PromotionAndOffersEntity> promotionList = [
    PromotionAndOffersEntity(
      title: "Gall Face Hotel Special Promotion Offer",
      imageURL:
          "https://th.bing.com/th/id/R.f303458acdc3796ebc5e26479c00d6f7?rik=OkfSPPqx0sdaEw&pid=ImgRaw&r=0",
      promotionType: "Seasonal",
      description: "Get a discount of up to 20% at Galle Face Hotel",
      endDate: "21th july 2022",
    ),
    PromotionAndOffersEntity(
      title: "Kapruka.com Special Promotion Offer",
      imageURL:
          "https://www.indy100.com/media-library/the-94-best-online-clothing-stores-in-the-us.jpg?id=28041069&width=1245&quality=85&coordinates=0%2C201%2C0%2C201&height=700",
      promotionType: "Credit Card",
      description: "Get a discount of up to 15% at Kapruka.com ",
      endDate: "21th july 2022",
    ),
    PromotionAndOffersEntity(
      title: "Keels Special Promotion Offer",
      imageURL:
          "https://www.echelon.lk/wp-content/uploads/2020/09/keells-banner-size.jpg",
      promotionType: "Credit Card",
      description: "Get a discount of up to 10% at Keels with CDB. ",
      endDate: "21th july 2022",
    ),
  ];

  @override
  void initState() {
    super.initState();
    //TODO: Should add the List of promotion and offers received from the API in here.
    selectedPromotionList.addAll(promotionList);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.promotionAndOffers.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 100.0,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: kLeftRightMarginOnBoarding,
              ),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: offerCategoryList.length,
              itemBuilder: (BuildContext context, index) {
                final PromoAndOffersCategoryEntity offerDetails =
                    offerCategoryList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      //Used to change the button as a selected button onTap.
                      setSelectedPromotionButton(offerDetails);

                      //Used to set promotion list according to the selected button.
                      setPromotionList(offerDetails);

                      //Used to set the promotion type name according to the selected button.
                      setPromotionName(offerDetails);
                    });
                  },
                  child: PromoCategories(offerDetails),
                );
              },
            ),
          ),
          Expanded(
            child: selectedPromotionList.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: selectedPromotionList.length,
                    itemBuilder: (context, index) {
                      final PromotionAndOffersEntity selectedPromo =
                          selectedPromotionList[index];
                      return GestureDetector(
                        onTap: () {
                          //TODO: Navigate to Offer screen.
                        },
                        child: PromotionAndOffersWidget(
                            selectedPromo: selectedPromo),
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.icNoOffers,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "No Promotion and Offers",
                        style: AppStyling.normal600Size18,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          "No $promotionType Promotion and Offers are Available",
                          style: AppStyling.normal300Size15,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  void setPromotionList(PromoAndOffersCategoryEntity offerDetails) {
    selectedPromotionList.clear();
    if (offerDetails.isInitialItem) {
      selectedPromotionList.addAll(promotionList);
    } else {
      for (final element in promotionList) {
        if (element.promotionType == offerDetails.promotionGroup) {
          selectedPromotionList.add(element);
        }
      }
    }
  }

  void setSelectedPromotionButton(PromoAndOffersCategoryEntity offerDetails) {
    for (final element in offerCategoryList) {
      element.isSelected = false;
    }
    offerDetails.isSelected = true;
  }

  void setPromotionName(PromoAndOffersCategoryEntity offerDetails) {
    if (offerDetails.promotionGroup != null) {
      promotionType = offerDetails.promotionGroup;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
