import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CDBMultiItemSelectorData {
  final String label;
  bool isSelected;

  CDBMultiItemSelectorData({this.label, this.isSelected = false});
}

class CDBMultiItemSelector extends StatefulWidget {
  final List<CDBMultiItemSelectorData> dataList;
  final Function(CDBMultiItemSelectorData) selectItem;

  const CDBMultiItemSelector({
    this.dataList,
    this.selectItem,
  });

  @override
  State<CDBMultiItemSelector> createState() => _CDBMultiItemSelectorState();
}

class _CDBMultiItemSelectorState extends State<CDBMultiItemSelector> {
  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.dataList
          .map((item) => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  if (!item.isSelected) {
                    widget.dataList.forEach((element) {
                      element.isSelected = false;
                    });
                    widget.dataList
                        .firstWhere((element) => element.label == item.label)
                        .isSelected = true;

                    widget.selectItem(item);
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  width: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: item.isSelected
                              ? AppColors.accentColor
                              : AppColors.grayColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Align(
                    child: Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: AppStyling.boldTextSize16.copyWith(
                        color: item.isSelected
                            ? AppColors.accentColor
                            : AppColors.grayColor,
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
