import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';

class TransactionLimit extends StatefulWidget {
  const TransactionLimit({Key key}) : super(key: key);

  @override
  _TransactionLimitState createState() => _TransactionLimitState();
}

class _TransactionLimitState extends State<TransactionLimit> {
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

  SuperTooltip tooltip = SuperTooltip(
    right: 11.0,
    left: 20.0,
    minHeight: 89,
    borderColor: Colors.transparent,
    popupDirection: TooltipDirection.down,
    showCloseButton: ShowCloseButton.inside,
    closeButtonColor: Colors.transparent,
    closeButtonSize: 0,
    content: const Material(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "By enabling secondary verification and configuring a limit, you can add extra security for transaction that exceeds this limit amount. ",
        style: AppStyling.normal400Size14,
        softWrap: true,
      ),
    )),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleTransactionLimit.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24),
            child: Text(
              AppString.dailyTransactionLimit.localize(context),
              style: AppStyling.normal500Size16.copyWith(
                color: AppColors.textDarkColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CdbCustomTextField(
              //isCurrency: true,
              //isObscureText: true,
              suffixIcon: Container(
                transform: Matrix4.translationValues(0, 8, 0),
                child: Builder(
                  builder: (childContext) => IconButton(
                    onPressed: () {
                      tooltip.show(childContext);
                    },
                    splashRadius: 18,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                    ),
                    color: AppColors.textDarkColor,
                  ),
                ),
              ),
              labelText: AppString.maxTransaction.localize(context),
              maxLength: 10,
              initialValue: '',
              onChange: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 16),
          ListTileSwitch(
            value: isSwitched,
            onChanged: toggleSwitch,
            switchActiveColor: AppColors.primaryColor,
            title: Text(
              AppString.secondaryVerification.localize(context),
              style: AppStyling.normal600Size16
                  .copyWith(color: AppColors.textTitleColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CdbCustomTextField(
              isEnabled: isSwitched,

              //isCurrency: true,
              isObscureText: true,
              suffixIcon: Container(
                transform: Matrix4.translationValues(0, 8, 0),
                child: Builder(
                  builder: (childContext) => IconButton(
                    onPressed: () {
                      tooltip.show(childContext);
                    },
                    splashRadius: 18,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                    ),
                    color: AppColors.textDarkColor,
                  ),
                ),
              ),
              labelText: AppString.secondaryVerification.localize(context),
              maxLength: 10,
              initialValue: '',
              onChange: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 16),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              left: kLeftRightMarginOnBoarding,
              right: kLeftRightMarginOnBoarding,
            ),
            child: Column(
              children: [
                CDBBorderGradientButton(
                  width: double.maxFinite,
                  onTap: () {},
                  text: AppString.save.localize(context),
                ),
                CDBNoBorderBackgroundButton(
                  onTap: () {},
                  text: AppString.cancel.localize(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
