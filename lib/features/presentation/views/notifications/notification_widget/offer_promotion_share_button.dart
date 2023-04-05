import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferPromotionShareButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const OfferPromotionShareButton({this.title = '', this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.accentColor),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(9),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null)
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, top: 10, bottom: 10),
                    child: Icon(
                      icon,
                      size: 16.h,
                      color: AppColors.accentColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10.25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Text(
                      title,
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.accentColor),
                    ),
                  ),
                ],
              )
            else
              const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
