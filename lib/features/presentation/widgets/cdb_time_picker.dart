import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CdbTimePicker extends StatefulWidget {
  const CdbTimePicker(
      {Key key, this.onChange, this.labelText, this.initialValue})
      : super(key: key);

  final Function onChange;
  final String labelText;
  final String initialValue;

  @override
  _CdbTimePickerState createState() => _CdbTimePickerState();
}

class _CdbTimePickerState extends State<CdbTimePicker> {
  TimeOfDay selectedTime;
  TextStyle labelStyle;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (selectedTime != null) {
      labelStyle = AppStyling.normal400Size14.copyWith(
        color: AppColors.textTitleColor,
      );
    } else {
      labelStyle = AppStyling.normal500Size16.copyWith(
        color: AppColors.textDarkColor,
      );
    }

    if (widget.initialValue != null) {
      textEditingController.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accentColor,
              onPrimary: Colors.white,
              surface: AppColors.primaryBackgroundColor,
              /*background: AppColors.accentColor,
              onBackground: AppColors.accentColor,
              secondary: AppColors.accentColor,
              onSecondary: AppColors.accentColor,
              primaryVariant: AppColors.accentColor,
              secondaryVariant: AppColors.accentColor,
              onSurface: Colors.white,*/
            ),
            dialogBackgroundColor: Colors.blue[900],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        labelStyle = AppStyling.normal400Size14.copyWith(
          color: AppColors.textTitleColor,
        );
      });
      selectedTime = picked;
      final DateFormat dateFormat = DateFormat('hh:mm a');
      final String formattedTime = dateFormat.format(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          selectedTime.hour,
          selectedTime.minute));
      widget.onChange(formattedTime);
      textEditingController.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _selectDate(context);
      },
      child: TextFormField(
        enabled: false,
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.access_time,
            color: AppColors.accentColor,
            size: 18,
          ),
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
