import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/app_styling.dart';
import '../../../../utils/cdb_icons.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import '../../bloc/on_boarding/schedule_verification/schedule_verification_state.dart';
import '../../widgets/cdb_buttons/cdb_flat_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';
import 'data/transaction_history_args.dart';

class TransactionStatusView extends BaseView {
  final TransactionHistoryArgs transactionHistoryArgs;

  const TransactionStatusView({this.transactionHistoryArgs});

  @override
  _TransactionStatusViewState createState() => _TransactionStatusViewState();
}

class _TransactionStatusViewState extends BaseViewState<TransactionStatusView> {
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();
  final formatCurrency = NumberFormat.currency(symbol: '');

  bool isPaymentSuccess = true;
  String payFromName;
  String payToName;
  String payFromRef;
  String payToRef;
  String amount;
  String serviceCharge;
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
    payFromName = 'My Commercial Account';
    payToName = widget.transactionHistoryArgs.heading;
    payFromRef = '********020360580';
    payToRef = widget.transactionHistoryArgs.mobileNumber;
    amount = widget.transactionHistoryArgs.amount.toString();
    serviceCharge = "5";
    date = widget.transactionHistoryArgs.date;
    referenceNumber = '010111123548';
    remark = 'Reload';
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.transactionStatus.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _scheduleVerificationBloc,
        child: BlocListener<ScheduleVerificationBloc,
            BaseState<ScheduleVerificationState>>(
          listener: (context, state) {},
          child: Padding(
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
                                  ? AppString.statusPaymentSuccess
                                      .localize(context)
                                  : AppString.statusPaymentFailed
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
                                title:
                                    AppString.buttonDownload.localize(context),
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
                                AppString.descriptionPaymentFailed
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
                              AppString.payFrom.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  payFromName,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  payFromRef,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.payTo.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  payToName,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  payToRef,
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
                        if (isPaymentSuccess)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppString.amount
                                              .localize(context),
                                          style: AppStyling.normal600Size14
                                              .copyWith(
                                                  color: AppColors
                                                      .textTitleColor)),
                                      TextSpan(
                                          text:
                                              ' (${AppString.lkr.localize(context)})',
                                          style: AppStyling.normal700Size10
                                              .copyWith(
                                                  color: AppColors
                                                      .textTitleColor)),
                                    ]),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              '${formatCurrency.format(double.parse(amount)).split('.')[0]}.',
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor)),
                                      TextSpan(
                                          text: formatCurrency
                                              .format(double.parse(amount))
                                              .split('.')[1],
                                          style: AppStyling.normal400Size14
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppString.serviceCharge
                                              .localize(context),
                                          style: AppStyling.normal600Size14
                                              .copyWith(
                                                  color: AppColors
                                                      .textTitleColor)),
                                      TextSpan(
                                          text:
                                              ' (${AppString.lkr.localize(context)})',
                                          style: AppStyling.normal700Size10
                                              .copyWith(
                                                  color: AppColors
                                                      .textTitleColor)),
                                    ]),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              '${formatCurrency.format(double.parse(serviceCharge)).split('.')[0]}.',
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor)),
                                      TextSpan(
                                          text: formatCurrency
                                              .format(
                                                  double.parse(serviceCharge))
                                              .split('.')[1],
                                          style: AppStyling.normal400Size14
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.date.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                            Text(
                              date,
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
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),
                        if (isPaymentSuccess)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.remarks.localize(context),
                                style: AppStyling.normal600Size14
                                    .copyWith(color: AppColors.textTitleColor),
                              ),
                              Text(
                                remark,
                                style: AppStyling.normal500Size16
                                    .copyWith(color: AppColors.textDarkColor),
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _scheduleVerificationBloc;
  }
}
