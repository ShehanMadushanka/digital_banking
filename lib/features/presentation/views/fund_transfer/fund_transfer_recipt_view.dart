import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/domain/entities/response/fund_transfer_entity.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/biller_management/biller_management_bloc.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_flat_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_no_border_background_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_scrollview.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_strings.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/cdb_icons.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FundTransferReceiptView extends BaseView {
  final FundTransferEntity fundTransferEntity;
  const FundTransferReceiptView({this.fundTransferEntity,Key key}) : super(key: key);

  @override
  _FundTransferReceiptViewState createState() =>
      _FundTransferReceiptViewState();
}

class _FundTransferReceiptViewState
    extends BaseViewState<FundTransferReceiptView> {
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
        appBarTitle: AppString.fundTransferStatusTitle.localize(context),
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
                              ? AppString.fundTransferSuccessful
                              .localize(context)
                              : AppString.fundTransferFailure
                              .localize(context),
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                      ],
                    ),
                    if (isPaymentSuccess)
                      const SizedBox.shrink()
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 23.0),
                        child: Center(
                          child: Text(
                              AppString.loanPaymentReceiptFailDescription
                                  .localize(context),
                              style: AppStyling.normal600Size14
                                  .copyWith(color: AppColors.textTitleColor)),
                        ),
                      ),
                    const SizedBox(
                      height: kOnBoardingMarginBetweenFields,
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
                              widget.fundTransferEntity.bankName,
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.textDarkColor),
                            ),
                            Text(
                              widget.fundTransferEntity.accountNumber.toString(),
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
                          AppString.fundTransferPaidTo.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          widget.fundTransferEntity.payTo.toString(),
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
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: AppString.fundTransferAmount
                                    .localize(context),
                                style: AppStyling.normal600Size14
                                    .copyWith(color: AppColors.textTitleColor)),
                            TextSpan(
                                text: ' (${AppString.lkr.localize(context)})',
                                style: AppStyling.normal700Size10
                                    .copyWith(color: AppColors.textTitleColor)),
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                '${formatCurrency.format(double.parse(widget.fundTransferEntity.amount)).split('.')[0]}.',
                                style: AppStyling.normal500Size16
                                    .copyWith(color: AppColors.textDarkColor)),
                            TextSpan(
                                text:
                                formatCurrency.format(double.parse(widget.fundTransferEntity.amount)).split('.')[1],
                                style: AppStyling.normal400Size14
                                    .copyWith(color: AppColors.textDarkColor)),
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
                                  text: AppString.fundTransferServiceCharge
                                      .localize(context),
                                  style: AppStyling.normal600Size14.copyWith(
                                      color: AppColors.textTitleColor)),
                              TextSpan(
                                  text: ' (${AppString.lkr.localize(context)})',
                                  style: AppStyling.normal700Size10.copyWith(
                                      color: AppColors.textTitleColor)),
                            ]),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                  '${formatCurrency.format(2458783).split('.')[0]}.',
                                  style: AppStyling.normal500Size16.copyWith(
                                      color: AppColors.textDarkColor)),
                              TextSpan(
                                  text: formatCurrency
                                      .format(2458783)
                                      .split('.')[1],
                                  style: AppStyling.normal400Size14.copyWith(
                                      color: AppColors.textDarkColor)),
                            ]),
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
                          AppString.fundTransferTransactionCategory
                              .localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          widget.fundTransferEntity.transactionCategory,
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
                        Expanded(
                          child: Text(
                            AppString.fundTransferReference.localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.fundTransferEntity.reference,
                            textAlign: TextAlign.end,
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.textDarkColor),
                          ),
                        )
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
                            AppString.fundTransferRemark.localize(context),
                            style: AppStyling.normal600Size14
                                .copyWith(color: AppColors.textTitleColor),
                          ),
                          Text(
                            widget.fundTransferEntity.remark,
                            style: AppStyling.normal500Size16
                                .copyWith(color: AppColors.textDarkColor),
                          )
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
                          AppString.fundTransferEmail.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          widget.fundTransferEntity.beneficiaryEmail,
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
                          AppString.fundTransferMobile.localize(context),
                          style: AppStyling.normal600Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),
                        Text(
                          widget.fundTransferEntity.beneficiaryMobile,
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
                          AppString.fundTransferDate.localize(context),
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
                          AppString.fundTransferReferenceId.localize(context),
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
                    SizedBox(
                      height: isPaymentSuccess
                          ? kOnBoardingMarginBetweenFields
                          : 44.h,
                    ),
                    if (isPaymentSuccess)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CDBFlatButton(
                            title: AppString.buttonDownload.localize(context),
                            icon: CDBIcons.ic_download,
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          CDBFlatButton(
                            title: AppString.buttonShare.localize(context),
                            icon: CDBIcons.ic_share,
                            onTap: () {},
                          ),
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            if (isPaymentSuccess)
              Column(
                children: [
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
                      text: AppString.fundTransferSavePayees.localize(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: kLeftRightMarginOnBoarding,
                      right: kLeftRightMarginOnBoarding,
                    ),
                    child: CDBNoBorderBackgroundButton(
                      // width: double.maxFinite,
                      onTap: () {
                        // Navigator.pushNamed(
                        //     context, Routes.kGoldLoanPaymentReceipt,
                        //     arguments: widget.goldLoanEntity);
                      },
                      text: AppString.home.localize(context),
                    ),
                  ),
                ],
              )
            else
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
