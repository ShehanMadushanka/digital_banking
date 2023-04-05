import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../domain/entities/response/gold_loan_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_info_icon_view.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';

class LoanDetailsView extends BaseView {
  final GoldLoanEntity goldLoanEntity;

  const LoanDetailsView({this.goldLoanEntity});

  @override
  _LoanDetailsViewState createState() => _LoanDetailsViewState();
}

class _LoanDetailsViewState extends BaseViewState<LoanDetailsView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  final formatCurrency = NumberFormat.currency(symbol: '');
  bool isExpanded = false;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleLoanDetails.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.lightBlueColor,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.ticketNumber.localize(context),
                          style: AppStyling.normal300Size12
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.goldLoanEntity.ticketNumber ?? '',
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ],
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppString.outstandingAmount.localize(context),
                              style: AppStyling.normal300Size12
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppString.lkr.localize(context),
                                  style: AppStyling.normal300Size12
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            '${formatCurrency.format(widget.goldLoanEntity.outstandingAmount).split('.')[0]}.',
                                        style: AppStyling.normal600Size20
                                            .copyWith(
                                                color: AppColors.blackColor)),
                                    TextSpan(
                                        text: formatCurrency
                                            .format(widget.goldLoanEntity
                                                .outstandingAmount)
                                            .split('.')[1],
                                        style: AppStyling.normal300Size15
                                            .copyWith(
                                                color: AppColors.blackColor)),
                                  ]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              AppString.additionalChargesApplied
                                  .localize(context),
                              style: AppStyling.normal300Size10
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.goldLoanEntity.isActive)
                  const SizedBox.shrink()
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CdbInfoIconView(
                          color: AppColors.errorRedColor,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: Text(
                            AppString.auctionError.localize(context),
                            maxLines: 2,
                            style: AppStyling.normal300Size13
                                .copyWith(color: AppColors.errorRedColor),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
          Theme(
            data: ThemeData.light().copyWith(
              highlightColor: AppColors.darkGray,
              disabledColor: AppColors.whiteColor,
            ),
            child: ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 500),
              dividerColor: AppColors.darkAshColor,
              elevation: 0,
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: AppColors.darkGray,
                  isExpanded: isExpanded,
                  body: Column(
                    children: widget.goldLoanEntity.articleDetailList
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 16),
                            color: AppColors.separationLinesColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.title,
                                  style: AppStyling.normal600Size14
                                      .copyWith(color: AppColors.disableGray),
                                ),
                                Text(
                                  e.title,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      color: AppColors.darkGray,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Text(
                        AppString.articleDetails.localize(context),
                        style: AppStyling.normal500Size16
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    );
                  },
                ),
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  isExpanded = !status;
                });
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: CDBScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.status.localize(context),
                        style: AppStyling.normal600Size14
                            .copyWith(color: AppColors.textTitleColor),
                      ),
                      Text(
                        widget.goldLoanEntity.isActive
                            ? AppString.active.localize(context)
                            : AppString.auction.localize(context),
                        style: AppStyling.normal500Size16.copyWith(
                            color: widget.goldLoanEntity.isActive
                                ? AppColors.successGreenColor
                                : AppColors.errorRedColor),
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
                        AppString.loanPeriodInMonths.localize(context),
                        style: AppStyling.normal600Size14
                            .copyWith(color: AppColors.textTitleColor),
                      ),
                      Text(
                        widget.goldLoanEntity.loanPeriodsInMonths.toString(),
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
                        AppString.expiryDate.localize(context),
                        style: AppStyling.normal600Size14
                            .copyWith(color: AppColors.textTitleColor),
                      ),
                      Text(
                        widget.goldLoanEntity.expireDate,
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            AppString.interestBalance.localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '(${AppString.lkr.localize(context)})',
                            style: AppStyling.normal700Size10
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  '${formatCurrency.format(widget.goldLoanEntity.interestBalance).split('.')[0]}.',
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor)),
                          TextSpan(
                              text: formatCurrency
                                  .format(widget.goldLoanEntity.interestBalance)
                                  .split('.')[1],
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor)),
                        ]),
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            AppString.maximumAdvanceLimit.localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '(${AppString.lkr.localize(context)})',
                            style: AppStyling.normal700Size10
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  '${formatCurrency.format(widget.goldLoanEntity.maximumAdvanceLimit).split('.')[0]}.',
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor)),
                          TextSpan(
                              text: formatCurrency
                                  .format(
                                      widget.goldLoanEntity.maximumAdvanceLimit)
                                  .split('.')[1],
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor)),
                        ]),
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            AppString.capitalBalance.localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '(${AppString.lkr.localize(context)})',
                            style: AppStyling.normal700Size10
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  '${formatCurrency.format(widget.goldLoanEntity.capitalBalance).split('.')[0]}.',
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor)),
                          TextSpan(
                              text: formatCurrency
                                  .format(widget.goldLoanEntity.capitalBalance)
                                  .split('.')[1],
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor)),
                        ]),
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          Text(
                            AppString.remainingAdvanceLimit.localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '(${AppString.lkr.localize(context)})',
                            style: AppStyling.normal700Size10
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text:
                                  '${formatCurrency.format(widget.goldLoanEntity.remainingAdvanceLimit).split('.')[0]}.',
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor)),
                          TextSpan(
                              text: formatCurrency
                                  .format(widget
                                      .goldLoanEntity.remainingAdvanceLimit)
                                  .split('.')[1],
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textDarkColor)),
                        ]),
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
            child: Column(
              children: [
                if (widget.goldLoanEntity.isActive &&
                    (widget.goldLoanEntity.remainingAdvanceLimit == 0 ||
                        !widget.goldLoanEntity.isTopUpAvailable))
                  !widget.goldLoanEntity.isTopUpAvailable
                      ? _topUpUnavailableWidget()
                      : _noRemainingAdvanceLimitWidget()
                else
                  const SizedBox.shrink(),
                CDBBorderGradientButton(
                  width: double.maxFinite,
                  status: widget.goldLoanEntity.isActive
                      ? ButtonStatus.ENABLE
                      : ButtonStatus.DISABLE,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.kGoldLoanPaymentView);
                  },
                  text: AppString.makeAPayment.localize(context),
                ),
                CDBNoBorderBackgroundButton(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      Routes.kGoldLoanTopUpView,
                      arguments: widget.goldLoanEntity
                    );
                  },
                  status: !widget.goldLoanEntity.isActive ||
                          widget.goldLoanEntity.remainingAdvanceLimit == 0
                      ? ButtonStatus.DISABLE
                      : ButtonStatus.ENABLE,
                  text: AppString.makeATopUp.localize(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _noRemainingAdvanceLimitWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CdbInfoIconView(
            color: AppColors.primaryColor,
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            child: Text(
              AppString.noRemainingLimitTopUp.localize(context),
              maxLines: 2,
              style: AppStyling.normal600Size14
                  .copyWith(color: AppColors.textDarkColor),
            ),
          )
        ],
      ),
    );
  }

  Padding _topUpUnavailableWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CdbInfoIconView(
            color: AppColors.primaryColor,
          ),
          const SizedBox(
            width: 7,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: AppString.noTopUpThisMonth.localize(context),
                  style: AppStyling.normal400Size14
                      .copyWith(color: AppColors.textDarkColor),
                ),
                TextSpan(
                    text: widget.goldLoanEntity.nextTopUpDate ?? '',
                    style: AppStyling.normal600Size14
                        .copyWith(color: AppColors.blackColor)),
              ]),
            ),
          )
        ],
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
