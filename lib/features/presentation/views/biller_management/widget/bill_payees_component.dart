import 'package:cdb_mobile/features/domain/entities/response/biller_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class BillPayeesComponent extends StatelessWidget {
  final BillerEntity billerEntity;
  final VoidCallback onTap;

  const BillPayeesComponent({this.billerEntity, this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.network(
                      billerEntity.billerImage,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      billerEntity.billerName,
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
