import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styling.dart';

class CDBFlatButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CDBFlatButton({this.title = '', this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteDark,
            border: Border.all(color: AppColors.lightAshColor),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(9),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              title,
              style: AppStyling.normal400Size14
                  .copyWith(color: AppColors.textDarkColor),
            ),
            if (icon != null)
              Row(
                children:  [
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(icon, size: 16.h,)
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
