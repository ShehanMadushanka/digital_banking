import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class CDBBottomSheet {
  final BuildContext context;
  final Function(Widget) onTapItem;
  List<Widget> children;


  CDBBottomSheet.show({@required this.context, @required this.children, this.onTapItem}) {
    _showDialog(context);
  }

  _showDialog(BuildContext context, {String defaultValue}) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (BuildContext context) {
        return _optionInputField(context, defaultValue: defaultValue);
      },
    );
  }

  Widget _optionInputField(BuildContext context, {String defaultValue}) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          color: AppColors.whiteColor,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              const SizedBox(height: 5,),
              Center(child: Container(
                height: 3,
                width: 48,
                decoration: const BoxDecoration(
                    color: AppColors.grayColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: children
                      .map(
                        (item) => InkWell(
                      onTap: () {
                        onTapItem(item);
                        Navigator.pop(context);
                      },
                      child: Container(margin: const EdgeInsets.only(bottom: 8),child: item,),
                    ),
                  )
                      .toList()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
