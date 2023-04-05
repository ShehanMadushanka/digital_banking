import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class ScheduleTypesComponent extends StatelessWidget {
  final VoidCallback onTap;
  final String type;

  const ScheduleTypesComponent({
    this.onTap,
    this.type,
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
                  type,
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
