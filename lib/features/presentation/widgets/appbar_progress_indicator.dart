import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

const double _kMyLinearProgressIndicatorHeight = 4.0;

class AppBarProgressIndicator extends LinearPercentIndicator implements PreferredSizeWidget {
  AppBarProgressIndicator({
    Key key,
    Color backgroundColor,
    Color progressColor,
    double percent,
    bool animation = true,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          percent: percent,
          progressColor: progressColor,
          padding: EdgeInsets.zero,
          animation: animation,
          linearStrokeCap: LinearStrokeCap.round,
        ) {
    preferredSize = const Size(double.infinity, _kMyLinearProgressIndicatorHeight);
  }

  @override
  Size preferredSize;
}
