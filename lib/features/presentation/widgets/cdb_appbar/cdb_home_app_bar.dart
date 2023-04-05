import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styling.dart';

class CDBHomeAppBar extends StatelessWidget {
  const CDBHomeAppBar(
      {Key key,
      @required this.title,
      @required this.imagePath,
      this.username,
      this.notificationCount,
      this.onTapNotification})
      : super(key: key);

  final String title;
  final String imagePath;
  final String username;
  final String notificationCount;
  final VoidCallback onTapNotification;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108.h,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 52.r,
                height: 52.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // child: FadeInImage.memoryNetwork(
                //   placeholder: kTransparentImage,
                //   image: imagePath,
                //   fit: BoxFit.cover,
                // ),
                child: Image.network(imagePath),
              ),
            ),
            SizedBox(
              width: 8.h,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyling.normal700Size18
                      .copyWith(color: AppColors.textDarkColor),
                ),
                Text(
                  username,
                  style: AppStyling.normal500Size16
                      .copyWith(color: AppColors.textDarkColor),
                ),
              ],
            ),
            const Spacer(),
            Stack(
              children: [
                SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: InkWell(
                    onTap: () {
                      if (onTapNotification != null) onTapNotification();
                    },
                    child: SizedBox(
                      width: 25.w,
                      height: 25.w,
                      child: Padding(
                        padding: EdgeInsets.all(6.r),
                        child: const Icon(CDBIcons.vector__4_),
                      ),
                    ),
                  ),
                ),
                if (notificationCount != null || notificationCount != "")
                  Positioned(
                    right: 0,
                    top: 9,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Align(
                        child: Text(
                          notificationCount,
                          style: AppStyling.normal400Size9.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                else
                  Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
