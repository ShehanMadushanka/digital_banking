import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_images.dart';

class ProfileImageComponent extends StatelessWidget {
  final String imageURL;
  final VoidCallback onTap;

  const ProfileImageComponent({Key key, this.imageURL, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: imageURL != null
                      ? AppColors.whiteColor
                      : AppColors.separationLinesColor,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Center(
                  child: (imageURL != null)
                      ? CircleAvatar(
                          backgroundColor: AppColors.blackColor,
                          radius: 102,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(imageURL),
                          ),
                        )
                      : SvgPicture.asset(
                          AppImages.documentSelfieIcon,
                        ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: const CircleAvatar(
              backgroundColor: AppColors.blackColor,
              radius: 13,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.separationLinesColor,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
