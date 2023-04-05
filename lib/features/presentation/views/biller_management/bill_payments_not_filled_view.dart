import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import 'widget/bill_payment_account_card.dart';

class BillPaymentsPlanNotFilledView extends StatefulWidget {
  const BillPaymentsPlanNotFilledView({Key key}) : super(key: key);

  @override
  _BillPaymentsPlanNotFilledViewState createState() =>
      _BillPaymentsPlanNotFilledViewState();
}

const String serviceProvider = 'Dialog';

class _BillPaymentsPlanNotFilledViewState
    extends State<BillPaymentsPlanNotFilledView> {
  final List<String> items = ["a", "b", "c"];

  String nickNameAnswer;
  String mobileNumber;
  String amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.billPayment.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kTopMarginOnBoarding),
                          child: Center(
                            child: Text(
                              AppString.mobileBillPlan.localize(context),
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0,
                              left: kLeftRightMarginOnBoarding,
                              right: kLeftRightMarginOnBoarding),
                          child: Text(
                            AppString.payFrom.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ),
                        SizedBox(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider.builder(
                            itemCount: items.length,
                            itemBuilder: (
                              BuildContext context,
                              int itemIndex,
                              int pageViewIndex,
                            ) =>
                                BillPaymentAccountCard(
                              title: "CDB Salary Plus",
                              accountNumber: "0102000568215",
                              amount: "520,000.00",
                              onTap: () {},
                            ),
                            options: CarouselOptions(
                              viewportFraction: 0.70,
                              initialPage: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0,
                              left: kLeftRightMarginOnBoarding,
                              right: kLeftRightMarginOnBoarding),
                          child: Text(
                            AppString.payTo.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textLightColor),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 10.0,
                              left: kLeftRightMarginOnBoarding,
                              right: kLeftRightMarginOnBoarding),
                          child: UserDetailsCard(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0,
                              left: kLeftRightMarginOnBoarding,
                              right: kLeftRightMarginOnBoarding),
                          child: CdbCustomTextField(
                            labelText: AppString.amountLkr.localize(context),
                            textInputType: TextInputType.number,
                            initialValue: '',
                            onChange: (value) {
                              setState(() {
                                amount = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0,
                              left: kLeftRightMarginOnBoarding,
                              right: kLeftRightMarginOnBoarding),
                          child: Text(
                            AppString.remarks.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 5.0,
                              left: kLeftRightMarginOnBoarding,
                              right: kLeftRightMarginOnBoarding),
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFE7E7E7), width: 2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                              text: AppString.payNow.localize(context)),
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
        },
      ),
    );
  }
}

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textLightColor, width: 0.2),
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.2,
            blurRadius: 2, // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.network(
                  'https://site.ieee.org/r10-htc-2018/files/2018/11/mobitel-logo.jpg',
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "My Mobitel",
                  style: AppStyling.normal600Size14
                      .copyWith(color: AppColors.textTitleColor),
                ),
                const Spacer(
                  flex: 3,
                ),
                Text(
                  "071 123 1234",
                  style: AppStyling.normal500Size16
                      .copyWith(color: AppColors.textTitleColor),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
