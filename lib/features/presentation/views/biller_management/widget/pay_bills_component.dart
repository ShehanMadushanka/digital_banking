import 'package:cdb_mobile/features/domain/entities/response/biller_category_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class PayBillsComponent extends StatelessWidget {
  final BillerCategoryEntity billerCategoryEntity;
  final VoidCallback onTap;

  const PayBillsComponent({this.billerCategoryEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      billerCategoryEntity.categoryName,
                      style: AppStyling.normal600Size14
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.navigate_next,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
