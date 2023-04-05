import 'package:cdb_mobile/features/presentation/views/payee_management/widget/slide_menu.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../domain/entities/response/saved_payee_entity.dart';

class SavedPayeeComponent extends StatelessWidget {
  final SavedPayeeEntity savedPayeeEntity;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  final Function onDeleteItem;
  final bool isDeleteAvailable;

  SavedPayeeComponent(
      {this.savedPayeeEntity,
      this.onTap,
      this.onLongTap,
      this.onDeleteItem,
      this.isDeleteAvailable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
      child: SlideMenu(
        enable: !isDeleteAvailable,
        menuItems: [
          SlideMenuItem(
            child: SvgPicture.asset(AppImages.icTrash),
            onTap: () {
              onDeleteItem();
            },
          ),
        ],
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width:
                    isDeleteAvailable && savedPayeeEntity.isSelected ? 1 : 0.5,
                color: isDeleteAvailable && savedPayeeEntity.isSelected
                    ? AppColors.primaryColor
                    : AppColors.darkAshColor),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (isDeleteAvailable)
                        Row(
                          children: [
                            SvgPicture.asset(savedPayeeEntity.isSelected
                                ? AppImages.icCircleChecked
                                : AppImages.icCircleUnchecked),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        )
                      else
                        const SizedBox.shrink(),
                      Image.network(
                        savedPayeeEntity.payeeImageUrl ?? '',
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
                            savedPayeeEntity.nickName,
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                          Text(
                            savedPayeeEntity.accountNumber,
                            style: AppStyling.normal300Size12
                                .copyWith(color: AppColors.textLightColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Icon(
                    savedPayeeEntity.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
