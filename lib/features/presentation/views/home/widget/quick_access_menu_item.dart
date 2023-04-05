import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../home_quick_access_menu_view.dart';

class QuickAccessMenuItem extends StatelessWidget {
  final QuickAccess menuItem;
  final int index;

  const QuickAccessMenuItem({Key key, this.menuItem, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          width: 70.66,
          height: 70.66,
          decoration: BoxDecoration(
            color: const Color(0xB2FFFFFF),
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
            border: Border.all(
              color: const Color(0xFFCDCDCD),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 6,
                color: Color(0x1A000000),
              ),
            ],
          ),
          child: SvgPicture.asset(menuItem.icon,
              width: 43.92, height: 43.92, fit: BoxFit.scaleDown),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          menuItem.key,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.textDarkColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
