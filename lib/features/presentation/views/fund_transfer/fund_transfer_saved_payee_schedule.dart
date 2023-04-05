import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/data/models/responses/city_response.dart';
import 'package:cdb_mobile/features/domain/entities/response/fund_transfer_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/saved_payee_entity.dart';

import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/drop_down/drop_down_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/payee_management/payee_management_bloc.dart';

import 'package:cdb_mobile/features/presentation/views/fund_transfer/widget/select_payee_component.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_date_picker.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_multi_item_selector.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/cdb_drop_down.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/navigation_routes.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';

class FundTransferSavedPayeeSchedule extends BaseView {
  final FundTransferEntity fundTransferEntity;

  const FundTransferSavedPayeeSchedule({
    this.fundTransferEntity,
  });

  @override
  State<FundTransferSavedPayeeSchedule> createState() =>
      _FundTransferSavedPayeeState();
}

class _FundTransferSavedPayeeState
    extends State<FundTransferSavedPayeeSchedule> {
  final PayeeManagementBloc _bloc = inject<PayeeManagementBloc>();

  FundTransferEntity fundTransferEntity = FundTransferEntity();

  bool isValidated = false;
  bool isSelected = true;
  bool isSwitched = false;

  bool isNow = true;
  bool isLater = false;

  bool nowBeneficiaryNotClick = true;
  bool nowBeneficiaryClick = false;
  bool laterBeneficiaryNotClick = false;
  bool laterBeneficiaryClick = false;

  SavedPayeeEntity savedPayeeDetails;

  List<CDBMultiItemSelectorData> buttonSelectorList = [
    CDBMultiItemSelectorData(label: "Now", isSelected: true),
    CDBMultiItemSelectorData(label: "Later", isSelected: false)
  ];

  void whichButtonSelected(CDBMultiItemSelectorData value) {
    if (value == buttonSelectorList[0]) {
      setState(() {
        isNow = true;
        isLater = false;
      });
    } else {
      setState(() {
        isNow = false;
        isLater = true;
      });
    }
  }

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
    // final fundTransferEntity = FundTransferEntity();
    return Scaffold(
      body: BlocProvider(
        create: (_) => _bloc,
        child:
            BlocListener<PayeeManagementBloc, BaseState<PayeeManagementState>>(
          listener: (context, state) {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CDBScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          if (savedPayeeDetails == null)
                            SelectPayeeComponent(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.kSavedPayeeListView,
                                  arguments: true,
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      savedPayeeDetails = value;
                                    });

                                    fundTransferEntity.bankName =
                                        savedPayeeDetails.bankName;
                                    fundTransferEntity.accountNumber =
                                        savedPayeeDetails.accountNumber;
                                    fundTransferEntity.payTo =
                                        savedPayeeDetails;
                                  }
                                });
                              },
                            )
                          else
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 0.5, color: AppColors.darkAshColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x1F000000),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 21),
                                child: Row(
                                  children: [
                                    Image.network(
                                      savedPayeeDetails.payeeImageUrl,
                                      width: 50.w,
                                      height: 50.h,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          savedPayeeDetails.nickName,
                                          style: AppStyling.normal600Size14
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor),
                                        ),
                                        Text(
                                          savedPayeeDetails.accountNumber,
                                          style: AppStyling.normal300Size12
                                              .copyWith(
                                                  color:
                                                      AppColors.textLightColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: kOnBoardingMarginBetweenFields,
                      ),
                      //select button
                      AbsorbPointer(
                        absorbing: savedPayeeDetails == null ? true : false,
                        child: Opacity(
                          opacity: savedPayeeDetails == null ? 0.3 : 1.0,
                          child: CDBMultiItemSelector(
                            dataList: buttonSelectorList,
                            selectItem: (value) {
                              debugPrint(value.label);
                              if (value.label == "Now") {
                                setState(() {
                                  nowBeneficiaryNotClick = true;
                                  laterBeneficiaryNotClick = false;
                                  isValidated = false;
                                });
                              } else {
                                setState(() {
                                  laterBeneficiaryNotClick = true;
                                  nowBeneficiaryNotClick = false;
                                  isValidated = false;
                                });
                              }
                              whichButtonSelected(value);
                            },
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: isNow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: kOnBoardingMarginBetweenFields,
                                ),
                                CdbDropDown(
                                  key: const Key("trans_category"),
                                  suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.textDarkColor),
                                  labelText: AppString.fundTransferCategory
                                      .localize(context),
                                  //initialValue:  widget.fundTransferEntity.transactionCategory,
                                  onTap: () async {
                                    final result = await Navigator.pushNamed(
                                      context,
                                      Routes.kDropDownView,
                                      arguments: DropDownViewScreenArgs(
                                        pageTitle: AppString
                                            .fundTransferCategory
                                            .localize(context),
                                        isSearchable: true,
                                        dropDownEvent: GetTitleDropDownEvent(),
                                      ),
                                    ) as CommonDropDownResponse;
                                    if (result != null) {
                                      setState(() {
                                        fundTransferEntity.transactionCategory =
                                            result.description;
                                        isValidated = validate();
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: kOnBoardingMarginBetweenFields,
                                ),
                                CdbCustomTextField(
                                  key: const Key("reference"),
                                  labelText: AppString.fundTransferReference
                                      .localize(context),
                                  fontStyle: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                  suffixIcon: const Icon(
                                    Icons.info_outline,
                                    size: 15.0,
                                  ),
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
                                  key: const Key("amount"),
                                  fontStyle: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                  labelText: AppString.fundTransferAmount
                                      .localize(context),
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
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppString.fundTransferRemarksOpt
                                            .localize(context),
                                        textAlign: TextAlign.start,
                                        style: AppStyling.normal400Size14
                                            .copyWith(
                                                color:
                                                    AppColors.textTitleColor),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightAshColor,
                                          width: 2),
                                    )),
                                    maxLength: 30,
                                    onChanged: (value) {
                                      setState(() {
                                        fundTransferEntity.remark = value;
                                        // isValidated = validate();
                                      });
                                    },
                                  ),
                                ),
                                ListTileSwitch(
                                  contentPadding: EdgeInsets.zero,
                                  value: isSwitched,
                                  // onChanged: toggleSwitch,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      fundTransferEntity.notifyTheBeneficiary =
                                          value;
                                      nowBeneficiaryNotClick = !value;
                                      nowBeneficiaryClick = value;
                                      isValidated = validate();
                                    });
                                  },
                                  switchActiveColor: AppColors.primaryColor,
                                  title: Text(
                                    AppString.fundTransferNotifyTheBeneficiary
                                        .localize(context),
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ),
                                if (isSwitched)
                                  Column(
                                    children: [
                                      CdbCustomTextField(
                                        key: const Key("beneficiary_email"),
                                        labelText: AppString.benefEmail
                                            .localize(context),
                                        fontStyle: AppStyling.normal500Size16
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                        onChange: (value) {
                                          setState(() {
                                            fundTransferEntity
                                                .beneficiaryEmail = value;
                                            isValidated = validate();
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: kOnBoardingMarginBetweenFields,
                                      ),
                                      CdbCustomTextField(
                                        key: const Key("beneficiary_mobile_no"),
                                        labelText: AppString.benefMobile
                                            .localize(context),
                                        fontStyle: AppStyling.normal500Size16
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                        onChange: (value) {
                                          setState(() {
                                            fundTransferEntity
                                                .beneficiaryMobile = value;
                                            isValidated = validate();
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                else
                                  const SizedBox.shrink(),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isLater,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: kOnBoardingMarginBetweenFields,
                                ),
                                Column(
                                  children: [
                                    CdbDropDown(
                                      key: const Key("schedule_type"),
                                      suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.textDarkColor),
                                      labelText: AppString.scheduleType
                                          .localize(context),
                                      onTap: () async {
                                        final result =
                                            await Navigator.pushNamed(
                                          context,
                                          Routes.kDropDownView,
                                          arguments: DropDownViewScreenArgs(
                                            pageTitle: AppString.scheduleType
                                                .localize(context),
                                            isSearchable: true,
                                            dropDownEvent:
                                                GetTitleDropDownEvent(),
                                          ),
                                        ) as CommonDropDownResponse;
                                        if (result != null) {
                                          setState(() {
                                            fundTransferEntity.scheduleType =
                                                result.description;
                                            isValidated = validate();
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: kOnBoardingMarginBetweenFields,
                                    ),
                                    CdbCustomTextField(
                                      key: const Key("schedule_title"),
                                      fontStyle: AppStyling.normal500Size16
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                      labelText: AppString
                                          .fundTransferScheduleTitle
                                          .localize(context),
                                      onChange: (value) {
                                        setState(() {
                                          fundTransferEntity.scheduleTitle =
                                              value;
                                          isValidated = validate();
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      height: kOnBoardingMarginBetweenFields,
                                    ),

                                    ///If
                                    if (fundTransferEntity.fundTransferType ==
                                        FTType.SCHEDULED)
                                      Column(
                                        children: [
                                          CdbDatePicker(
                                            key: const Key("stat_date"),
                                            labelText: AppString.startDate
                                                .localize(context),
                                            onChange: (value) {
                                              fundTransferEntity.startDate =
                                                  value;
                                              isValidated = validate();
                                            },
                                          ),
                                          const SizedBox(
                                            height:
                                                kOnBoardingMarginBetweenFields,
                                          ),
                                          CdbDropDown(
                                            key: const Key("schedule_freq"),
                                            suffixIcon: const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: AppColors.textDarkColor),
                                            labelText: AppString.frequency
                                                .localize(context),
                                            onTap: () async {
                                              final result =
                                                  await Navigator.pushNamed(
                                                context,
                                                Routes.kDropDownView,
                                                arguments:
                                                    DropDownViewScreenArgs(
                                                  pageTitle: AppString.frequency
                                                      .localize(context),
                                                  isSearchable: true,
                                                  dropDownEvent:
                                                      GetTitleDropDownEvent(),
                                                ),
                                              ) as CommonDropDownResponse;
                                              if (result != null) {
                                                setState(() {
                                                  fundTransferEntity
                                                          .scheduleFrequency =
                                                      result.description;
                                                  isValidated = validate();
                                                });
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            height:
                                                kOnBoardingMarginBetweenFields,
                                          ),
                                          CdbDatePicker(
                                            key: const Key("end_date"),
                                            labelText: AppString.endDate
                                                .localize(context),
                                            onChange: (value) {
                                              fundTransferEntity.endDate =
                                                  value;
                                              isValidated = validate();
                                            },
                                          ),
                                        ],
                                      )

                                    ///else
                                    else
                                      const SizedBox(
                                        height: kOnBoardingMarginBetweenFields,
                                      ),
                                    CdbDatePicker(
                                      key: const Key("transaction_date"),
                                      labelText: AppString.transactionDate
                                          .localize(context),
                                      onChange: (value) {
                                        fundTransferEntity.transactionDate =
                                            value;
                                        isValidated = validate();
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: kOnBoardingMarginBetweenFields,
                                    ),

                                    CdbDropDown(
                                      key: const Key("trans_category"),
                                      suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.textDarkColor),
                                      labelText: AppString.transactionCategory
                                          .localize(context),
                                      onTap: () async {
                                        final result =
                                            await Navigator.pushNamed(
                                          context,
                                          Routes.kDropDownView,
                                          arguments: DropDownViewScreenArgs(
                                            pageTitle: AppString
                                                .transactionCategory
                                                .localize(context),
                                            isSearchable: true,
                                            dropDownEvent:
                                                GetTitleDropDownEvent(),
                                          ),
                                        ) as CommonDropDownResponse;
                                        if (result != null) {
                                          setState(() {
                                            fundTransferEntity
                                                    .transactionCategory =
                                                result.description;
                                            isValidated = validate();
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: kOnBoardingMarginBetweenFields,
                                    ),
                                    CdbCustomTextField(
                                      key: const Key("reference"),
                                      fontStyle: AppStyling.normal500Size16
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                      labelText:
                                          AppString.reference.localize(context),
                                      suffixIcon: const Icon(
                                        Icons.info_outline,
                                        size: 15.0,
                                      ),
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
                                      key: const Key("amount"),
                                      fontStyle: AppStyling.normal500Size16
                                          .copyWith(
                                              color: AppColors.textDarkColor),
                                      labelText:
                                          AppString.amountLkr.localize(context),
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

                                    ///Remark(Option)
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppString.fundTransferRemarksOpt
                                                .localize(context),
                                            textAlign: TextAlign.start,
                                            style: AppStyling.normal400Size14
                                                .copyWith(
                                                    color: AppColors
                                                        .textTitleColor),
                                          ),
                                        ]),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.lightAshColor,
                                              width: 2),
                                        )),
                                        maxLength: 30,
                                      ),
                                    ),
                                    ListTileSwitch(
                                      contentPadding: EdgeInsets.zero,
                                      value: isSwitched,
                                      // onChanged: toggleSwitch,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                          isValidated = validate();
                                          fundTransferEntity
                                              .notifyTheBeneficiary = value;
                                          laterBeneficiaryNotClick = !value;
                                          laterBeneficiaryClick = value;
                                        });
                                      },
                                      switchActiveColor: AppColors.primaryColor,
                                      title: Text(
                                        AppString
                                            .fundTransferNotifyTheBeneficiary
                                            .localize(context),
                                        style: AppStyling.normal500Size16
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                    ),
                                    if (isSwitched)
                                      Column(
                                        children: [
                                          CdbCustomTextField(
                                            key: const Key("beneficiary_email"),
                                            labelText: AppString.benefEmail
                                                .localize(context),
                                            fontStyle: AppStyling
                                                .normal500Size16
                                                .copyWith(
                                                    color: AppColors
                                                        .textDarkColor),
                                            onChange: (value) {
                                              setState(() {
                                                fundTransferEntity
                                                    .beneficiaryEmail = value;
                                                isValidated = validate();
                                              });
                                            },
                                          ),
                                          const SizedBox(
                                            height:
                                                kOnBoardingMarginBetweenFields,
                                          ),
                                          CdbCustomTextField(
                                            key: const Key(
                                                "beneficiary_mobile_no"),
                                            labelText: AppString.benefMobile
                                                .localize(context),
                                            fontStyle: AppStyling
                                                .normal500Size16
                                                .copyWith(
                                                    color: AppColors
                                                        .textDarkColor),
                                            onChange: (value) {
                                              setState(() {
                                                fundTransferEntity
                                                    .beneficiaryMobile = value;
                                                isValidated = validate();
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kLeftRightMarginOnBoarding,
                  right: kLeftRightMarginOnBoarding,
                ),
                child: Column(
                  children: [
                    CDBBorderGradientButton(
                        status: isValidated
                            ? ButtonStatus.ENABLE
                            : ButtonStatus.DISABLE,
                        width: double.maxFinite,
                        onTap: () => Navigator.pushNamed(
                            context, Routes.kFundTransferSummeryView,
                            arguments: fundTransferEntity),
                        // text: AppString.pay.localize(context),
                        text: AppString.pay.localize(context)),
                    CDBNoBorderBackgroundButton(
                      onTap: () {},
                      text: AppString.cancel.localize(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validate() {
    print(fundTransferEntity.scheduleTitle);
    if (nowBeneficiaryNotClick) {
      /*  if (fundTransferEntity.transactionCategory == null) {
        return false;
      } else*/
      if (fundTransferEntity.reference == null ||
          fundTransferEntity.reference.isEmpty) {
        return false;
      } else if (fundTransferEntity.amount == null ||
          fundTransferEntity.amount.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else if (nowBeneficiaryClick) {
      /*if (fundTransferEntity.transactionCategory == null) {
        return false;
      } else*/
      if (fundTransferEntity.reference == null ||
          fundTransferEntity.reference.isEmpty) {
        return false;
      } else if (fundTransferEntity.amount == null ||
          fundTransferEntity.amount.isEmpty) {
        return false;
      } else if (fundTransferEntity.notifyTheBeneficiary == null) {
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
    } else if (laterBeneficiaryNotClick) {
      if (fundTransferEntity.scheduleType == null ||
          fundTransferEntity.scheduleType.isEmpty) {
        return false;
      } else if (fundTransferEntity.scheduleTitle == null ||
          fundTransferEntity.scheduleTitle.isEmpty) {
        return false;
      } else if (fundTransferEntity.transactionDate == null ||
          fundTransferEntity.transactionDate.isEmpty) {
        return false;
      }
      /*else if (fundTransferEntity.transactionCategory == null) {
        return false;
      }*/
      else if (fundTransferEntity.reference == null ||
          fundTransferEntity.reference.isEmpty) {
        return false;
      } else if (fundTransferEntity.amount == null ||
          fundTransferEntity.amount.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else if (laterBeneficiaryClick) {
      if (fundTransferEntity.scheduleType == null ||
          fundTransferEntity.scheduleType.isEmpty) {
        return false;
      } else if (fundTransferEntity.scheduleTitle == null ||
          fundTransferEntity.scheduleTitle.isEmpty) {
        return false;
      } else if (fundTransferEntity.transactionDate == null ||
          fundTransferEntity.transactionDate.isEmpty) {
        return false;
      }
      /* else if (fundTransferEntity.transactionCategory == null ||
          fundTransferEntity.transactionCategory.isEmpty) {
        return false;
      }*/
      else if (fundTransferEntity.reference == null ||
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
      return false;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
