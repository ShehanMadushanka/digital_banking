import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';
import 'widget/transaction_text_row_widget.dart';

class ScheduleTransactionHistory extends BaseView {
  @override
  State<ScheduleTransactionHistory> createState() =>
      _ScheduleTransactionHistoryState();
}

class _ScheduleTransactionHistoryState
    extends State<ScheduleTransactionHistory> {
  List<Map<String, String>> payments = [
    {
      'Date': '08-Jun-2022',
      'Status': 'Success',
    },
    {
      'Date': '08-May-2022',
      'Status': 'Success',
    },
    {
      'Date': '08-Apr-2022',
      'Status': 'Failed',
    },
    {
      'Date': '08-Mar-2022',
      'Status': 'Success',
    },
    {
      'Date': '08-Feb-2022',
      'Status': 'Success',
    },
    {
      'Date': '08-Jan-2022',
      'Status': 'Success',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.transactionHistoryTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: ListView(
        children: [
          Container(
            color: AppColors.lightBlueColor,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Monthly Medicine",
                        style: AppStyling.normal600Size18,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'LKR',
                              style: AppStyling.normal300Size15
                                  .copyWith(color: AppColors.blackColor),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: '15,000.',
                                  style: AppStyling.normal600Size20,
                                ),
                                TextSpan(
                                  text: '00',
                                  style: AppStyling.normal300Size15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      top: 13,
                    ),
                    child: TransactionTextRow(
                      title: AppString.payFrom.localize(context),
                      accName: "My CDB Savings",
                      accNumber: "0000123456",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: TransactionTextRow(
                      title: AppString.payTo.localize(context),
                      accName: "CDB Savings - Amma",
                      accNumber: "0000123457",
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shrinkWrap: true,
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payDetails = payments[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.date.localize(context),
                            style: AppStyling.normal400Size14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              payDetails[AppString.date.localize(context)],
                              style: AppStyling.normal600Size14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.status.localize(context),
                        style: AppStyling.normal400Size14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child:
                            Text(payDetails[AppString.status.localize(context)],
                                style: AppStyling.normal600Size14.copyWith(
                                  color: payDetails[AppString.status
                                              .localize(context)] ==
                                          AppString.success.localize(context)
                                      ? const Color(0xff1EBB70)
                                      : const Color(0xffFF2212),
                                )),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
