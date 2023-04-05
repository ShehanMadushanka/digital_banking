import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../domain/entities/response/saved_biller_entity.dart';

class CDBSchedulesBottomAppBar extends StatelessWidget {
  const CDBSchedulesBottomAppBar(
      {Key key,
      this.onTapOne,
      this.onTapTwo,
      this.onTapThree,
      this.onTapFour,
      this.selectedIndex,
      @required this.iconOne,
      @required this.iconTwo,
      @required this.iconThree,
      @required this.iconFour,
      @required this.iconNameOne,
      @required this.iconNameTwo,
      @required this.iconNameThree,
      @required this.iconNameFour,
      this.savedBillerEntity,
      this.status,
      this.onLongPress,
      this.inkWell,
      this.iconPathOne = '',
      this.iconPathThree = '',
      this.iconPathFour = '',
      this.iconPathTwo = ''})
      : super(key: key);

  final Function onTapOne;
  final Function onTapTwo;
  final Function onTapThree;
  final Function onTapFour;
  final int selectedIndex;
  final IconData iconOne;
  final IconData iconTwo;
  final IconData iconThree;
  final IconData iconFour;
  final String iconPathOne;
  final String iconPathTwo;
  final String iconPathThree;
  final String iconPathFour;
  final String iconNameOne;
  final String iconNameTwo;
  final String iconNameThree;
  final String iconNameFour;
  final SavedBillerEntity savedBillerEntity;
  final ButtonStatus status;
  final GestureLongPressCallback onLongPress;
  final bool inkWell;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.separationLinesColor,
      shape: const CircularNotchedRectangle(),
      child: InkWell(
        highlightColor:
            inkWell ? Theme.of(context).highlightColor : Colors.transparent,
        splashColor:
            inkWell ? Theme.of(context).splashColor : Colors.transparent,
        onLongPress: status == ButtonStatus.ENABLE ? onLongPress : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
              child: InkWell(
                onTap: onTapOne,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (iconOne != null)
                      Icon(
                        iconOne,
                        color: AppColors.grayColor,
                      )
                    else
                      SvgPicture.asset(iconPathOne,
                          color: AppColors.textTitleColor),
                    const SizedBox(height: 3),
                    Text(
                      iconNameOne,
                      style: AppStyling.normal500Size10.copyWith(
                        color: AppColors.textTitleColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
              child: InkWell(
                onTap: onTapTwo,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      child: iconTwo != null
                          ? Icon(
                              iconTwo,
                              color: AppColors.grayColor,
                            )
                          : SvgPicture.asset(iconPathTwo,
                              color: AppColors.textTitleColor),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      iconNameTwo,
                      style: AppStyling.normal500Size10.copyWith(
                        color: AppColors.textTitleColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
              child: InkWell(
                onTap: onTapThree,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      child: iconThree != null
                          ? Icon(
                              iconThree,
                              color: AppColors.grayColor,
                            )
                          : SvgPicture.asset(
                              iconPathThree,
                              color: AppColors.textTitleColor,
                            ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      iconNameThree,
                      style: AppStyling.normal500Size10.copyWith(
                        color: AppColors.textTitleColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 5.0),
              child: InkWell(
                onTap: onTapFour,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      child: iconFour != null
                          ? Icon(
                              iconFour,
                              color: AppColors.grayColor,
                            )
                          : SvgPicture.asset(
                              iconPathFour,
                              color: AppColors.textTitleColor,
                            ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      iconNameFour,
                      style: AppStyling.normal500Size10.copyWith(
                        color: AppColors.textTitleColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
