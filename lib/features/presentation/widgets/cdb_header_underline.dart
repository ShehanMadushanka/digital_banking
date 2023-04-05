import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';

class CdbHeaderUnderline extends StatelessWidget {
  const CdbHeaderUnderline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 4.h,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
