import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pre_login_view.dart';

class PreLoginMenuItem extends StatelessWidget {
  final PreLogin menuItem;
  final int index;

  const PreLoginMenuItem({Key key, this.menuItem, this.index})
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
          width: 64,
          height: 64,
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
              width: 36, height: 36, fit: BoxFit.scaleDown),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          menuItem.key,
          style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 13,
              color: AppColors.textDarkColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
