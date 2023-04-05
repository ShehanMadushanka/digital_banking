import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

import '../../../../../utils/app_styling.dart';

class SelectPayeeComponent extends StatelessWidget {
  final VoidCallback onTap;

  const SelectPayeeComponent({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
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
                  AppString.selectPayee.localize(context),
                  style: AppStyling.normal600Size16
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
