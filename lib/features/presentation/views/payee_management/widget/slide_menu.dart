import '../../../../../utils/app_colors.dart';
import 'package:flutter/material.dart';

class SlideMenuItem {
  final Widget child;
  final VoidCallback onTap;

  SlideMenuItem({this.child, this.onTap});
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final Gradient background;
  final List<SlideMenuItem> menuItems;
  final bool enable;

  SlideMenu(
      {this.child,
      this.menuItems,
      this.enable = true,
      this.background = AppColors.sideButtonGradient});

  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
            .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        if(widget.enable) {
          setState(() {
            _controller.value -= data.primaryDelta / context.size.width;
          });
        }
      },
      onHorizontalDragEnd: (data) {
        if(widget.enable) {
          if (data.primaryVelocity > 2500) {
            _controller.animateTo(.0);
          } else if (_controller.value >= .5 || data.primaryVelocity < -2500) {
            _controller.animateTo(1.0);
          } else {
            _controller.animateTo(.0);
          }
        }
      },
      child: Stack(
        children: <Widget>[
          SlideTransition(position: animation, child: widget.child),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 0.5, color: AppColors.darkAshColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: widget.background,
                                border: Border.all(
                                    width: 0.5, color: AppColors.darkAshColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                              ),
                              child: Row(
                                children: widget.menuItems.map((child) {
                                  return Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          if (child.onTap != null) {
                                            child.onTap();
                                          }
                                        },
                                        child: child.child),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
