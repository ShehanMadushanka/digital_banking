
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CdbInfoIconView extends StatelessWidget {

  const CdbInfoIconView({Key key, this.onTap, this.color}) : super(key: key);

  final Function onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: SvgPicture.asset(AppImages.infoIcon, color: color,),
      ),
    );
  }
}
