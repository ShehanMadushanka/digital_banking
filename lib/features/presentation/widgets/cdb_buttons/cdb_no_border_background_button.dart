import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CDBNoBorderBackgroundButton extends StatelessWidget {
  const CDBNoBorderBackgroundButton({
    Key key,
    this.text,
    this.onTap,
    this.status = ButtonStatus.ENABLE,
  }) : super(key: key);

  final String text;
  final Function onTap;
  final ButtonStatus status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 43,
      child: TextButton(
        onPressed: () {
          if (status == ButtonStatus.ENABLE) onTap();
        },
        child: Text(
          text,
          style: AppStyling.normal400Size16.copyWith(
              color: status == ButtonStatus.ENABLE
                  ? AppColors.textDarkColor
                  : AppColorsWithOpacity().textDarkColorWithOpacity),
        ),
      ),
    );
  }
}
