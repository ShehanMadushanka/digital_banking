import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/account_entity.dart';

class AccountComponent extends StatelessWidget {
  final AccountEntity accountEntity;
  final VoidCallback onTap;

  const AccountComponent({this.accountEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  accountEntity.nickName,
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ),
              Wrap(
                children: [
                  if (accountEntity.isCDBAccount)
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "LKR ",
                              style: AppStyling.normal500Size8
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                      "${NumberFormat.currency(symbol: '').format(accountEntity.availableBalance).split('.')[0]}.",
                                  style: AppStyling.normal400Size14
                                      .copyWith(color: AppColors.textDarkColor),
                                  children: [
                                    TextSpan(
                                      text: NumberFormat.currency(symbol: '').format(accountEntity.availableBalance).split('.')[1],
                                      style: AppStyling.normal300Size12
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                    )
                                  ]),
                            )
                          ],
                        ),
                        Text(
                          AppString.labelAvailableBalance.localize(context),
                          style: AppStyling.normal300Size10
                              .copyWith(color: AppColors.textDarkColor),
                        )
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                  const SizedBox(
                    width: 35,
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
