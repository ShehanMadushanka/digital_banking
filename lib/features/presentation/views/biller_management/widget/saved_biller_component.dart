import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/saved_biller_entity.dart';

class SavedBillerComponent extends StatelessWidget {
  final SavedBillerEntity savedBillerEntity;
  final VoidCallback onTap;

  const SavedBillerComponent({this.savedBillerEntity, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // margin: const EdgeInsets.only(bottom: 8),  // I removed this one and add this one wrapping the automator
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
                      savedBillerEntity.serviceProvider.billerImage??'',
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          savedBillerEntity.nickName,
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                        Text(
                          savedBillerEntity.customFieldEntityList.isNotEmpty?savedBillerEntity.customFieldEntityList[0].customFieldValue:'',
                          style: AppStyling.normal300Size12
                              .copyWith(color: AppColors.textLightColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    Icon(
                      savedBillerEntity.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.primaryColor,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.navigate_next,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
