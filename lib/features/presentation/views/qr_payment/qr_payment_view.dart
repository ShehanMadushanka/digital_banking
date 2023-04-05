import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cdb_mobile/features/data/models/common/lanka_qr_payload.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_state.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/widget/bill_payment_account_card.dart';
import 'package:cdb_mobile/features/presentation/views/on_boarding/review_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_no_border_background_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_text_fields/cdb_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../base_view.dart';

class QrPaymentView extends BaseView {
  final LankaQrPayload lankaQrPayload;

  QrPaymentView({this.lankaQrPayload});

  @override
  _BillPaymentViewState createState() => _BillPaymentViewState();
}

class _BillPaymentViewState extends BaseViewState<QrPaymentView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  final List<String> items = ["a", "b", "c"];

  double amount;
  String remarks;
  bool shouldAllowAmountEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.lankaQrPayload.transactionFee != null ||
        widget.lankaQrPayload.transactionFee.isNotEmpty) {
      amount = double.parse(widget.lankaQrPayload.transactionFee);
    } else {
      amount = 0;
    }

    if (widget.lankaQrPayload.pointOfInitiationMethod == '12' &&
        (widget.lankaQrPayload.transactionFee != null ||
            widget.lankaQrPayload.transactionFee.isNotEmpty)) {
      shouldAllowAmountEditing = false;
    } else {
      shouldAllowAmountEditing = true;
    }
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleQRPayment.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: LayoutBuilder(
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
                                  const EdgeInsets.only(left: 16.0, top: 24.0),
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
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 20),
                              child: Text(
                                AppString.payTo.localize(context),
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 32,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.separationLinesColor,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: AppColors.lightAshColor),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.lankaQrPayload.merchantName,
                                        style: AppStyling.normal400Size14
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        widget.lankaQrPayload.merchantCity,
                                        maxLines: 2,
                                        style: AppStyling.normal300Size12
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (shouldAllowAmountEditing)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 24.0),
                                child: CdbCustomTextField(
                                  isCurrency: true,
                                  labelText:
                                      AppString.amountLkr.localize(context),
                                  textInputType: TextInputType.number,
                                  initialValue: amount.toString(),
                                  onChange: (value) {
                                    setState(() {
                                      amount = value;
                                    });
                                  },
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0, top: 24.0),
                                child: DetailItemView(
                                    title:
                                        AppString.amountLkr.localize(context),
                                    value: amount.toString()),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
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
                                  onTap: () {},
                                  text: AppString.payNow.localize(context)),
                              CDBNoBorderBackgroundButton(
                                onTap: () {
                                  showCDBDialog(
                                    isTwoButton: true,
                                    title: AppString.titleCancelQRPayment
                                        .localize(context),
                                    body: Column(
                                      children: [
                                        Text(AppString.descCancelQRPayment
                                            .localize(context)),
                                      ],
                                    ),
                                    positiveButtonText:
                                        AppString.yesCancel.localize(context),
                                    positiveButtonTap: () {
                                      Navigator.pop(context);
                                    },
                                    negativeButtonText:
                                        AppString.no.localize(context),
                                    negativeButtonTap: () {},
                                  );
                                },
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
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
