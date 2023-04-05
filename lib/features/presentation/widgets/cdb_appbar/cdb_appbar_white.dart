import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';

class CDBAppBarWhite extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool goBackEnabled;
  final VoidCallback onBackPressed;

  CDBAppBarWhite(
      {this.title = '',
        this.actions,
        this.goBackEnabled = true,
        this.onBackPressed})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super();

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: AppColors.textDarkColor,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(20)),
      ),
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      actions: actions,
      centerTitle: true,
      leading: goBackEnabled
          ? InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (onBackPressed != null) {
              onBackPressed();
            } else {
              Navigator.pop(context);
            }
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: AppColors.textDarkColor,
          ))
          : const SizedBox.shrink(),
    );
  }
}
