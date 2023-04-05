import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_flat_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_scrollview.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'gold_loan_payment_summary_view.dart';

class LoanPaymentReceipt extends BaseView {
  final GoldLoanPaymentSummeryArgs goldLoanPaymentSummeryArgs;

  const LoanPaymentReceipt({this.goldLoanPaymentSummeryArgs, Key key})
      : super(key: key);

  @override
  _LoanPaymentReceiptState createState() => _LoanPaymentReceiptState();
}

class _LoanPaymentReceiptState extends BaseViewState<LoanPaymentReceipt> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();
  bool isPaymentSuccess = true;
  String referenceNumber = "010111123548";
  final formatCurrency = NumberFormat.currency(symbol: '');

  @override
  Widget buildView(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
    final String formattedTime = dateFormat.format(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );

    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.loanPaymentReceiptTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: kTopMarginOnBoarding,
          bottom: kBottomMargin,
        ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 35.w,
                          height: 35.w,
                          decoration: BoxDecoration(
                            color: isPaymentSuccess
                                ? AppColors.successGreenColor
                                : AppColors.errorRedColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              isPaymentSuccess
                                  ? Icons.check_rounded
                                  : CDBIcons.ic_close,
                              size: 18,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          isPaymentSuccess
                              ? AppString.loanPaymentReceiptSuccessfulTitle
                                  .localize(context)
                              : AppString.loanPaymentReceiptFailTitle
                                  .localize(context),
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kOnBoardingMarginBetweenFields,
                    ),
                    if (isPaymentSuccess)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CDBFlatButton(
                            title: AppString.buttonDownload.localize(context),
                            icon: CDBIcons.ic_download,
                            onTap: () {},
                          ),
                          CDBFlatButton(
                            title: AppString.buttonShare.localize(context),
                            icon: CDBIcons.ic_share,
                            onTap: () {},
                          ),
                        ],
                      )
                    else
                      Center(
                        child: Text(
                            AppString.loanPaymentReceiptFailDescription
                                .localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor)),
                      ),
                    SizedBox(
                      height: isPaymentSuccess
                          ? kOnBoardingMarginBetweenFields
                          : 44.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.ticketNumber.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          widget.goldLoanPaymentSummeryArgs.selectAccountEntity.ticketNumber
                              .toString(),
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kOnBoardingMarginBetweenFields,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.creditTo.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.goldLoanPaymentSummeryArgs.selectAccountEntity.accountType
                                  .toString(),
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            Text(
                              widget.goldLoanPaymentSummeryArgs.selectAccountEntity.accountNum
                                  .toString(),
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: kOnBoardingMarginBetweenFields,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        AppString.topUpAmount.localize(context),
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textTitleColor)),
                                TextSpan(
                                    text:
                                        ' (${AppString.lkr.localize(context)})',
                                    style: AppStyling.normal700Size10.copyWith(
                                        color: AppColors.textTitleColor)),
                              ]),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        '${formatCurrency.format(widget.goldLoanPaymentSummeryArgs.amount).split('.')[0]}.',
                                    style: AppStyling.normal500Size16.copyWith(
                                        color: AppColors.textDarkColor)),
                                TextSpan(
                                    text: formatCurrency
                                        .format(widget
                                            .goldLoanPaymentSummeryArgs.amount)
                                        .split('.')[1],
                                    style: AppStyling.normal400Size14.copyWith(
                                        color: AppColors.textDarkColor)),
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),
                        if (isPaymentSuccess)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: AppString.remainingAdvanceLimit
                                          .localize(context),
                                      style: AppStyling.normal600Size14
                                          .copyWith(
                                              color: AppColors.textTitleColor)),
                                  TextSpan(
                                      text:
                                          ' (${AppString.lkr.localize(context)})',
                                      style: AppStyling.normal700Size10
                                          .copyWith(
                                              color: AppColors.textTitleColor)),
                                ]),
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          '${formatCurrency.format(widget.goldLoanPaymentSummeryArgs.goldLoanEntity.remainingAdvanceLimit).split('.')[0]}.',
                                      style: AppStyling.normal500Size16
                                          .copyWith(
                                              color: AppColors.textDarkColor)),
                                  TextSpan(
                                      text: formatCurrency
                                          .format(widget
                                              .goldLoanPaymentSummeryArgs
                                              .goldLoanEntity
                                              .remainingAdvanceLimit)
                                          .split('.')[1],
                                      style: AppStyling.normal400Size14
                                          .copyWith(
                                              color: AppColors.textDarkColor)),
                                ]),
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                    const SizedBox(
                      height: kOnBoardingMarginBetweenFields,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.date.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          formattedTime.toString(),
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kOnBoardingMarginBetweenFields,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.referenceNumber.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          referenceNumber,
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: kLeftRightMarginOnBoarding,
                right: kLeftRightMarginOnBoarding,
              ),
              child: CDBBorderGradientButton(
                width: double.maxFinite,
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, Routes.kGoldLoanPaymentReceipt,
                  //     arguments: widget.goldLoanEntity);
                },
                text: AppString.home.localize(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
