import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_gradient_icon.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CdbOnBoardingButton extends StatelessWidget {
  const CdbOnBoardingButton(
      {Key key,
      this.height = 43,
      this.width = double.maxFinite,
      this.mainButtonText,
      this.internalButtonHeight = 25,
      this.internalButtonWidth = 25,
      this.icon,
      this.iconSize = 18,
      this.gradient,
      this.textColor,
      this.onTap})
      : super(key: key);

  final double height;
  final double width;
  final String mainButtonText;
  final double internalButtonHeight;
  final double internalButtonWidth;
  final IconData icon;
  final double iconSize;
  final Gradient gradient;
  final Color textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return CDBBorderGradientButton(
      onTap: onTap,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: textColor.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]),
      width: width,
      height: height.w,
      gradient: gradient,
      child: Padding(
        padding: EdgeInsets.only(left: 13.w, right: 13.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mainButtonText,
              style: AppStyling.normal400Size14.copyWith(color: textColor),
            ),
            CDBBorderGradientButton(
              height: internalButtonHeight.w,
              width: internalButtonWidth.w,
              gradient: gradient,
              child: Center(
                child: CdbGradientIcon(
                  icon: icon,
                  size: iconSize.w,
                  gradient: gradient,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CdbOnBoardingPrefixButton extends StatelessWidget {
  const CdbOnBoardingPrefixButton(
      {Key key,
      this.height = 43,
      this.width = double.maxFinite,
      this.mainButtonText,
      this.internalButtonHeight = 25,
      this.internalButtonWidth = 25,
      this.image,
      this.icon,
      this.iconSize = 18,
      this.gradient,
      this.textColor,
      this.onTap})
      : super(key: key);

  final double height;
  final double width;
  final String mainButtonText;
  final double internalButtonHeight;
  final double internalButtonWidth;
  final Image image;
  final IconData icon;
  final double iconSize;
  final Gradient gradient;
  final Color textColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return CDBBorderGradientButton(
      onTap: onTap,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: textColor.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]),
      width: width,
      height: height.w,
      gradient: gradient,
      child: Padding(
        padding: EdgeInsets.only(left: 13.w, right: 13.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: SizedBox(
                width: 30.w,
                  child: image),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              mainButtonText,
              style: AppStyling.normal400Size14.copyWith(color: textColor),
            ),
            const Spacer(
              flex: 12,
            ),
            CDBBorderGradientButton(
              height: internalButtonHeight.w,
              width: internalButtonWidth.w,
              gradient: gradient,
              child: Center(
                child: CdbGradientIcon(
                  icon: icon,
                  size: iconSize.w,
                  gradient: gradient,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
