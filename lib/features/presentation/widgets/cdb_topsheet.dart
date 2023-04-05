import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class CDBTopSheet extends StatefulWidget {
  final TopSheetDirection direction;
  final Color backgroundColor;
  final Widget child;

  const CDBTopSheet({this.child, this.direction, this.backgroundColor});

  @override
  _CDBTopSheetState createState() => _CDBTopSheetState();

  static Future<T> show<T extends Object>({@required BuildContext context, @required Widget child, direction = TopSheetDirection.BOTTOM, backgroundColor = const Color(0xb3212121)}) {
    return Navigator.push<T>(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return CDBTopSheet(
                direction: direction,
                backgroundColor: backgroundColor,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.75,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                        color: Colors.white,
                      ),
                      child: SafeArea(
                        bottom: false,
                        left: false,
                        right: false,
                        child: child,
                      ),
                    ),
                  ),
                ),
              );
            },
            opaque: false));
  }
}

class _CDBTopSheetState extends State<CDBTopSheet> with TickerProviderStateMixin {
  Animation<double> _animation;
  Animation<double> _opacityAnimation;
  AnimationController _animationController;

  final _childKey = GlobalKey();

  double get _childHeight {
    final RenderBox renderBox = _childKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  bool get _dismissUnderway => _animationController.status == AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _animation = Tween<double>(begin: _isDirectionTop ? -1 : 1, end: 0).animate(_animationController);

    _opacityAnimation = Tween<double>(begin: 0, end: 0.7).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) Navigator.pop(context);
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;

    final change = details.primaryDelta / (_childHeight ?? details.primaryDelta);
    if (_isDirectionTop) {
      _animationController.value += change;
    } else {
      _animationController.value -= change;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;

    if (details.velocity.pixelsPerSecond.dy > 0 && _isDirectionTop) return;
    if (details.velocity.pixelsPerSecond.dy < 0 && !_isDirectionTop) return;

    if (details.velocity.pixelsPerSecond.dy > 700) {
      final double flingVelocity = -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: flingVelocity);
      }
    } else if (_animationController.value < 0.5) {
      if (_animationController.value > 0.0) {
        _animationController.fling(velocity: -1.0);
      }
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height * 0.75;

    return WillPopScope(
      onWillPop: onBackPressed,
      child: GestureDetector(
        onVerticalDragUpdate: _handleDragUpdate,
        onVerticalDragEnd: _handleDragEnd,
        excludeFromSemantics: true,
        child: AnimatedBuilder(
          animation: _opacityAnimation,
          builder: (context, child) {
            return AnnotatedRegion(
              value: SystemUiOverlayStyle.dark,
              child: Scaffold(
                backgroundColor: widget.backgroundColor.withOpacity(_opacityAnimation.value),
                body: SingleChildScrollView(
                  child: Wrap(
                    key: _childKey,
                    children: <Widget>[
                      if (_isDirectionTop) Container() else const Spacer(),
                      AnimatedBuilder(
                          animation: _animation,
                          builder: (context, _) {
                            return Transform(
                              transform: Matrix4.translationValues(0.0, maxHeight * _animation.value, 0.0),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                                ),
                                width: width,
                                child: widget.child,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool get _isDirectionTop {
    return widget.direction == TopSheetDirection.TOP;
  }

  Future<bool> onBackPressed() {
    _animationController.reverse();
    return Future<bool>.value(false);
  }
}

enum TopSheetDirection { TOP, BOTTOM }
