import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/city_response.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_date_picker.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import 'data/apply_filter_args.dart';

class TransactionHistoryFilterView extends StatefulWidget {
  const TransactionHistoryFilterView({Key key}) : super(key: key);

  @override
  State<TransactionHistoryFilterView> createState() =>
      _TransactionHistoryFilterViewState();
}

class _TransactionHistoryFilterViewState
    extends State<TransactionHistoryFilterView> {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  String fromDate;
  String toDate;
  String fromAmount;
  String toAmount;
  String transactionType = "Bill Payments";
  bool isFiltered = true;

  void reset() {
    setState(() {
      fromDate = "";
      toDate = "";
      fromAmount = "";
      toAmount = "";
      transactionType = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = formatter.format(now);
    return Scaffold(
        appBar: CDBMainAppBar(
          appBarTitle: AppString.filterTransactionsTitle.localize(context),
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
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          //color: Colors.red,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.fromDate.localize(context),
                                style: AppStyling.normal600Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.darkAshColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                width: 159,
                                height: 34,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: CdbDatePicker(
                                    key: const Key("fromDate" ?? "fromDate"),
                                    initialValue: formattedDate,
                                    colorOrange: false,
                                    onChange: (value) {
                                      fromDate = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          //color: Colors.blue,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.toDate.localize(context),
                                style: AppStyling.normal600Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.darkAshColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                width: 159,
                                height: 34,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: CdbDatePicker(
                                    key: const Key("toDate" ?? "toDate"),
                                    initialValue: formattedDate,
                                    colorOrange: false,
                                    onChange: (value) {
                                      toDate = value;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          //color: Colors.green,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: AppString.amountRange
                                          .localize(context),
                                      style: AppStyling.normal600Size14
                                          .copyWith(
                                              color: AppColors.textTitleColor)),
                                  TextSpan(
                                      text:
                                          ' (${AppString.lkr.localize(context)})',
                                      style: AppStyling.normal400Size12
                                          .copyWith(
                                              color: AppColors.textTitleColor)),
                                ]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.darkAshColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                width: 159,
                                height: 34,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Text("From"),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: 34,
                                      width: 1,
                                      color: AppColors.darkAshColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: CdbCustomTextField(
                                        key: const Key(
                                            "fromAmount" ?? "fromAmount"),
                                        maxLength: 10,
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          setState(() {
                                            fromAmount = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(""),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.darkAshColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                width: 159,
                                height: 34,
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Text("To"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 34,
                                      width: 1,
                                      color: AppColors.darkAshColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: CdbCustomTextField(
                                        key:
                                            const Key("toAmount" ?? "toAmount"),
                                        isEnabled: true,
                                        maxLength: 10,
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          setState(() {
                                            toAmount = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.transactionType.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.darkAshColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              width: 245,
                              height: 34,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: CdbDropDown(
                                  key: const Key(
                                      "transactionType" ?? "transactionType"),
                                  initialValue: transactionType,

                                  // _applyFilterEntity != null
                                  //     ? _applyFilterEntity.transactionType
                                  //     : '',
                                  suffixIcon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.textDarkColor,
                                  ),
                                  onTap: () async {
                                    final result = await Navigator.pushNamed(
                                      context,
                                      Routes.kDropDownView,
                                      arguments: DropDownViewScreenArgs(
                                        pageTitle: AppString.selectTitle
                                            .localize(context),
                                        isSearchable: true,
                                        dropDownEvent:
                                            GetTransactionModeDropDownEvent(),
                                      ),
                                    ) as CommonDropDownResponse;
                                    if (result != null) {
                                      setState(() {
                                        transactionType = result.description;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  CDBBorderGradientButton(
                    status: _isValidated()
                        ? ButtonStatus.ENABLE
                        : ButtonStatus.DISABLE,
                    width: double.maxFinite,
                    onTap: () {
                      Navigator.pop(
                        context,
                        ApplyFilterArgs(
                          fromDate,
                          toDate,
                          fromAmount,
                          toAmount,
                          transactionType,
                        ),
                      );
                    },
                    text: AppString.applyFilters.localize(context),
                  ),
                  CDBNoBorderBackgroundButton(
                    onTap: () async {
                      reset();
                      // Navigator.pop(this.context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const TransactionHistoryFilterView()),
                      // );
                    },

                    ///TODO Reset all filters
                    text: AppString.resetAll.localize(context),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  bool _isValidated() {
    if (fromDate == "" ||
        fromDate == null ||
        toDate == "" ||
        toDate == null ||
        fromAmount == "" ||
        fromAmount == null ||
        toAmount == "" ||
        toAmount == null) {
      return false;
    }
    return true;
  }
}
