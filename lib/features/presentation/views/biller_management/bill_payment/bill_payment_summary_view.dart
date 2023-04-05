import 'package:cdb_mobile/features/domain/entities/response/biller_category_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/biller_entity.dart';
import 'package:cdb_mobile/features/domain/entities/response/custom_field_entity.dart';
import 'package:cdb_mobile/features/presentation/views/biller_management/data/bill_payment_args.dart';
import 'package:cdb_mobile/features/presentation/views/otp/otp_view.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../bloc/base_bloc.dart';
import '../../../bloc/base_event.dart';
import '../../../bloc/base_state.dart';
import '../../../bloc/biller_management/biller_management_bloc.dart';
import '../../../bloc/biller_management/biller_management_state.dart';
import '../../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../../widgets/cdb_default_appbar.dart';
import '../../../widgets/cdb_scrollview.dart';
import '../../base_view.dart';

class BillPaymentSummaryView extends BaseView {
  final BillerCategoryEntity billerCategoryEntity;
  final CustomFieldEntity customFieldEntity;
  final BillerEntity billerEntity;
  final BillPaymentArgs billPaymentArgs;

  const BillPaymentSummaryView({this.billPaymentArgs,
      this.billerCategoryEntity, this.customFieldEntity, this.billerEntity});
  @override
  _BillPaymentSummaryViewState createState() => _BillPaymentSummaryViewState();
}

class _BillPaymentSummaryViewState
    extends BaseViewState<BillPaymentSummaryView> {
  final BillerManagementBloc _billerManagementBloc =
      inject<BillerManagementBloc>();

  final formatCurrency = NumberFormat.currency(symbol: '');

  bool isPaymentSuccess = true;
  String payFromName;
  String payToName;
  String payToRef;
  double amount;
  double serviceCharge;
  String date;
  String referenceNumber;
  String remark;

  @override
  void initState() {
    super.initState();
    _updateUI();
  }

  _updateUI() {
    isPaymentSuccess = true;
    payFromName = 'CDB Salary Plus';
    payToName = 'Mobitel';
    payToRef = '071 123 1234';
    amount = 200;
    serviceCharge = 5;
    date = '16-November-2021';
    referenceNumber = '010111123548';
    remark = 'Reload';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleBillPaymentSummary.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _billerManagementBloc,
        child: BlocListener<BillerManagementBloc,
            BaseState<BillerManagementState>>(
          listener: (context, state) {},
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.only(
                top: kTopMarginOnBoarding,
                bottom: kBottomMargin,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CDBScrollView(
                          padding: EdgeInsets.zero,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.payFrom.localize(context),
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textTitleColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kOnBoardingMarginBetweenFields,
                              ),
                              PayFromCard(),
                              const SizedBox(
                                height: kOnBoardingMarginBetweenFields,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.payTo.localize(context),
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textTitleColor),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        //widget.billerEntity.billerName,
                                        widget.billPaymentArgs.billerEntity.billerName,
                                        style: AppStyling.normal500Size16
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                      Text(
                                        widget.billPaymentArgs.billerEntity.customFieldList[0].customFieldValue??'',
                                        style: AppStyling.normal500Size16
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: kOnBoardingMarginBetweenFields,
                              ),
                              if (isPaymentSuccess)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: AppString.amount
                                                    .localize(context),
                                                style: AppStyling
                                                    .normal600Size14
                                                    .copyWith(
                                                        color: AppColors
                                                            .textTitleColor)),
                                            TextSpan(
                                                text:
                                                    ' (${AppString.lkr.localize(context)})',
                                                style: AppStyling
                                                    .normal700Size10
                                                    .copyWith(
                                                        color: AppColors
                                                            .textTitleColor)),
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '${formatCurrency.format(amount).split('.')[0]}.',
                                                style: AppStyling
                                                    .normal500Size16
                                                    .copyWith(
                                                        color: AppColors
                                                            .textDarkColor)),
                                            TextSpan(
                                                text: formatCurrency
                                                    .format(amount)
                                                    .split('.')[1],
                                                style: AppStyling
                                                    .normal400Size14
                                                    .copyWith(
                                                        color: AppColors
                                                            .textDarkColor)),
                                          ]),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kOnBoardingMarginBetweenFields,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: AppString.serviceCharge
                                                    .localize(context),
                                                style: AppStyling
                                                    .normal600Size14
                                                    .copyWith(
                                                        color: AppColors
                                                            .textTitleColor)),
                                            TextSpan(
                                                text:
                                                    ' (${AppString.lkr.localize(context)})',
                                                style: AppStyling
                                                    .normal700Size10
                                                    .copyWith(
                                                        color: AppColors
                                                            .textTitleColor)),
                                          ]),
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '${formatCurrency.format(widget.billPaymentArgs.billerEntity.chargeCodeEntity.chargeAmount).split('.')[0]}.',
                                                style: AppStyling
                                                    .normal500Size16
                                                    .copyWith(
                                                        color: AppColors
                                                            .textDarkColor)),
                                            TextSpan(
                                                text: formatCurrency
                                                    .format(serviceCharge)
                                                    .split('.')[1],
                                                style: AppStyling
                                                    .normal400Size14
                                                    .copyWith(
                                                        color: AppColors
                                                            .textDarkColor)),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              else
                                const SizedBox.shrink(),
                              const SizedBox(
                                height: kOnBoardingMarginBetweenFields,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.date.localize(context),
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textTitleColor),
                                  ),
                                  Text(
                                    date,
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kOnBoardingMarginBetweenFields,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.referenceNumber.localize(context),
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textTitleColor),
                                  ),
                                  Text(
                                    referenceNumber,
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kOnBoardingMarginBetweenFields,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.remarks.localize(context),
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textTitleColor),
                                  ),
                                  Text(
                                    remark,
                                    // widget.billPaymentArgs.billerEntity.customFieldList.first.customFieldValue,
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages.iconInfoIc,
                                      width: 16, height: 16),
                                  Text(
                                    //'${AppString.billPaymentSummaryFirst.localize(context)} $payToName ${AppString.billPaymentSummarySecond.localize(context)} ',
                                    widget.billPaymentArgs.billerEntity.description,
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                ],
                              )
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
                              width: double.maxFinite,
                              onTap: () async {
                                final _otpResult = await Navigator.pushNamed(
                                    context, Routes.kCommonOTPView,
                                    arguments: OTPViewArgs(
                                        otpType: kOtpMessageTypeBillPayment,
                                        requestOTP: true)) as bool;

                                if (_otpResult) {
                                  Navigator.pushReplacementNamed(context, Routes.kBillPaymentStatusView);
                                }
                              },
                              text: isPaymentSuccess
                                  ? AppString.confirm.localize(context)
                                  : AppString.tryAgain.localize(context),
                            ),
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
          }),
        ),
      ),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _billerManagementBloc;
  }
}

class PayFromCard extends StatelessWidget {
  final formatCurrency = NumberFormat.currency(symbol: '');
  String payFromRef = '0102000568215';
  double amount = 520000;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 12),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.cdbSalaryPlus.localize(context),
                      style: AppStyling.normal600Size14
                          .copyWith(color: AppColors.textTitleColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: AppString.amount.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor)),
                          TextSpan(
                              text: ' (${AppString.lkr.localize(context)})',
                              style: AppStyling.normal700Size10
                                  .copyWith(color: AppColors.textTitleColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      payFromRef,
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.textDarkColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                '${formatCurrency.format(amount).split('.')[0]}.',
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textDarkColor)),
                        TextSpan(
                            text: formatCurrency.format(amount).split('.')[1],
                            style: AppStyling.normal400Size14
                                .copyWith(color: AppColors.textDarkColor)),
                      ]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
