import 'package:cdb_mobile/features/domain/entities/response/payee_management_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/account_entity.dart';

class PayeeManagementComponent extends StatelessWidget {
  final VoidCallback onTap;
  final PayeeManagementEntity payeeManagementEntity;

  const PayeeManagementComponent({
    this.onTap,
    this.payeeManagementEntity,
  });

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
                  payeeManagementEntity.payeeManagementTitle,
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ),
              Wrap(children: const [
                Icon(
                  Icons.navigate_next,
                  color: AppColors.primaryColor,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
