import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styling.dart';
import '../../../utils/cdb_icons.dart';


class CDBBottomAppBar extends StatelessWidget {
  const CDBBottomAppBar({Key key,@required this.onTap,@required this.selectedIndex}) : super(key: key);

  final Function(int) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.separationLinesColor,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () => onTap(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectedIndex == 0)  Icon(CDBIcons.ic_wallet_selected,size: 25.w) else Icon(CDBIcons.ic_wallet_unselected, size: 25.w),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    AppString.wallet.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () => onTap(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectedIndex == 1) Icon(CDBIcons.ic_portfolio_selected,size: 25.w) else Icon(CDBIcons.briefcase, size: 25.w),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    AppString.portfolio.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.w + 13),
            child: Text(
              AppString.menu.localize(context),
              style: AppStyling.normal500Size10.copyWith(
                color: AppColors.textTitleColor.withOpacity(0.65),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () => onTap(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CDBIcons.vector__1_, size: 25.w),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                   AppString.history.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () => onTap(3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CDBIcons.vector, size: 25.w),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    AppString.settings.localize(context),
                    style: AppStyling.normal500Size10.copyWith(
                      color: AppColors.textTitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
