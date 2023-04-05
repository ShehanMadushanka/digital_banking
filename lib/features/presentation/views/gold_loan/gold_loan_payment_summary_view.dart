import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/gold_loan_entity.dart';
import '../../../domain/entities/response/select_account_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/language/language_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../base_view.dart';

class GoldLoanPaymentSummeryArgs {
  final GoldLoanEntity goldLoanEntity;
  final double amount;
  final SelectAccountEntity selectAccountEntity;

  GoldLoanPaymentSummeryArgs({this.goldLoanEntity, this.amount, this.selectAccountEntity});
}

class GoldLoanPaymentSummaryView extends BaseView {
  GoldLoanPaymentSummeryArgs goldLoanPaymentSummeryArgs;

  GoldLoanPaymentSummaryView({this.goldLoanPaymentSummeryArgs, Key key})
      : super(key: key);

  @override
  _GoldLoanPaymentSummaryViewState createState() =>
      _GoldLoanPaymentSummaryViewState();
}

class _GoldLoanPaymentSummaryViewState
    extends BaseViewState<GoldLoanPaymentSummaryView> {
  final _bloc = inject<LanguageBloc>();
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
          appBarTitle: AppString.loanPaymentSummaryTitle.localize(context),
          onTapBack: () {
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: kLeftRightMarginOnBoarding,
            right: kLeftRightMarginOnBoarding,
            top: 25,
            bottom: kBottomMargin,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.ticketNumber.localize(context),
                    style: AppStyling.normal600Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                  Text(
                    // widget.goldLoanEntity.ticketNumber ?? "",
                    widget.goldLoanPaymentSummeryArgs.selectAccountEntity.ticketNumber.toString(),
                    style: AppStyling.normal500Size16.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.creditTo.localize(context),
                    style: AppStyling.normal600Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(children: [
                      TextSpan(
                          text: '${widget.goldLoanPaymentSummeryArgs.selectAccountEntity.accountType
                              .toString()}\n',
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.blackColor)),
                      TextSpan(
                          text: widget.goldLoanPaymentSummeryArgs.selectAccountEntity.accountNum
                              .toString(),
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.blackColor)),
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.topUpAmount.localize(context),
                    style: AppStyling.normal600Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              '${formatCurrency.format(widget.goldLoanPaymentSummeryArgs.amount).split('.')[0]}.',
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.blackColor)),
                      TextSpan(
                          text: formatCurrency
                              .format(
                              widget.goldLoanPaymentSummeryArgs.amount)
                              .split('.')[1],
                          style: AppStyling.normal300Size12
                              .copyWith(color: AppColors.blackColor)),
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.remainingAdvanceLimit.localize(context),
                    style: AppStyling.normal600Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              '${formatCurrency.format(widget.goldLoanPaymentSummeryArgs.goldLoanEntity.remainingAdvanceLimit).split('.')[0]}.',
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.blackColor)),
                      TextSpan(
                          text: formatCurrency
                              .format(
                              widget.goldLoanPaymentSummeryArgs.goldLoanEntity.remainingAdvanceLimit)
                              .split('.')[1],
                          style: AppStyling.normal300Size12
                              .copyWith(color: AppColors.blackColor)),
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.summaryDate.localize(context),
                    style: AppStyling.normal600Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                  Text(
                    formattedTime.toString(),
                    style: AppStyling.normal500Size16.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.referenceNumber.localize(context),
                    style: AppStyling.normal600Size14.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                  Text(
                    "111111111",
                    style: AppStyling.normal500Size16.copyWith(
                      color: AppColors.textDarkColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  CDBBorderGradientButton(
                    width: double.maxFinite,
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.kGoldLoanPaymentReceipt,
                          arguments: widget.goldLoanPaymentSummeryArgs);
                    },
                    text: AppString.confirm.localize(context),
                  ),
                  CDBNoBorderBackgroundButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    text: AppString.cancel.localize(context),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
