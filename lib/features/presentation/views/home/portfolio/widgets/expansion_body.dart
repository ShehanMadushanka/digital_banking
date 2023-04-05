import 'package:flutter/material.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_styling.dart';

class ExpansionBody extends StatelessWidget {
  const ExpansionBody(
      {Key key,
      this.bodyTitle,
      this.bodySubTitle,
      this.bodyAmount,
      this.bodyBalanceText,
      this.onPressed})
      : super(key: key);

  final String bodyTitle;
  final String bodySubTitle;
  final String bodyAmount;
  final String bodyBalanceText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: expansionData.length,
    //   itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 10.0, top: 5.0),
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bodyTitle,
                    style: AppStyling.normal600Size14
                        .copyWith(color: AppColors.grayColor),
                  ),
                  Text(
                    bodySubTitle,
                    style: AppStyling.normal300Size12
                        .copyWith(color: AppColors.textLightColor),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Column(
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
                      text: bodyAmount,
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
                  bodyBalanceText,
                  style: AppStyling.normal300Size10
                      .copyWith(color: AppColors.textLightColor),
                ),
              ],
            ),
            const Spacer(flex: 1),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.textLightColor,
            ),
          ],
          //   );
          // },
        ),
      ),
    );
  }
}

class ExpansionBodyModel {
  int exId;
  String exTitle;
  String exSubTitle;
  String exAmount;
  String exBalanceText;
  Function onPressed;

  ExpansionBodyModel(
      {this.exId,
      this.exTitle,
      this.exSubTitle,
      this.exAmount,
      this.exBalanceText,
      this.onPressed});
}
