import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateY }

class SlideInToastMessageAnimation extends StatelessWidget {
  final Widget child;

  const SlideInToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
    // final tween = MultiTrackTween([
    //   Track("translateY")
    //       .add(
    //     Duration(milliseconds: 250),
    //     Tween(begin: -100.0, end: 0.0),
    //     curve: Curves.easeOut,
    //   )
    //       .add(Duration(seconds: 3, milliseconds: 250),
    //       Tween(begin: 0.0, end: 0.0))
    //       .add(Duration(milliseconds: 250),
    //       Tween(begin: 0.0, end: -100.0),
    //       curve: Curves.easeIn),
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500),
    //       Tween(begin: 0.0, end: 1.0))
    //       .add(Duration(seconds: 3),
    //       Tween(begin: 1.0, end: 1.0))
    //       .add(Duration(milliseconds: 500),
    //       Tween(begin: 1.0, end: 0.0)),
    // ]);

    final tween = MultiTween<AniProps>()
      ..add(AniProps.translateY, (-100.0).tweenTo(0.0), 250.milliseconds,
          Curves.easeOut)
      ..add(AniProps.translateY, (0.0).tweenTo(0.0),
          const Duration(seconds: 3, milliseconds: 250))
      ..add(AniProps.translateY, (0.0).tweenTo(-100.0), 250.milliseconds,
          Curves.easeIn)
      ..add(AniProps.opacity, (0.0).tweenTo(1.0), 500.milliseconds)
      ..add(AniProps.translateY, (1.0).tweenTo(1.0), 3.seconds)
      ..add(AniProps.translateY, (1.0).tweenTo(0.0), 500.seconds);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      duration: tween.duration,
      tween: tween,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)),
            child: child),
      ),
      child: child,
    );
  }
}
