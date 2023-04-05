import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';

class TextGradient extends StatelessWidget {
  const TextGradient({Key key, this.textHere, this.textStyle})
      : super(key: key);

  final String textHere;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => AppColors.outlineGradient.createShader(rect),
      child: Text(
        textHere,
        style: textStyle,
      ),
    );
  }
}