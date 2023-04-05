import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CdbSearchTextField extends StatelessWidget {
  const CdbSearchTextField(
      {Key key, this.hintText, this.onChange, this.textEditingController})
      : super(key: key);

  final String hintText;
  final Function onChange;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: TextFormField(
        controller: textEditingController,
        onChanged: onChange,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
            RegExp(AppValidator().emojiRegexp),
          ),
        ],
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search_sharp),
          contentPadding: const EdgeInsets.only(left: 20),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          filled: true,
          hintStyle: AppStyling.normal400Size14
              .copyWith(color: AppColors.textLightColor),
          hintText: hintText,
          fillColor: AppColors.lightAshColor,
        ),
      ),
    );
  }
}
