import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';

class CDBSelectionItem {
  final String title;
  bool isSelected;

  CDBSelectionItem({this.title, this.isSelected = false});
}

class CDBItemSelector extends StatefulWidget {
  List<CDBSelectionItem> items;
  Function(int) onSelectItem;

  CDBItemSelector({@required this.items, this.onSelectItem});

  @override
  _CDBItemSelectorState createState() => _CDBItemSelectorState();
}

class _CDBItemSelectorState extends State<CDBItemSelector> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widget.items
          .map(
            (e) => InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: (){
                setState(() {
                  widget.items.forEach((element) {element.isSelected = false;});
                  widget.items.where((element) => element.title==e.title).first.isSelected = true;
                  widget.onSelectItem(widget.items.indexOf(e));
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 4, right: 4),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: e.isSelected?AppColors.primaryColor:AppColors.separationLinesColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(e.title, style: AppStyling.normal500Size12.copyWith(color: e.isSelected?AppColors.whiteColor:AppColors.darkAshColor),),
              ),
            ),
          )
          .toList(),
    );
  }
}
