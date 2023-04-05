import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../../utils/app_styling.dart';

class MoreProductsCards extends StatelessWidget {
  const MoreProductsCards({Key key, this.productItemName, this.bottomColor})
      : super(key: key);

  final String productItemName;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.2,
            blurRadius: 7, // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.cdbBankLogo,
                      fit: BoxFit.scaleDown,
                      height: MediaQuery.of(context).size.width / 18),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    productItemName,
                    style: AppStyling.normal500Size16
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 100,
              decoration: BoxDecoration(
                color: bottomColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreProductsCardsModel {
  String productName;
  Color setColor;
 // List<Color> colors = [AppColors.accentColor, AppColors.grayColor, AppColors.primaryColor];

  MoreProductsCardsModel({this.productName, this.setColor});
}

List<MoreProductsCardsModel> cdbMoreProducts = <MoreProductsCardsModel>[
  MoreProductsCardsModel(productName: 'Fixed Deposits', setColor: AppColors.accentColor),
  MoreProductsCardsModel(productName: 'Savings', setColor: AppColors.grayColor),
  MoreProductsCardsModel(productName: 'Loans', setColor: AppColors.primaryColor),
];
