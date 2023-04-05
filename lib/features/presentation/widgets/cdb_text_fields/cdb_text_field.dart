import 'package:cdb_mobile/utils/app_validator.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_styling.dart';

class CdbCustomTextField extends StatefulWidget {
  CdbCustomTextField({
    Key key,
    this.labelText,
    this.suffixIcon,
    this.onChange,
    this.maxLength = 30,
    this.inputFormatter = null,
    this.isObscureText = false,
    this.textInputType = TextInputType.text,
    this.hintText,
    this.initialValue,
    this.isCurrency = false,
    this.validator,
    this.fontStyle,
    this.prefixIcon,
    this.isEnabled,
    this.showCurrencySymbol = true
  }) : super(key: key);

  final String labelText;
  final Widget suffixIcon;
  final Function onChange;
  final bool isObscureText;
  final TextInputType textInputType;
  final int maxLength;
  final String hintText;
  final String initialValue;
  final bool isCurrency;
  final Function validator;
  final Widget prefixIcon;
  TextStyle fontStyle;
  final List<TextInputFormatter> inputFormatter;
  final bool isEnabled;
  final bool showCurrencySymbol;


  @override
  _CdbCustomTextFieldState createState() => _CdbCustomTextFieldState();
}

class _CdbCustomTextFieldState extends State<CdbCustomTextField> {
  TextStyle labelStyle = AppStyling.normal500Size16.copyWith(
    color: AppColors.textDarkColor,
  );
  FocusNode _focusNode;
  TextEditingController textEditingController = TextEditingController();
  MoneyMaskedTextController _moneyMaskedTextController;

  @override
  void initState() {
    super.initState();
    init();
    widget.fontStyle ??= AppStyling.normal500Size16.copyWith(
      color: AppColors.textDarkColor,
    );

    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    textEditingController.addListener(_onTextChange);
    if (widget.isCurrency) {
      _moneyMaskedTextController = MoneyMaskedTextController(
          decimalSeparator: '.',
          thousandSeparator: ',',
          initialValue: widget.initialValue == null
              ? null
              : double.parse(widget.initialValue.replaceAll(",", "")));
      _moneyMaskedTextController.addListener(_onTextChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(() {});
    _focusNode.dispose();
    textEditingController.removeListener(() {});
    textEditingController.dispose();
    if (_moneyMaskedTextController != null) {
      _moneyMaskedTextController.removeListener(() {});
      _moneyMaskedTextController.dispose();
    }
  }

  void init() {
    if (widget.initialValue != null) {
      textEditingController.text = widget.initialValue;
      labelStyle = AppStyling.normal400Size14.copyWith(
        color: AppColors.textTitleColor,
      );
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        labelStyle = AppStyling.normal400Size14.copyWith(
          color: AppColors.primaryColor,
        );
      });
    } else {
      setState(() {
        labelStyle = AppStyling.normal400Size14.copyWith(
          color: AppColors.textTitleColor,
        );
      });
    }
  }

  void _onTextChange() {
    if (widget.isCurrency) {
      if ((_moneyMaskedTextController.text == null ||
              _moneyMaskedTextController.text == "") &&
          _focusNode.hasFocus) {
        setState(() {
          labelStyle = AppStyling.normal400Size14.copyWith(
            color: AppColors.primaryColor,
          );
        });
      }

      if ((_moneyMaskedTextController.text == null ||
              _moneyMaskedTextController.text == "") &&
          !_focusNode.hasFocus) {
        setState(() {
          labelStyle = AppStyling.normal500Size16.copyWith(
            color: AppColors.textDarkColor,
          );
        });
      }

      if ((_moneyMaskedTextController.text != null ||
              _moneyMaskedTextController.text != "") &&
          _focusNode.hasFocus) {
        setState(() {
          labelStyle = AppStyling.normal400Size14.copyWith(
            color: AppColors.primaryColor,
          );
        });
      }
    } else {
      if ((textEditingController.text == null ||
              textEditingController.text == "") &&
          _focusNode.hasFocus) {
        setState(() {
          labelStyle = AppStyling.normal400Size14.copyWith(
            color: AppColors.primaryColor,
          );
        });
      }

      if ((textEditingController.text == null ||
              textEditingController.text == "") &&
          !_focusNode.hasFocus) {
        setState(() {
          labelStyle = AppStyling.normal500Size16.copyWith(
            color: AppColors.textDarkColor,
          );
        });
      }

      if ((textEditingController.text != null ||
              textEditingController.text != "") &&
          _focusNode.hasFocus) {
        setState(() {
          labelStyle = AppStyling.normal400Size14.copyWith(
            color: AppColors.primaryColor,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      onChanged: widget.onChange,
      focusNode: _focusNode,
      cursorColor: AppColors.blackColor,
      validator: widget.validator,
      maxLength: widget.maxLength,
      controller: widget.isCurrency
          ? _moneyMaskedTextController
          : textEditingController,
      obscureText: widget.isObscureText,
      keyboardType: widget.textInputType,
      inputFormatters:[
        if(widget.inputFormatter!=null)
          ...widget.inputFormatter,
        FilteringTextInputFormatter.deny(
          RegExp(AppValidator().emojiRegexp),
        ),
      ],
      decoration: InputDecoration(
        prefix: widget.isCurrency
            ? _focusNode.hasFocus
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      widget.showCurrencySymbol?
                      "LKR":"",
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.textTitleColor),
                    ),
                  )
                : _moneyMaskedTextController.text != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          widget.showCurrencySymbol?
                          "LKR":"",
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                      )
                    : null
            : null,
        counterText: "",
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText ?? "",
        labelStyle: labelStyle,
        hintStyle: AppStyling.normal400Size14.copyWith(
          color: AppColors.textLightColor,
        ),
        hintText: widget.hintText,
        floatingLabelBehavior: widget.hintText != null
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textFieldBottomBorderEnabled,
            width: kTextFieldBottomBorderHeight,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: kTextFieldBottomBorderHeight,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textFieldBottomBorderEnabled,
            width: kTextFieldBottomBorderHeight,
          ),
        ),
        errorStyle:
            AppStyling.normal400Size14.copyWith(color: AppColors.accentColor),
      ),
      style: widget.fontStyle,
      // style: AppStyling.normal500Size16.copyWith(
      //   color: AppColors.textDarkColor,
      // ),
    );
  }
}
