import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CDBScrollView extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry padding;
  final ScrollController controller;
  final bool primary;
  final ScrollPhysics physics;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String restorationId;
  final bool isInsideMarginAvailable;

  const CDBScrollView({
    Key key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.physics,
    this.controller,
    this.child,
    this.isInsideMarginAvailable = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: AppColors.accentColor,
      radius: const Radius.circular(10.0),
      thickness: 6,
      child: SingleChildScrollView(
        padding: padding,
        physics: physics,
        key: key,
        clipBehavior: clipBehavior,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
        primary: primary,
        restorationId: restorationId,
        reverse: reverse,
        scrollDirection: scrollDirection,
        child: Padding(
          padding: EdgeInsets.only(
            left: isInsideMarginAvailable ? kLeftRightMarginOnBoarding : 0,
            right: isInsideMarginAvailable ? kLeftRightMarginOnBoarding : 0,
          ),
          child: child,
        ),
      ),
    );
  }
}
