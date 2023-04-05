import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/select_account_entity.dart';

class GoldLoanAccount extends StatelessWidget {
  GoldLoanAccount({Key key, this.onTap, this.selectAccountEntity})
      : super(key: key);
  final SelectAccountEntity selectAccountEntity;
  final VoidCallback onTap;
  final formatCurrency = NumberFormat.currency(symbol: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectAccountEntity.accountType ?? '',
                  style: AppStyling.normal500Size20
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  selectAccountEntity.accountNum ?? '',
                  style: AppStyling.normal500Size20
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  AppImages.cdbBankLogo,
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppString.accountBalance.localize(context),
                      style: AppStyling.normal500Size12
                          .copyWith(color: AppColors.textTitleColor),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '(${AppString.lkr.localize(context)})',
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          selectAccountEntity.accountBalance.toString() != null
                              ? selectAccountEntity.accountBalance.toString()
                              : '',
                          style: AppStyling.normal500Size20
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                      ],
                    ),
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
