import 'package:cdb_mobile/features/presentation/views/otp/otp_view.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/dependency_injection.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../../utils/enums.dart';
import '../../../domain/entities/response/fund_transfer_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/payee_management/payee_management_bloc.dart';
import '../../bloc/payee_management/payee_management_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';
import 'widget/ft_summery_data_component.dart';

class FundTransferSummaryView extends BaseView {
  final FundTransferEntity fundTransferEntity;

  FundTransferSummaryView({this.fundTransferEntity});

  @override
  _FundTransferSummaryViewState createState() =>
      _FundTransferSummaryViewState();
}

class _FundTransferSummaryViewState
    extends BaseViewState<FundTransferSummaryView> {
  final PayeeManagementBloc _bloc = inject<PayeeManagementBloc>();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.fundTransferSummeryTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _bloc,
        child:
            BlocListener<PayeeManagementBloc, BaseState<PayeeManagementState>>(
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
                          isInsideMarginAvailable: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FTSummeryDataComponent(
                                title: AppString.payFrom.localize(context),
                                data: widget.fundTransferEntity.bankName,
                                subData:
                                    widget.fundTransferEntity.accountNumber,
                              ),
                              FTSummeryDataComponent(
                                title: AppString.payTo.localize(context),
                                data: widget.fundTransferEntity.payTo.nickName,
                                subData: widget
                                    .fundTransferEntity.payTo.accountNumber,
                              ),
                              FTSummeryDataComponent(
                                title: AppString.amount.localize(context),
                                amount: double.parse(
                                    widget.fundTransferEntity.amount),
                                isCurrency: true,
                              ),
                              FTSummeryDataComponent(
                                title:
                                    AppString.serviceCharge.localize(context),
                                amount: 100,
                                isCurrency: true,
                              ),
                              if (widget.fundTransferEntity.fundTransferType ==
                                  FTType.SCHEDULED)
                                Column(
                                  children: [
                                    FTSummeryDataComponent(
                                      title: AppString.scheduleType
                                          .localize(context),
                                      data: widget
                                          .fundTransferEntity.scheduleType,
                                    ),
                                    FTSummeryDataComponent(
                                      title:
                                          AppString.startDate.localize(context),
                                      data: widget.fundTransferEntity.startDate,
                                    ),
                                    FTSummeryDataComponent(
                                      title:
                                          AppString.frequency.localize(context),
                                      data: widget
                                          .fundTransferEntity.scheduleFrequency,
                                    ),
                                    FTSummeryDataComponent(
                                      title:
                                          AppString.endDate.localize(context),
                                      data: widget.fundTransferEntity.endDate,
                                    ),
                                    FTSummeryDataComponent(
                                      title: AppString.noOfTransfers
                                          .localize(context),
                                      data: '12',
                                    ),
                                  ],
                                )
                              else
                                const SizedBox.shrink(),
                              FTSummeryDataComponent(
                                title: AppString.transactionCategory
                                    .localize(context),
                                data: widget
                                    .fundTransferEntity.transactionCategory,
                              ),
                              FTSummeryDataComponent(
                                title: AppString.reference.localize(context),
                                data: widget.fundTransferEntity.reference,
                              ),
                              FTSummeryDataComponent(
                                title: AppString.remark.localize(context),
                                data: widget.fundTransferEntity.remark,
                              ),
                              FTSummeryDataComponent(
                                title: AppString.benefEmail.localize(context),
                                data:
                                    widget.fundTransferEntity.beneficiaryEmail,
                              ),
                              FTSummeryDataComponent(
                                title: AppString.benefMobile.localize(context),
                                data:
                                    widget.fundTransferEntity.beneficiaryMobile,
                              ),
                              if (widget.fundTransferEntity.fundTransferType ==
                                  FTType.SCHEDULED)
                                const SizedBox.shrink()
                              else
                                Container(
                                  color: AppColors.lightBlueColor,
                                  padding: const EdgeInsets.only(
                                    top: 14,
                                  ),
                                  child: Column(
                                    children: [
                                      FTSummeryDataComponent(
                                        title: AppString.balanceBeforeTransfer
                                            .localize(context),
                                        amount: 520000,
                                        isCurrency: true,
                                      ),
                                      FTSummeryDataComponent(
                                        title: AppString.balanceAfterTransfer
                                            .localize(context),
                                        amount: 499900,
                                        isCurrency: true,
                                      ),
                                    ],
                                  ),
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
                              onTap: () async {
                                final _otpResult = await Navigator.pushNamed(
                                        context, Routes.kCommonOTPView,
                                        arguments: OTPViewArgs(
                                            otpType: kOtpMessageTypeBillPayment,
                                            requestOTP: true)) as bool;

                                if (_otpResult) {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.kFundTransferReceiptView,
                                      arguments: widget.fundTransferEntity);
                                }
                              },
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
            );
          }),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
