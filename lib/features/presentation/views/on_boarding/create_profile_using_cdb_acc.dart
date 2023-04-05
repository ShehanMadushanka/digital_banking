import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_header_underline.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';

class CreateProfileUsingCdbAcc extends StatelessWidget {
  const CreateProfileUsingCdbAcc({Key key}) : super(key: key);

  // get accNumber => null;

  @override
  Widget build(BuildContext context) {
    String accNumber;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDarkColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3.h, left: 16.w),
                    child: Text(
                      AppString.createProfile.localize(context),
                      style: AppStyling.normal500Size16.copyWith(
                        color: AppColors.textDarkColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 0.h, left: kLeftRightMarginOnBoarding.w),
                    child: const CdbHeaderUnderline(),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 0.h),
                        height: 295.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: AppColors.pinkGradient,
                        ),
                      ),
                      Positioned(
                        bottom: 21.h,
                        child: Image.asset(
                          AppImages.createProfileBgTwo,
                          width: MediaQuery.of(context).size.width,
                          height: 184.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48.7.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                        ),
                        child: Row(
                          children: [
                            Text(
                              AppString.enterCdbAccNumber.localize(context),
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.h),
                        child: CdbCustomTextField(
                          // key: Key(initialReferenceCode ?? "referenceCode"),
                          // initialValue: referenceCode,
                          labelText: AppString.accNumber.localize(context),
                          onChange: (value) {
                            setState(() {
                              accNumber = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kLeftRightMarginOnBoarding,
                      right: kLeftRightMarginOnBoarding,
                    ),
                    child: CDBBorderGradientButton(
                      width: double.maxFinite,
                      text: AppString.next.localize(context),
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void setState(Null Function() param0) {}
}
