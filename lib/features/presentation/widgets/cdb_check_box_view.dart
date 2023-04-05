import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styling.dart';

class CdbCheckBoxView extends StatelessWidget {
  final double width;
  final double height;
  final Function onTap;
  final String label;
  final bool value;

  const CdbCheckBoxView({
    Key key,
     this.width = 16,
    this.height = 16,
    @required this.onTap,
    @required this.label,
    this.value = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black12,
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            value ? AppImages.checkBoxCheckedIcon : AppImages.checkBoxIcon,
            width: width.r,
            height: height.r,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            label,
            style: AppStyling.normal500Size16
                .copyWith(color: AppColors.textTitleColor),
          ),
        ],
      ),
    );
  }
}
