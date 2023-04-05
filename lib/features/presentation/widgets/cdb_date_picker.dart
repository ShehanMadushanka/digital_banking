import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CdbDatePicker extends StatefulWidget {
  const CdbDatePicker({Key key, this.onChange, this.labelText, this.initialValue, this.colorOrange = true}) : super(key: key);

  final bool colorOrange;
  final Function onChange;
  final String labelText;
  final String initialValue;

  @override
  _CdbDatePickerState createState() => _CdbDatePickerState();
}

class _CdbDatePickerState extends State<CdbDatePicker> {
  DateTime selectedDate;
  TextStyle labelStyle;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (selectedDate != null) {
      labelStyle = AppStyling.normal400Size14.copyWith(
        color: AppColors.textTitleColor,
      );
    } else {
      labelStyle = AppStyling.normal500Size16.copyWith(
        color: AppColors.textDarkColor,
      );
    }

    if(widget.initialValue != null) {
        textEditingController.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale('en','IN'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1955),
      lastDate: DateTime(3000),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accentColor,
              onPrimary: Colors.white,
              surface: AppColors.primaryColor,
              background: AppColors.accentColor,
              onBackground: AppColors.accentColor,
              secondary: AppColors.accentColor,
              onSecondary: AppColors.accentColor,
              primaryVariant: AppColors.accentColor,
              secondaryVariant: AppColors.accentColor,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.blue[900],
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        labelStyle = AppStyling.normal400Size14.copyWith(
          color: AppColors.textTitleColor,
        );
      });
      selectedDate = picked;
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      final String formattedDate = dateFormat.format(selectedDate);
      widget.onChange(formattedDate);
      textEditingController.text = formattedDate;
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
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: widget.colorOrange == true ? AppColors.accentColor : AppColors.primaryColor,
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
