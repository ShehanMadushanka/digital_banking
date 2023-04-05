import 'dart:io';
import 'dart:ui';

import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerView extends StatefulWidget {
  @override
  _QRScannerViewState createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  bool isFlashLightOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.dispose();
      Navigator.pop(context, scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(22.w),
            child: Column(
              children: [
                Row(
                  children: [
                    InkResponse(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(35.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              Text(
                                AppString.labelQRScanner.localize(context),
                                textAlign: TextAlign.center,
                                style: AppStyling.normal300Size15
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                              SizedBox(
                                height: 250.h,
                                child: QRView(
                                  key: qrKey,
                                  overlay: QrScannerOverlayShape(
                                    borderRadius: 8,
                                    borderWidth: 3.w,
                                    borderColor: AppColors.accentColor,
                                    borderLength: 30,
                                  ),
                                  onQRViewCreated: _onQRViewCreated,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkResponse(
                        radius: 30,
                        onTap: () {
                          controller.toggleFlash();
                          controller.getFlashStatus().then((value) {
                            setState(() {
                              isFlashLightOn = value;
                            });
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.qrTorchColor,
                          radius: 30,
                          child: SvgPicture.asset(
                            AppImages.icFlash,
                            color: isFlashLightOn
                                ? AppColors.accentColor
                                : AppColors.lightAshColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
