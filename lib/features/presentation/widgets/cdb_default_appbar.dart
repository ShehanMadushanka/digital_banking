import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styling.dart';
import 'appbar_progress_indicator.dart';
import 'cdb_appbar/cdb_appbar.dart';

class CDBMainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback onTapBack;
  final String appBarTitle;
  final List<Widget> actions;

  const CDBMainAppBar({Key key, this.onTapBack, this.appBarTitle, this.actions}) : super(key: key);

  @override
  _CDBMainAppBarState createState() => _CDBMainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

class _CDBMainAppBarState extends State<CDBMainAppBar> {
  @override
  Widget build(BuildContext context) {
    return CDBAppbar(
      title: Text(widget.appBarTitle, style: AppStyling.normal500Size16.copyWith(color: Colors.white)),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: widget.onTapBack,
      ),
      actions: widget.actions,
      bottom: AppBarProgressIndicator(
        backgroundColor: Colors.white.withOpacity(0.25),
        progressColor: AppColors.accentColor,
        animation: false,
        percent: 1,
      ),
    );
  }
}
