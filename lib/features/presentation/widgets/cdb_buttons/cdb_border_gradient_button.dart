import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CDBBorderGradientButton extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Radius radius;
  final Corners corners;
  final Gradient gradient;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;
  final bool inkWell;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final ValueChanged<bool> onHighlightChanged;
  final ValueChanged<bool> onHover;
  final ValueChanged<bool> onFocusChange;
  final double width;
  final double height;
  final Decoration decoration;
  final ButtonStatus status;
  final Widget child;

  CDBBorderGradientButton({
    Key key,
    this.text,
    this.strokeWidth = 1,
    this.corners,
    this.radius = const Radius.circular(4),
    this.padding = EdgeInsets.zero,
    this.backgroundColor = Colors.transparent,
    this.textColor,
    this.elevation = 0,
    this.inkWell = false,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.width,
    this.height = 43,
    this.onFocusChange,
    this.decoration,
    this.status = ButtonStatus.ENABLE,
    this.gradient,
    this.child,
  })  : assert(padding.isNonNegative),
        assert(elevation >= 0),
        assert(radius == null || corners == null,
            'Cannot provide both a radius and corners.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius br = corners != null
        ? _fromCorners(corners, strokeWidth)
        : _fromRadius(radius ?? Radius.zero, strokeWidth);
    return Material(
      color: backgroundColor,
      elevation: elevation,
      borderRadius: br,
      child: Container(
        decoration: decoration,
        width: width,
        height: height.w,
        child: InkWell(
          borderRadius: br,
          highlightColor:
              inkWell ? Theme.of(context).highlightColor : Colors.transparent,
          splashColor:
              inkWell ? Theme.of(context).splashColor : Colors.transparent,
          onTap: status == ButtonStatus.ENABLE ? onTap : null,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          onFocusChange: onFocusChange,
          child: CustomPaint(
            painter: _Painter(
                gradient ??
                    (status == ButtonStatus.ENABLE
                        ? AppColors.outlineGradient
                        : AppColorsWithOpacity().outlineGradientWithOpacity),
                radius,
                strokeWidth,
                corners),
            child: child ??
                Center(
                  child: Text(
                    text,
                    style: AppStyling.boldTextSize16.copyWith(
                        color: textColor ??
                            (status == ButtonStatus.ENABLE
                                ? AppColors.accentColor
                                : AppColorsWithOpacity()
                                    .accentColorWithOpacity)),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  static BorderRadius _fromCorners(Corners corners, double strokeWidth) {
    return BorderRadius.only(
      topLeft: Radius.elliptical(
          corners.topLeft.x + strokeWidth, corners.topLeft.y + strokeWidth),
      topRight: Radius.elliptical(
          corners.topRight.x + strokeWidth, corners.topRight.y + strokeWidth),
      bottomLeft: Radius.elliptical(corners.bottomLeft.x + strokeWidth,
          corners.bottomLeft.y + strokeWidth),
      bottomRight: Radius.elliptical(corners.bottomRight.x + strokeWidth,
          corners.bottomRight.y + strokeWidth),
    );
  }

  static BorderRadius _fromRadius(Radius radius, double strokeWidth) {
    return BorderRadius.all(
        Radius.elliptical(radius.x + strokeWidth, radius.y + strokeWidth));
  }
}

class _Painter extends CustomPainter {
  final Gradient gradient;
  final Radius radius;
  final double strokeWidth;
  final Corners corners;

  _Painter(this.gradient, this.radius, this.strokeWidth, this.corners);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2,
        size.width - strokeWidth, size.height - strokeWidth);
    final RRect rRect = corners != null
        ? RRect.fromRectAndCorners(
            rect,
            topLeft: corners.topLeft,
            topRight: corners.topRight,
            bottomLeft: corners.bottomLeft,
            bottomRight: corners.bottomRight,
          )
        : RRect.fromRectAndRadius(rect, radius ?? Radius.zero);
    final Paint _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);
    canvas.drawRRect(rRect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class Corners {
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;

  const Corners({
    this.topLeft = Radius.zero,
    this.topRight = Radius.zero,
    this.bottomLeft = Radius.zero,
    this.bottomRight = Radius.zero,
  });
}
