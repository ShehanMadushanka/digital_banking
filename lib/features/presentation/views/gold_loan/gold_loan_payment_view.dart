import 'package:carousel_slider/carousel_slider.dart';
import 'package:cdb_mobile/features/domain/entities/response/gold_loan_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/select_account_entity.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/bill_payment_account_card.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_no_border_background_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_info_icon_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import 'gold_loan_payment_summary_view.dart';

class GoldLoanPaymentView extends BaseView {
  const GoldLoanPaymentView({Key key}) : super(key: key);

  @override
  State<GoldLoanPaymentView> createState() => _GoldLoanPaymentViewState();
}

class _GoldLoanPaymentViewState extends BaseViewState<GoldLoanPaymentView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  final List<String> _items = ["a", "b", "c"];
  List<RadioModel> sampleData = <RadioModel>[];

  int _groupValue = 0;

  @override
  void initState() {
    super.initState();
    sampleData.add(RadioModel(false, 'Minimum', '10,000.00', 0));
    sampleData.add(RadioModel(false, 'Maximum', '47,000', 1));
    sampleData.add(RadioModel(false, 'Custom Amount', '', 2));
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleLoanPayment.localize(context),
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
                          padding: const EdgeInsets.only(left: 16.0, top: 24.0),
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
                            itemCount: _items.length,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 20),
                              child: Text(
                                'Payment Option',
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const CdbInfoIconView(
                              color: AppColors.primaryColor,
                            )
                          ],
                        ),
                        Column(
                            children: sampleData
                                .map<PaymentOptionRadioItem>(
                                  (element) => PaymentOptionRadioItem(
                                    element,
                                    (value) {
                                      setState(() {
                                        _groupValue = value;
                                      });
                                    },
                                    _groupValue,
                                  ),
                                )
                                .toList()),
                        if (_groupValue == 2)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 24.0),
                            child: CdbCustomTextField(
                              labelText: AppString.amountLkr.localize(context),
                              textInputType: TextInputType.number,
                              initialValue: '',
                              onChange: (value) {
                                setState(() {});
                              },
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 16),
                          child: Text(
                            AppString.remarks.localize(context),
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 5.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFE7E7E7), width: 2),
                              ),
                            ),
                            maxLines: 2,
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
                              onTap: () {
                                Navigator.pushNamed(context, Routes.kGoldLoanPaymentSummaryView, arguments: GoldLoanPaymentSummeryArgs(
                                  amount: 12.11,
                                  selectAccountEntity: SelectAccountEntity(
                                    accountBalance: 1000,accountName: 'Salary Plus',
                                    accountNum: '123123123',
                                    accountType: 'Saving',
                                    balance: 21231,
                                    isActive: true,
                                    maximumAdvanceLimit: 50000,
                                    ticketNumber: 12312
                                  ),
                                  goldLoanEntity: GoldLoanEntity(
                                    ticketNumber: '234242342',
                                    maximumAdvanceLimit: 50000,
                                  )
                                ),);
                              },
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}

class PaymentOptionRadioItem extends StatelessWidget {
  final RadioModel _item;
  final Function onChanged;
  final int groupValue;

  const PaymentOptionRadioItem(this._item, this.onChanged, this.groupValue);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 60,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 6,
            )
          ],
          border: Border.all(width: 0.5, color: AppColors.darkAshColor),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Row(
          children: <Widget>[
            Text(
              _item.buttonText,
              style: AppStyling.normal600Size14
                  .copyWith(color: AppColors.textTitleColor),
            ),
            const Spacer(),
            if (_item.amount.isNotEmpty)
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "${AppString.lkr.localize(context)} ",
                    style: AppStyling.normal400Size12
                        .copyWith(color: AppColors.textDarkColor),
                  ),
                  TextSpan(
                      text: '10,000',
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.textDarkColor)),
                  TextSpan(
                      text: '.00',
                      style: AppStyling.light300Size15
                          .copyWith(color: AppColors.textDarkColor)),
                ]),
              )
            else
              const SizedBox.shrink(),
            Row(
              children: [
                Radio<int>(
                  onChanged: onChanged,
                  activeColor: AppColors.textDarkColor,
                  groupValue: groupValue,
                  value: _item.value,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String amount;
  int value;

  RadioModel(this.isSelected, this.buttonText, this.amount, this.value);
}
