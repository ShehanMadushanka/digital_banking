import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

class DropDownListItem extends StatelessWidget {
  const DropDownListItem({Key key, @required this.title, @required this.onTap})
      : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
            left: kLeftRightMarginOnBoarding,
            right: kLeftRightMarginOnBoarding),
        width: double.maxFinite,
        height: 45,
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: kTextFieldBottomBorderHeight,
            color: AppColors.textFieldBottomBorderEnabled,
          ),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                style: AppStyling.normal400Size14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
