import 'dart:io';

import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/enums.dart';

class IdCapture extends StatelessWidget {
  final IDType idType;
  final String image;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const IdCapture(
      {Key key, @required this.idType, this.image, this.onTap, this.onDelete})
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
              InkWell(
                onTap: onTap,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: image != null
                        ? AppColors.whiteColor
                        : AppColors.separationLinesColor,
                    border:
                        Border.all(color: AppColors.textLightColor, width: .5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(idType == IDType.SELFIE ? 100 : 3),
                    ),
                  ),
                  child: Center(
                    child: (image != null)
                        ? Padding(
                            padding: EdgeInsets.all(
                                idType == IDType.SELFIE ? 0 : 10.0),
                            child: idType == IDType.SELFIE
                                ? CircleAvatar(
                                    radius: 100,
                                    backgroundImage: FileImage(
                                      File(image),
                                    ),
                                  )
                                : Image.file(
                                    File(image),
                                  ),
                          )
                        : SvgPicture.asset(
                            _proofIcon(),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                _proofDescription(context),
                style: AppStyling.normal500Size16.copyWith(
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
        ),
        if (image != null)
          Positioned(
            top: idType == IDType.SELFIE ? 15 : 0,
            right: idType == IDType.SELFIE ? 15 : 0,
            child: InkWell(
              onTap: onDelete,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: const CircleAvatar(
                backgroundColor: AppColors.accentColor,
                radius: 13,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.whiteColor,
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: AppColors.accentColor,
                  ),
                ),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  String _proofDescription(BuildContext context) {
    switch (idType) {
      case IDType.SELFIE:
        return AppString.dvIdCaptureSelfie.localize(context);
        break;
      case IDType.ID_FRONT:
        return AppString.dvIdCaptureFontID.localize(context);
        break;
      case IDType.ID_BACK:
        return AppString.dvIdCaptureBackID.localize(context);
        break;
      case IDType.BILLING_PROOF:
        return AppString.dvIdCaptureBilling.localize(context);
        break;
    }
  }

  String _proofIcon() {
    switch (idType) {
      case IDType.SELFIE:
        return AppImages.documentSelfieIcon;
        break;
      case IDType.ID_FRONT:
        return AppImages.documentFrontIDIcon;
        break;
      case IDType.ID_BACK:
        return AppImages.documentBackIDIcon;
        break;
      case IDType.BILLING_PROOF:
        return AppImages.documentBillingIcon;
        break;
    }
  }
}
