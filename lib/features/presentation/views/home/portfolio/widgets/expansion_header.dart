import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../../utils/app_styling.dart';
import 'expansion_body.dart';

class ExpansionHeader extends StatelessWidget {
  const ExpansionHeader(
      {Key key,
      this.headerText,
      this.headerAmount,
      this.headerBalanceText,
      this.image})
      : super(key: key);

  final String headerText;
  final String headerAmount;
  final String headerBalanceText;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 50.0,
                height: 46.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 7, // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: image,
                  ),
                  //child: image,
                ),
              ),
            ),
            const SizedBox(
              width: 11.0,
            ),
            Expanded(
              flex: 3,
              child: Text(
                headerText,
                style: AppStyling.normal600Size14
                    .copyWith(color: AppColors.textDarkColor),
              ),
            ),
            //const Spacer(),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'LKR ',
                        style: AppStyling.bold700Size10
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                      TextSpan(
                        text: headerAmount,
                        style: AppStyling.normal500Size16
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                      TextSpan(
                        text: '.00',
                        style: AppStyling.normal500Size10
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                    ]),
                  ),
                  Text(
                    headerBalanceText,
                    style: AppStyling.normal300Size10
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ExpansionHeaderModel {
  int portfolioId;
  Image portfolioImage;
  String portfolioHeader;
  String portfolioAmount;
  String portfolioAmountDecs;
  String portfolioBody;
  bool isExpanded;
  List<ExpansionBodyModel> data;

  ExpansionHeaderModel(
      {this.portfolioId,
      this.portfolioImage,
      this.portfolioHeader,
      this.portfolioAmount,
      this.portfolioAmountDecs,
      this.portfolioBody,
      this.isExpanded = false,
      this.data});
}
