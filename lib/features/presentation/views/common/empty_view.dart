import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_extensions.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/enums.dart';

class CDBEmptyView extends StatefulWidget {
  final EmptyViewType type;

  const CDBEmptyView({Key key, this.type}) : super(key: key);

  @override
  _CDBEmptyViewState createState() => _CDBEmptyViewState();
}

class _CDBEmptyViewState extends State<CDBEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Color(0x1A000000), blurRadius: 20),
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              SvgPicture.asset(
                widget.type.getIcon(),
                fit: BoxFit.scaleDown,
              ),
              Text(
                widget.type.getTitle(),
                style: AppStyling.normal600Size16.copyWith(
                  color: AppColors.textDarkColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.type.getDescription(),
                style: AppStyling.light300Size13.copyWith(
                  color: AppColors.textTitleColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
