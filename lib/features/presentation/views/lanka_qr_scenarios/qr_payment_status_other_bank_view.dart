import 'package:cdb_mobile/utils/navigation_routes.dart';
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
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_flat_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';

class QRPaymentStatusOtherBankView extends BaseView {
  @override
  _QRPaymentStatusOtherBankViewState createState() =>
      _QRPaymentStatusOtherBankViewState();
}

class _QRPaymentStatusOtherBankViewState
    extends BaseViewState<QRPaymentStatusOtherBankView> {
  /// Dependency Injection
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();
  final formatCurrency = NumberFormat.currency(symbol: '');

  ///Veriable
  bool isPaymentSuccess = true;
  String payFromName;
  String payToName;
  String payFromRef;
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
    payFromName = '********000568215';
    payToName = 'Galle-01';
    payFromRef = 'CDB Salary Plus';
    payToRef = 'Cargills Food City';
    amount = 3000;
    serviceCharge = 5;
    date = '16-November-2021';
    referenceNumber = '010111123548';
    remark = 'Grocery items from food city';
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.qrPaymentStatusTitle.localize(context),
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
                        if (!isPaymentSuccess)
                          Center(
                            child: Text(
                                AppString.descriptionPaymentFailed
                                    .localize(context),
                                style: AppStyling.normal600Size14
                                    .copyWith(color: AppColors.textTitleColor)),
                          ),
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
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
                                  payFromRef,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  payFromName,
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
                                  payToRef,
                                  style: AppStyling.normal500Size16
                                      .copyWith(color: AppColors.textDarkColor),
                                ),
                                Text(
                                  payToName,
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
                                              '${formatCurrency.format(serviceCharge).split('.')[0]}.',
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor)),
                                      TextSpan(
                                          text: formatCurrency
                                              .format(serviceCharge)
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
                        if (isPaymentSuccess)
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
                      CDBBorderGradientButton(
                        width: double.maxFinite,
                        onTap: () {},
                        text: isPaymentSuccess
                            ? AppString.home.localize(context)
                            : AppString.tryAgain.localize(context),
                      ),
                      if (!isPaymentSuccess)
                        CDBNoBorderBackgroundButton(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.kHomeView);
                          },
                          text: AppString.home.localize(context),
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
