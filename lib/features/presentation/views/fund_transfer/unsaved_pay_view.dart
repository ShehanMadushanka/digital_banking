import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../../domain/entities/response/saved_payee_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';

class UnsavedPayeeView extends BaseView {
  const UnsavedPayeeView({Key key}) : super(key: key);

  @override
  State<UnsavedPayeeView> createState() => _UnsavedPayeeViewState();
}

class _UnsavedPayeeViewState extends BaseViewState<UnsavedPayeeView> {
  final _bloc = inject<PayeeManagementBloc>();
  final fundTransferEntity = FundTransferEntity();
  bool isValidated = false;
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
  void initState() {
    fundTransferEntity.payTo = SavedPayeeEntity();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CDBScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                CdbCustomTextField(
                  key: const Key("account_number"),
                  labelText: AppString.accNumber.localize(context),
                  fontStyle: AppStyling.normal600Size16
                      .copyWith(color: AppColors.textDarkColor),
                  maxLength: 15,
                  initialValue: '',
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    setState(() {
                      fundTransferEntity.accountNumber = value;
                      isValidated = validate();
                    });
                  },
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                CdbDropDown(
                  key: const Key("bank_name"),
                  initialValue: '',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textDarkColor),
                  labelText: AppString.bank.localize(context),
                  onTap: () {},
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                CdbCustomTextField(
                  key: const Key("name"),
                  fontStyle: AppStyling.normal600Size16
                      .copyWith(color: AppColors.textDarkColor),
                  labelText: AppString.fundTransferName.localize(context),
                  maxLength: 15,
                  initialValue: '',
                  onChange: (value) {
                    setState(() {
                      fundTransferEntity.name = value;
                      isValidated = validate();
                    });
                  },
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                CdbDropDown(
                  key: const Key("Trans_category"),
                  initialValue: '',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textDarkColor),
                  labelText: AppString.fundTransferCategory.localize(context),
                  onTap: () {},
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                CdbCustomTextField(
                  key: const Key("reference"),
                  fontStyle: AppStyling.normal600Size16
                      .copyWith(color: AppColors.textDarkColor),
                  labelText:
                  AppString.fundTransferReference.localize(context),
                  maxLength: 12,
                  initialValue: '',
                  suffixIcon: const Icon(Icons.info_outline_rounded,
                      color: AppColors.textDarkColor),
                  onChange: (value) {
                    setState(() {
                      fundTransferEntity.reference = value;
                      isValidated = validate();
                    });
                  },
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                CdbCustomTextField(
                  key: const Key("Amount"),
                  labelText: AppString.fundTransferAmount.localize(context),
                  fontStyle: AppStyling.bold700Size16
                      .copyWith(color: AppColors.textDarkColor),
                  maxLength: 12,
                  initialValue: '',
                  onChange: (value) {
                    setState(() {
                      fundTransferEntity.amount = value;
                      isValidated = validate();
                    });
                  },
                ),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 235),
                  child: Text(
                    AppString.fundTransferRemarksOpt.localize(context),
                    style: AppStyling.normal400Size16
                        .copyWith(color: AppColors.textTitleColor),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Padding(
                  padding: EdgeInsets.all(4),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xFFE7E7E7), width: 2),
                      ),
                    ),
                    maxLines: 2,
                  ),
                ),
                ListTileSwitch(
                  contentPadding: EdgeInsets.zero,
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      fundTransferEntity.notifyTheBeneficiary = value;
                      isValidated = validate();
                    });
                  },
                  switchActiveColor: AppColors.primaryColor,
                  title: Text(
                    AppString.fundTransferNotifyTheBeneficiary
                        .localize(context),
                    style: AppStyling.normal400Size16
                        .copyWith(color: AppColors.textTitleColor),
                  ),
                ),
                if (isSwitched)
                  Column(
                    children: [
                      CdbCustomTextField(
                        key: const Key("email"),
                        labelText: AppString.benefEmail.localize(context),
                        maxLength: 15,
                        fontStyle: AppStyling.normal600Size16
                            .copyWith(color: AppColors.textDarkColor),
                        initialValue: '',
                        onChange: (value) {
                          fundTransferEntity.beneficiaryEmail = value;
                          isValidated = validate();
                        },
                      ),
                      const SizedBox(
                        height: kOnBoardingMarginBetweenFields,
                      ),
                      CdbCustomTextField(
                        key: const Key("Phone"),
                        fontStyle: AppStyling.normal600Size16
                            .copyWith(color: AppColors.textDarkColor),
                        labelText: AppString.benefMobile.localize(context),
                        maxLength: 10,
                        initialValue: '',
                        onChange: (value) {
                          setState(() {
                            fundTransferEntity.beneficiaryMobile = value;
                            isValidated = validate();
                          });
                        },
                      ),
                    ],
                  )
                else
                  SizedBox.shrink(),
                const SizedBox(
                  height: kOnBoardingMarginBetweenFields,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: kLeftRightMarginOnBoarding,
            right: kLeftRightMarginOnBoarding,
          ),
          child: Column(
            children: [
              CDBBorderGradientButton(
                status:
                isValidated ? ButtonStatus.ENABLE : ButtonStatus.DISABLE,
                width: double.maxFinite,
                onTap: () => Navigator.pushNamed(
                    context, Routes.kFundTransferSummeryView,
                    arguments: fundTransferEntity),
                text: AppString.continueTxt.localize(context),
              ),
              const SizedBox(
                height: 5,
              ),
              CDBNoBorderBackgroundButton(
                onTap: () {},
                text: AppString.cancel.localize(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool validate() {
    if (isSwitched) {
      if (fundTransferEntity.accountNumber == null ||
          fundTransferEntity.accountNumber.isEmpty) {
        return false;
      } /*else if (fundTransferEntity.bankName == null ||
          fundTransferEntity.bankName.isEmpty) {
        return false;
      } */else if (fundTransferEntity.name == null ||
          fundTransferEntity.name.isEmpty) {
        return false;
      } else if (fundTransferEntity.reference == null ||
          fundTransferEntity.reference.isEmpty) {
        return false;
      } else if (fundTransferEntity.amount == null ||
          fundTransferEntity.amount.isEmpty) {
        return false;
      } else if (fundTransferEntity.beneficiaryEmail == null ||
          fundTransferEntity.beneficiaryEmail.isEmpty) {
        return false;
      } else if (fundTransferEntity.beneficiaryMobile == null ||
          fundTransferEntity.beneficiaryMobile.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else {
      if (fundTransferEntity.accountNumber == null ||
          fundTransferEntity.accountNumber.isEmpty) {
        return false;
      } /*else if (fundTransferEntity.bankName == null ||
          fundTransferEntity.bankName.isEmpty) {
        return false;
      } */else if (fundTransferEntity.name == null ||
          fundTransferEntity.name.isEmpty) {
        return false;
      } else if (fundTransferEntity.reference == null ||
          fundTransferEntity.reference.isEmpty) {
        return false;
      } else if (fundTransferEntity.amount == null ||
          fundTransferEntity.amount.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
