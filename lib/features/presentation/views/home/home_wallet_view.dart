import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cdb_mobile/core/services/app_permission.dart';
import 'package:cdb_mobile/core/services/platform_services.dart';
import 'package:cdb_mobile/features/data/models/common/lanka_qr_payload.dart';
import 'package:cdb_mobile/features/presentation/views/common/empty_view.dart';
import 'package:cdb_mobile/features/presentation/views/home/widget/home_account_card.dart';
import 'package:cdb_mobile/features/presentation/views/home/widget/home_transaction_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_appbar/cdb_home_app_bar.dart';
import 'widget/home_my_fav_card.dart';
import 'widget/home_recent_trans_card.dart';

class FavouriteBiller {
  final String name;
  final String provider;
  final String imageUrl;

  FavouriteBiller({this.name, this.provider, this.imageUrl});
}

List offerListImageUrl = [
  "https://www.dialogfinance.lk/wp-content/uploads/2022/08/Real-Wasi-Keels-Offer-1-710x445-1.jpg",
  "https://www.mobitel.lk/sites/default/files/images/Mobitel-Anytime-Data-Pre-Paid_2021.jpg",
  "https://www.cdb.lk/wp-content/uploads/2020/09/E-1400-x-570.jpg",
  "https://cargillsonline.com/VendorItems/Og-image.png"
];


class Transaction {
  final String name;
  final String amount;
  final String type;
  final String imageUrl;

  Transaction({this.name, this.amount, this.type, this.imageUrl});
}

List<Transaction> _transactionList = [
  Transaction(
      name: 'My Personal Dialog',
      amount: '200.00',
      type: 'Bill Payment',
      imageUrl:
      'https://cdn.freebiesupply.com/logos/large/2x/dialog-axiata-1-logo-png-transparent.png'),
  Transaction(
      name: 'My Personal Mobitel',
      amount: '200.00',
      type: 'Bill Payment',
      imageUrl:
      'https://i2.wp.com/www.mobileworldlive.com/wp-content/uploads/2017/05/Mobitel_logo.png?w=348&ssl=1'),
  Transaction(
      name: 'My Commercial Account',
      amount: '5000.00',
      type: 'Fund Transfer',
      imageUrl:
      'https://seeklogo.com/images/C/commercial-bank-logo-9C9098B1B5-seeklogo.com.png'),
];

class HomeWalletView extends StatefulWidget {
  const HomeWalletView({Key key}) : super(key: key);

  @override
  _HomeWalletViewState createState() => _HomeWalletViewState();
}

class _HomeWalletViewState extends State<HomeWalletView> {
  final List<String> items = ["a", "b", "c"];

  /// Get Greeting message according to time
  String getGreetingMessage(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return AppString.goodMorning.localize(context);
    }
    if (hour < 17) {
      return AppString.goodAfternoon.localize(context);
    }
    return AppString.goodEvening.localize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: CDBHomeAppBar(
                          imagePath:
                          'https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/man5-512.png',
                          title: getGreetingMessage(context),
                          username: "Nafeel",
                          notificationCount: "99",
                          onTapNotification: (){
                            Navigator.pushNamed(context, Routes.kNotificationsView);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: (){
                              Navigator.pushNamed(context, Routes.kAddPaymentInstrumentRootView);
                            },
                            child: Text(
                              AppString.add.localize(context),
                              style: AppStyling.normal600Size14.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 180.h,
                        width: MediaQuery.of(context).size.width,
                        child: CarouselSlider.builder(
                          itemCount: items.length,
                          itemBuilder: (
                              BuildContext context,
                              int itemIndex,
                              int pageViewIndex,
                              ) =>
                              InkWell(
                                splashColor: Colors.transparent,
                                onTap: (){
                                  if(itemIndex == 0) {
                                    Navigator.pushNamed(context, Routes.kAddPaymentInstrumentRootView);
                                  }
                                },
                                child: HomeAccountCard(
                                  title: "CDB Salary Plus",
                                  accountNumber: "0102000568215",
                                  amount: "520,000.00",
                                  isEmpty: itemIndex == 0,
                                ),
                              ),
                          options: CarouselOptions(
                            viewportFraction: 0.70,
                            initialPage: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const TransactionFunctionRow(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: HomeWalletListTopic(
                            rightText: AppString.seeAll.localize(context),
                            leftText: AppString.promotionAndOffers.localize(context)),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      SizedBox(
                        height: offerListImageUrl.isEmpty ? 120.h : 106.h,
                        child: offerListImageUrl.isEmpty
                            ? const CDBEmptyView(
                            type: EmptyViewType.MYFAVOURITE)
                            : ListView.builder(
                            padding:
                            EdgeInsets.only(left: 16.w, right: 5.w),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: offerListImageUrl.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 15),
                                height: double.infinity,
                                width: 262,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: NetworkImage(offerListImageUrl[index]),
                                        fit: BoxFit.cover
                                    )
                                ),
                              );

                            }),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: HomeWalletListTopic(
                          rightText: AppString.seeAll.localize(context),
                          leftText:
                          AppString.recentTransactions.localize(context),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      SizedBox(
                        height: _transactionList.isEmpty ? 120.h : 280.w,
                        child: _transactionList.isEmpty
                            ? const CDBEmptyView(
                            type: EmptyViewType.RECENTTRANSACTIONS)
                            : ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _transactionList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10.h, left: 16.w, right: 16.w),
                              child: HomeRecentTransactionCard(
                                title: _transactionList[index].name,
                                paymentType: _transactionList[index].type,
                                imageUrl:
                                _transactionList[index].imageUrl,
                                time: '2 hours ago',
                                amount: _transactionList[index].amount,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeWalletListTopic extends StatelessWidget {
  const HomeWalletListTopic(
      {Key key, @required this.rightText, @required this.leftText})
      : super(key: key);

  final String rightText;
  final String leftText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: AppStyling.normal500Size16
              .copyWith(color: AppColors.textDarkColor),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            rightText,
            style: AppStyling.normal600Size14.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

class TransactionFunctionRow extends StatelessWidget {
  const TransactionFunctionRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeTransactionButton(
          onTap: () {},
          text: AppString.topUp.localize(context),
          imagePath: AppImages.icTopUp,
        ),
        HomeTransactionButton(
          onTap: () {
            Navigator.pushNamed(context, Routes.kBillPaymentMainView);
          },
          text: AppString.payBill.localize(context),
          imagePath: AppImages.icPayBill,
        ),
        HomeTransactionButton(
          onTap: () {
            Navigator.pushNamed(context, Routes.kFundTransferScreenInput);
          },
          text: AppString.transfer.localize(context),
          imagePath: AppImages.icTransfer,
        ),
        HomeTransactionButton(
          onTap: () async {
            AppPermissionManager.requestCameraPermission(context, () async {
              await Navigator.pushNamed(context, Routes.kQRScannerView).then((qrData){
                if(qrData!=null){
                  PlatformServices.validateLankaQR(qrData).then((value){
                    if(value == 'Invalid QR'){
                      ToastUtils.showCustomToast(context, value, ToastStatus.fail);
                    }else{
                      LankaQrPayload payload = LankaQrPayload.fromJson(jsonDecode(value));
                      Navigator.pushNamed(context, Routes.kQRPaymentView, arguments: payload);
                    }
                  });
                }
              });
            });
          },
          text: AppString.qrPay.localize(context),
          imagePath: AppImages.icQrPay,
        ),
      ],
    );
  }
}
