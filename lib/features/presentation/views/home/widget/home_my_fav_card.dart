import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_styling.dart';

class HomeMyFavouriteCard extends StatelessWidget {
  const HomeMyFavouriteCard(
      {Key key,
      @required this.title,
      @required this.subTitle,
      @required this.onTap,
      @required this.imageUrl})
      : super(key: key);

  final String title;
  final String subTitle;
  final String imageUrl;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: 163.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.lightAshColor),
          color: AppColors.whiteDark,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 35.w,
              height: 20.h,
              child: Image.network(imageUrl),
            ),
            const SizedBox(
              width: 7,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyling.normal400Size14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subTitle,
                    style: AppStyling.normal300Size13,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
