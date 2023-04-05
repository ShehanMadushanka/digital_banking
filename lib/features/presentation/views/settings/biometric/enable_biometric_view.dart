import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../widgets/cdb_default_appbar.dart';

class EnableBiometricView extends StatefulWidget {
  const EnableBiometricView({Key key}) : super(key: key);

  @override
  _EnableBiometricViewState createState() => _EnableBiometricViewState();
}

class _EnableBiometricViewState extends State<EnableBiometricView> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.biometricSettings.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: kLeftRightMarginOnBoarding,
              right: kLeftRightMarginOnBoarding,
              top: kTopMarginOnBoarding,
            ),
            child: Text(
              AppString.biometricSettingsDecs.localize(context),
              style: AppStyling.normal400Size14
                  .copyWith(color: AppColors.textTitleColor),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTileSwitch(
            value: isSwitched,
            onChanged: toggleSwitch,
            switchActiveColor: AppColors.primaryColor,
            title: Text(
              AppString.fingerprint.localize(context),
              style: AppStyling.normal600Size16
                  .copyWith(color: AppColors.textTitleColor),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          SvgPicture.asset(
            AppImages.biometricFaceIcon,
          ),
        ],
      ),
    );
  }
}
