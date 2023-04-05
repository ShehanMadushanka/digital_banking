import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../../utils/navigation_routes.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/cdb_icons.dart';
import '../../../../utils/enums.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_flat_button.dart';
import '../common/empty_view.dart';
import 'data/apply_filter_args.dart';
import 'data/transaction_history_args.dart';
import 'transaction_history_filter_view.dart';
import 'widget/transaction_list_view.dart';

class TransactionHistoryView extends StatefulWidget {
  const TransactionHistoryView({Key key}) : super(key: key);

  @override
  _TransactionHistoryViewState createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  String fromDate = "";
  String toDate = "";
  int fromAmount;
  int toAmount;

  String transactionType = "Bill Payment";
  bool isFiltered = false;
  bool downloadButton = true;
  bool dateFilter = true;
  bool amountFilter = true;
  List itemsList = transactionHistoryList;

  @override
  Widget build(BuildContext context) {
    void _navigateAndDisplaySelection(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const TransactionHistoryFilterView()),
      );

      final List filterList = [];

      final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      final ApplyFilterArgs args = result;
      final int fromAmountList = int.parse(args.fromAmount);
      final int toAmountList = int.parse(args.toAmount);
      final dateInput1 = inputFormat.parse(args.fromDate);
      final dateInput2 = inputFormat.parse(args.toDate);
      final dateFrom = outputFormat.format(dateInput1);
      final dateTo = outputFormat.format(dateInput2);

      for (var i = 0; i < transactionHistoryList.length; i++) {
        final DateTime lDate = DateTime.parse(transactionHistoryList[i].date);
        final int amount = int.parse(transactionHistoryList[i].amount);
        if (lDate.isAfter(DateTime.parse(dateFrom)) &&
            lDate.isBefore(DateTime.parse(dateTo))) {
          if (amount >= fromAmountList && amount <= toAmountList) {
            filterList.add(transactionHistoryList[i]);
          }
        }
      }
      setState(() {
        fromDate = args.fromDate;
        toDate = args.toDate;
        fromAmount = int.parse(args.fromAmount);
        toAmount = int.parse(args.toAmount);
        transactionType = args.transactionType;
        isFiltered = true;
        dateFilter = true;
        amountFilter = true;
        itemsList = filterList;
        if (itemsList.isEmpty) {
          downloadButton = false;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.transactionHistoryTitle.localize(context),
          style: AppStyling.normal600Size20
              .copyWith(color: AppColors.textDarkColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kLeftRightMarginOnBoarding),
            child: GestureDetector(
              onTap: () {
                _navigateAndDisplaySelection(context);
              },
              child: SvgPicture.asset(
                AppImages.icFilter,
                height: 25.w,
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
      ),
      //extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                AppImages.backgroundWalledRightCircle,
                height: 500.h,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.9),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kLeftRightMarginOnBoarding,
              right: kLeftRightMarginOnBoarding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isFiltered)
                  Column(
                    children: [
                      Row(
                        children: [
                          if (dateFilter == true)
                            GestureDetector(
                              onTap: () {
                                final List filterList = [];

                                for (var i = 0;
                                    i < transactionHistoryList.length;
                                    i++) {
                                  final int amount = int.parse(
                                      transactionHistoryList[i].amount);
                                  if (amount >= fromAmount &&
                                      amount <= toAmount) {
                                    filterList.add(transactionHistoryList[i]);
                                  }
                                }
                                setState(() {
                                  dateFilter = false;
                                  downloadButton = true;
                                  if (dateFilter == false &&
                                      amountFilter == false) {
                                    itemsList = transactionHistoryList;
                                  } else {
                                    itemsList = filterList;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.darkAshColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Text("$fromDate-$toDate"),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SvgPicture.asset(AppImages.icClose),
                                      //Icon(CDBIcons.ic_filter),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 15.h,
                          ),
                          if (amountFilter == true)
                            GestureDetector(
                              onTap: () {
                                final List filterList = [];
                                final DateFormat inputFormat =
                                    DateFormat('dd/MM/yyyy');
                                final DateFormat outputFormat =
                                    DateFormat('yyyy-MM-dd');
                                final dateInput1 = inputFormat.parse(fromDate);
                                final dateInput2 = inputFormat.parse(toDate);
                                final dateFrom =
                                    outputFormat.format(dateInput1);
                                final dateTo = outputFormat.format(dateInput2);
                                for (var i = 0;
                                    i < transactionHistoryList.length;
                                    i++) {
                                  final DateTime lDate = DateTime.parse(
                                      transactionHistoryList[i].date);
                                  if (lDate.isAfter(DateTime.parse(dateFrom)) &&
                                      lDate.isBefore(DateTime.parse(dateTo))) {
                                    filterList.add(transactionHistoryList[i]);
                                  }
                                }
                                setState(() {
                                  amountFilter = false;
                                  if (dateFilter == false &&
                                      amountFilter == false) {
                                    itemsList = transactionHistoryList;
                                  } else {
                                    itemsList = filterList;
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.darkAshColor),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Text("LKR   $fromAmount-$toAmount"),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SvgPicture.asset(AppImages.icClose),
                                      //Icon(CDBIcons.ic_filter),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              ///TODO Function for Transaction Type Close Button
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.darkAshColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Text(transactionType),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    SvgPicture.asset(AppImages.icClose),
                                    //Icon(CDBIcons.ic_filter),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                                child: Text(itemsList.length.toString())),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  height: 30.h,
                ),
                if (downloadButton == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CDBFlatButton(
                        title: AppString.buttonDownload.localize(context),
                        icon: CDBIcons.ic_download,
                        onTap: () {},
                      ),
                    ],
                  ),
                Expanded(
                  child: itemsList.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: itemsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TransactionListTitleView(
                              heading: itemsList[index].heading,
                              mobileNumber: itemsList[index].mobileNumber,
                              amount: itemsList[index].amount,
                              date: itemsList[index].date,
                              time: itemsList[index].time,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.kTransactionStatusView,
                                    arguments: TransactionHistoryArgs(
                                      heading: itemsList[index].heading,
                                      mobileNumber:
                                          itemsList[index].mobileNumber,
                                      amount:
                                          double.parse(itemsList[index].amount),
                                      date: itemsList[index].date,
                                    ));
                              },
                            );
                          },
                        )
                      : Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: kBottomMargin),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 64.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kBottomMargin),
                                    child: SizedBox(
                                        height: 350.h,
                                        child: const CDBEmptyView(
                                          type: EmptyViewType.NO_RESULTS,
                                        )),
                                  ),
                                  const Spacer(flex: 2),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: kTopMarginOnBoarding,
                                    ),
                                    child: CDBBorderGradientButton(
                                      width: double.maxFinite,
                                      onTap: () {
                                        _navigateAndDisplaySelection(context);
                                      },
                                      text: AppString.adjustFilters
                                          .localize(context),
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
          ),
        ],
      ),
    );
  }
}
