import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import '../../bloc/on_boarding/schedule_verification/schedule_verification_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';

class QrPaymentSummaryView extends BaseView {
  const QrPaymentSummaryView({Key key}) : super(key: key);

  @override
  _QrPaymentSummaryViewState createState() => _QrPaymentSummaryViewState();
}

class _QrPaymentSummaryViewState extends State<QrPaymentSummaryView> {
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();
  final formatCurrency = NumberFormat.currency(symbol: '');

  ///Veriable
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
    payToName = 'Cargills Food City';
    payToRef = 'Galle - 01';
    amount = 3000;
    serviceCharge = 5;
    date = '16-November-2021';
    referenceNumber = '010111123548';
    remark = 'Grocery items from food city';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleQrPaymentSummary.localize(context),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.payFrom.localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        PayFromSummaryCard(),
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
                                              '${formatCurrency.format(amount).split('.')[0]}.',
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor)),
                                      TextSpan(
                                          text: formatCurrency
                                              .format(amount)
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
                        text: AppString.confirm.localize(context),
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
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _scheduleVerificationBloc;
  }
}

class PayFromSummaryCard extends StatelessWidget {
  String nickName = 'My Commercial';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25, top: 25),
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
                      AppString.instrumentNickname.localize(context),
                      style: AppStyling.normal600Size14
                          .copyWith(color: AppColors.textTitleColor),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      nickName,
                      style: AppStyling.normal500Size16
                          .copyWith(color: AppColors.textDarkColor),
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
