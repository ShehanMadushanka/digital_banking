import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/gold_loan_entity.dart';

class GoldLoanComponent extends StatelessWidget {
  final GoldLoanEntity goldLoanEntity;
  final VoidCallback onTap;

  final formatCurrency = NumberFormat.currency(symbol: '');

  GoldLoanComponent({this.goldLoanEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: AppColors.darkAshColor),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.ticketNumber.localize(context),
                    style: AppStyling.normal300Size12
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    goldLoanEntity.ticketNumber ?? '',
                    style: AppStyling.normal600Size14
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    label: Text(
                      goldLoanEntity.isActive
                          ? AppString.active.localize(context)
                          : AppString.auction.localize(context),
                      style: AppStyling.normal500Size12
                          .copyWith(color: AppColors.whiteColor),
                    ),
                    backgroundColor: goldLoanEntity.isActive
                        ? AppColors.successGreenColor
                        : AppColors.errorRedColor,
                  )
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            AppString.lkr.localize(context),
                            style: AppStyling.normal300Size10
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${formatCurrency.format(goldLoanEntity.outstandingAmount).split('.')[0]}.',
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.blackColor)),
                              TextSpan(
                                  text: formatCurrency
                                      .format(goldLoanEntity.outstandingAmount)
                                      .split('.')[1],
                                  style: AppStyling.normal300Size13
                                      .copyWith(color: AppColors.blackColor)),
                            ]),
                          ),
                        ],
                      ),
                      Text(
                        AppString.outstandingAmount.localize(context),
                        style: AppStyling.normal300Size12
                            .copyWith(color: AppColors.textDarkColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: AppColors.primaryColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
