import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

class CdbDropDown extends StatefulWidget {
  const CdbDropDown(
      {Key key, this.initialValue, this.suffixIcon, this.labelText, this.onTap})
      : super(key: key);

  final String initialValue;
  final Widget suffixIcon;
  final String labelText;
  final Function onTap;

  @override
  _CdbDropDownState createState() => _CdbDropDownState();
}

class _CdbDropDownState extends State<CdbDropDown> {
  TextStyle labelStyle;

  @override
  void initState() {
    super.initState();

    labelStyle = widget.initialValue != null
        ? AppStyling.normal400Size14.copyWith(
            color: AppColors.textTitleColor,
          )
        : AppStyling.normal500Size16.copyWith(
            color: AppColors.textDarkColor,
          );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        key: Key(widget.initialValue.toString()),
        initialValue: widget.initialValue,
        enabled: false,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText ?? "",
          labelStyle: labelStyle,
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textFieldBottomBorderEnabled,
              width: kTextFieldBottomBorderHeight,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textFieldBottomBorderEnabled,
              width: kTextFieldBottomBorderHeight,
            ),
          ),
        ),
        style: AppStyling.normal500Size16.copyWith(
          color: AppColors.textDarkColor,
        ),
      ),
    );
  }
}
