import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_styling.dart';

class FTSummeryDataComponent extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');

  final String title;
  final String data;
  final String subData;
  final bool isCurrency;
  final double amount;

  FTSummeryDataComponent(
      {this.title = '',
      this.data = '',
      this.subData = '',
      this.isCurrency = false,
      this.amount});

  @override
  Widget build(BuildContext context) {
    return ((!isCurrency && data != null) || (isCurrency && amount != null))
        ? Padding(
            padding: const EdgeInsets.only(
              left: kLeftRightMarginOnBoarding,
              right: kLeftRightMarginOnBoarding,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: title,
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor)),
                          if (isCurrency)
                            TextSpan(
                              text: ' (LKR)',
                              style: AppStyling.normal700Size10
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text(
                                    isCurrency
                                        ? '${formatCurrency.format(amount).split('.')[0]}.'
                                        : data,
                                    textAlign: TextAlign.end,
                                    style: AppStyling.normal500Size16.copyWith(
                                      color: AppColors.textDarkColor,
                                    ),
                                  ),
                                ),
                                if (isCurrency)
                                  TextSpan(
                                      text: formatCurrency
                                          .format(amount)
                                          .split('.')[1],
                                      style: AppStyling.normal400Size14
                                          .copyWith(
                                              color: AppColors.textDarkColor)),
                              ],
                            ),
                          ),
                          if (subData.isNotEmpty)
                            Text(
                              subData,
                              style: AppStyling.normal300Size13
                                  .copyWith(color: AppColors.textDarkColor),
                            )
                          else
                            const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
