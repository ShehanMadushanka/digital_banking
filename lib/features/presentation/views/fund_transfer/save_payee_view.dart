import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';
import 'widget/payee_details_textrow.dart';

class SavePayee extends BaseView {
  final FundTransferEntity fundTransferEntity;
  const SavePayee({this.fundTransferEntity});

  @override
  State<SavePayee> createState() => _PayeeDetailsState();
}

class _PayeeDetailsState extends State<SavePayee> {
  String nickName = "";
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.savePayee.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: kTopMarginOnBoarding,
          left: kLeftRightMarginOnBoarding,
          right: kLeftRightMarginOnBoarding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // A custom text row widget.
                DetailsField(
                  field1: AppString.accNumber.localize(context),
                  field2: widget.fundTransferEntity.accountNumber,
                  bottomPadding: 26,
                ),
                // A custom text row widget.
                DetailsField(
                  field1: AppString.bank.localize(context),
                  field2: widget.fundTransferEntity.bankName,
                  bottomPadding: 26,
                ),
                // A custom text row widget.
                DetailsField(
                  field1: AppString.name.localize(context),
                  field2: widget.fundTransferEntity.name,
                  bottomPadding: 0,
                ),
                CdbCustomTextField(
                  key: const Key("keyNickName"),
                  labelText: AppString.nickName.localize(context),
                  fontStyle: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                  initialValue: '',
                  onChange: (value) {
                    setState(() {
                      nickName = value;
                    });
                  },
                ),
                ListTileSwitch(
                  contentPadding: EdgeInsets.zero,
                  value: isFavorite,
                  onChanged: (value) {
                    setState(() {
                      isFavorite = value;
                    });
                  },
                  switchActiveColor: AppColors.primaryColor,
                  title: Text(
                    AppString.addAsFavorite.localize(context),
                    style: AppStyling.normal500Size16
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CDBBorderGradientButton(
                  width: double.maxFinite,
                  status: nickName.isNotEmpty
                      ? ButtonStatus.ENABLE
                      : ButtonStatus.DISABLE,
                  onTap: () {
                    //TODO : Implement payee save.
                  },
                  text: AppString.save.localize(context),
                ),
                CDBNoBorderBackgroundButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.kHomeView, (route) => false);
                  },
                  text: AppString.home.localize(context),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
