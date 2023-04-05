import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_styling.dart';

class TransactionHistoryList {
  String heading;
  String mobileNumber; //Change to int
  String amount; //Change to int
  String date;
  String time;

  TransactionHistoryList(
      {this.heading, this.mobileNumber, this.amount, this.date, this.time});
}

List<TransactionHistoryList> transactionHistoryList = <TransactionHistoryList>[
  TransactionHistoryList(
      heading: "Mobitel Reload/DATA",
      mobileNumber: "071 123 1234",
      amount: "20",
      date: "2023-09-28",
      time: "22:10"),
  TransactionHistoryList(
      heading: "mCash Payment",
      mobileNumber: "071 123 1234",
      amount: "200",
      date: "2024-02-12",
      time: "21:25"),
  TransactionHistoryList(
      heading: "Janashakthi Insurance",
      mobileNumber: "071 123 1234",
      amount: "200",
      date: "2021-06-11",
      time: "10:50"),
  TransactionHistoryList(
      heading: "AIA Finance",
      mobileNumber: "071 123 1234",
      amount: "2000",
      date: "2021-09-25",
      time: "09:58"),
  TransactionHistoryList(
      heading: "Mobitel Reload/DATA",
      mobileNumber: "071 123 1234",
      amount: "400",
      date: "2021-02-12",
      time: "22:10"),
  TransactionHistoryList(
      heading: "Mobitel Reload/DATA",
      mobileNumber: "071 123 1234",
      amount: "200",
      date: "2021-12-23",
      time: "22:10"),
  TransactionHistoryList(
      heading: "Mobitel Reload/DATA",
      mobileNumber: "071 123 1234",
      amount: "200",
      date: "2021-08-23",
      time: "22:10"),
];

class TransactionListTitleView extends StatelessWidget {
  const TransactionListTitleView(
      {Key key,
      this.heading,
      this.mobileNumber,
      this.amount,
      this.date,
      this.time,
      this.onTap})
      : super(key: key);

  final String heading;
  final String mobileNumber; //Change to int
  final String amount; //Change to int
  final String date;
  final String time;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kTopMarginOnBoarding,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(heading,
                        style: AppStyling.normal500Size16
                            .copyWith(color: AppColors.textTitleColor)),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text("(DR)",
                        style: AppStyling.normal700Size12
                            .copyWith(color: AppColors.accentColor)),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text("Pay To: $mobileNumber"),
              ],
            ),
            const Spacer(
              flex: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'LKR ',
                      style: AppStyling.normal500Size12
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    TextSpan(
                      text: amount,
                      style: AppStyling.normal400Size14
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    TextSpan(
                      text: '.00',
                      style: AppStyling.normal500Size10
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text("$date  " + "  $time"),
              ],
            ),
            SizedBox(
              width: 15.w,
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 18, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
