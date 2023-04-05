import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CDBPostLoginSearchTextField extends StatelessWidget {
  const CDBPostLoginSearchTextField(
      {Key key,
      this.hintText,
      this.controller,
      this.shouldShowCancel = true,
      this.searchIconColor = AppColors.primaryColor})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool shouldShowCancel;
  final Color searchIconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Color(0x1A000000),
              ),
            ]),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: controller,
                textAlign: TextAlign.left,
                cursorColor: AppColors.textDarkColor,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(
                    RegExp(AppValidator().emojiRegexp),
                  ),
                ],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_sharp, color: searchIconColor),
                  contentPadding: const EdgeInsets.only(top: 2),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: AppColors.darkAshColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: AppColors.darkAshColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textLightColor),
                  hintText: hintText,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        if (shouldShowCancel) TextButton(
                onPressed: () {
                  controller.clear();
                },
                child: Text(
                  'Cancel',
                  style: AppStyling.bold600Size14
                      .copyWith(color: AppColors.primaryColor),
                ),
              ) else const SizedBox.shrink(),
        if (controller.text.isEmpty)
          const SizedBox.shrink()
        else
          TextButton(
            onPressed: () {
              controller.clear();
            },
            child: Text(
              'Cancel',
              style: AppStyling.bold600Size14
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
      ],
    );
  }
}
