import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class HomeTransactionButton extends StatelessWidget {
  const HomeTransactionButton(
      {Key key,
      @required this.imagePath,
      @required this.onTap,
      @required this.text})
      : super(key: key);

  final String imagePath;
  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.accentColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
          SizedBox(height: 5.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppStyling.normal500Size12.copyWith(
              color: AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
