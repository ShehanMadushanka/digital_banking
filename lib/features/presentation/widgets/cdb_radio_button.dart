import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cdb_info_icon_view.dart';

class RadioButtonModel {
  String label;
  String value;

  RadioButtonModel({@required this.label, @required this.value});
}

class CdbCustomRadioButton extends StatefulWidget {
  const CdbCustomRadioButton({
    Key key,
    @required this.radioButtonDataList,
    this.isVertical = false,
    this.onChange,
    this.activeColor = AppColors.textDarkColor,
    this.radioLabel,
    this.initialValue,
    this.isInfoIcon = false,
    this.onTapIcon,
    this.widgetInMiddle
  }) : super(key: key);

  final List<RadioButtonModel> radioButtonDataList;
  final bool isVertical;
  final Function onChange;
  final Color activeColor;
  final String radioLabel;
  final String initialValue;
  final bool isInfoIcon;
  final Function onTapIcon;
  final Widget widgetInMiddle;

  @override
  _CdbCustomRadioButtonState createState() => _CdbCustomRadioButtonState();
}

class _CdbCustomRadioButtonState extends State<CdbCustomRadioButton> {
  String id;

  @override
  void initState() {
    if(widget.initialValue != null) {
      id = widget.initialValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.radioLabel,
                style: AppStyling.normal400Size14.copyWith(color: AppColors.textTitleColor),
              ),
            ),
            SizedBox(
              width: 12.w ,
            ),
            if (widget.isInfoIcon)
              CdbInfoIconView(onTap: (){
                widget.onTapIcon();
              }),
          ],
        ),

        _body(),

      ],
    );
  }

  List<Widget> _getMiddleWidgetBody() {
    List<Widget> widgetList = [];
    widget.radioButtonDataList.forEach((element) {
      widgetList.add(RadioButtonData(
        label: element.label,
        groupValue: id,
        value: element.value,
        activeColor: widget.activeColor,
        onChange: (value) {
          setState(() {
            id = value;
          });
          widget.onChange(value);
        },
      ));

      if (element.value == id) {
        widgetList.add(widget.widgetInMiddle);
      }
    });

    return widgetList;
  }

  Widget _body() {
    if (widget.widgetInMiddle != null) {
      return Column(
        children: _getMiddleWidgetBody(),
      );
    } else {
      if (widget.isVertical) {
        return Column(
            children: widget.radioButtonDataList
                .map(
                  (e) => RadioButtonData(
                label: e.label,
                groupValue: id,
                value: e.value,
                activeColor: widget.activeColor,
                onChange: (value) {
                  setState(() {
                    id = value;
                  });
                  widget.onChange(value);
                },
              ),
            )
                .toList());
      } else {
        return Row(
          children: widget.radioButtonDataList
              .map(
                (e) => RadioButtonData(
              label: e.label,
              groupValue: id,
              value: e.value,
              activeColor: widget.activeColor,
              onChange: (value) {
                setState(() {
                  id = value;
                });
                widget.onChange(value);
              },
            ),
          )
              .toList(),
        );
      }
    }
  }
}

class RadioButtonData extends StatelessWidget {
  const RadioButtonData(
      {Key key,
        this.label,
        this.groupValue,
        this.activeColor,
        this.value,
        this.onChange})
      : super(key: key);

  final String label;
  final String groupValue;
  final Color activeColor;
  final String value;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          onChanged: onChange,
          value: value,
          groupValue: groupValue,
          activeColor: activeColor,
        ),
        Text(
          label ?? "",
          style: AppStyling.normal500Size16,
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}
