import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../domain/entities/response/gold_loan_entity.dart';
import '../../../domain/entities/response/select_account_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/biller_management/biller_management_bloc.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';
import 'gold_loan_payment_summary_view.dart';
import 'select_account_view.dart';

class GoldLoanTopUpView extends BaseView {
  final GoldLoanEntity goldLoanEntity;

  const GoldLoanTopUpView({this.goldLoanEntity, Key key}) : super(key: key);

  @override
  _GoldLoanTopUpViewState createState() => _GoldLoanTopUpViewState();
}

class _GoldLoanTopUpViewState extends BaseViewState<GoldLoanTopUpView> {
  final BillerManagementBloc _bloc = inject<BillerManagementBloc>();

  final formatCurrency = NumberFormat.currency(symbol: '');
  final _formKey = GlobalKey<FormState>();

  double topUpAmount = 0;
  bool overLimit = false;
  bool selectedAccount = false;

  SelectAccountEntity createdAccount;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleGoldLoanTopUp.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                                    style: AppStyling.normal300Size12.copyWith(
                                        color: AppColors.textDarkColor),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    widget.goldLoanEntity.ticketNumber ?? '',
                                    style: AppStyling.normal600Size14.copyWith(
                                        color: AppColors.textDarkColor),
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
                                        AppString.remainingAdvanceLimit
                                            .localize(context),
                                        style: AppStyling.normal300Size12
                                            .copyWith(
                                                color: AppColors.textDarkColor),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            AppString.lkr.localize(context),
                                            style: AppStyling.normal300Size12
                                                .copyWith(
                                                    color: AppColors
                                                        .textDarkColor),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      '${formatCurrency.format(widget.goldLoanEntity.remainingAdvanceLimit).split('.')[0]}.',
                                                  style: AppStyling
                                                      .normal600Size20
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor)),
                                              TextSpan(
                                                  text: formatCurrency
                                                      .format(widget
                                                          .goldLoanEntity
                                                          .remainingAdvanceLimit)
                                                      .split('.')[1],
                                                  style: AppStyling
                                                      .normal300Size15
                                                      .copyWith(
                                                          color: AppColors
                                                              .blackColor)),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kLeftRightMarginOnBoarding,
                        right: kLeftRightMarginOnBoarding,
                      ),
                      child: CdbCustomTextField(
                        validator: (value) {
                          if (topUpAmount >
                              widget.goldLoanEntity.remainingAdvanceLimit) {
                            overLimit = true;
                            return AppString.goldLoanTopUpAmountError
                                .localize(context);
                          } else {
                            overLimit = false;
                          }
                          return null;
                        },
                        isCurrency: true,
                        showCurrencySymbol: false,
                        textInputType: TextInputType.number,
                        labelText:
                            AppString.goldLoanTopUpAmountHint.localize(context),
                        onChange: (value) {
                          String val = value.toString();
                          double ss = double.parse(val.replaceAll(",", ""));
                          debugPrint(ss.toString());
                          setState(() {
                            topUpAmount = ss;
                          });
                          if (_formKey.currentState.validate()) {}
                        },
                        fontStyle: overLimit
                            ? const TextStyle(color: Colors.red)
                            : null,
                        // isCurrency: true,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kLeftRightMarginOnBoarding,
                        right: kLeftRightMarginOnBoarding,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 0.5, color: AppColors.darkAshColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x1F000000),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.kGoldLoadSelectAccount,
                                  arguments: SelectAccountViewParam(
                                      isSerchable: true,
                                      selectedAccount: (value) {
                                        if (value != null) {
                                          setState(() {
                                            selectedAccount = true;
                                            createdAccount = value;
                                          });
                                          debugPrint(
                                              createdAccount.accountName);
                                          Navigator.pop(context);
                                        }
                                      }),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppColors.errorRedColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x1F000000),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Change account to be created",
                                              style: AppStyling.normal400Size14
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.navigate_next,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (selectedAccount)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "The account to be created",
                                          style: AppStyling.normal400Size14
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Text(
                                            createdAccount.accountType,
                                            style: AppStyling.normal500Size16
                                                .copyWith(
                                                    color: AppColors
                                                        .textDarkColor),
                                          ),
                                        ),
                                        Text(
                                          createdAccount.accountNum,
                                          style: AppStyling.normal500Size16
                                              .copyWith(
                                                  color:
                                                      AppColors.textDarkColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(AppImages.cdbBankLogo,
                                            fit: BoxFit.scaleDown,
                                            height: 16.15),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              AppString.accountBalance
                                                  .localize(context),
                                              style: AppStyling.normal300Size12
                                                  .copyWith(
                                                      color: AppColors
                                                          .textDarkColor),
                                            ),
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      "(${AppString.lkr.localize(context)})",
                                                  style: AppStyling
                                                      .normal700Size10
                                                      .copyWith(
                                                          color: AppColors
                                                              .textDarkColor),
                                                ),
                                                TextSpan(
                                                    text:
                                                        '${formatCurrency.format(createdAccount.accountBalance).split('.')[0]}.',
                                                    style: AppStyling
                                                        .normal500Size16
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor)),
                                                TextSpan(
                                                    text: formatCurrency
                                                        .format(createdAccount
                                                            .accountBalance)
                                                        .split('.')[1],
                                                    style: AppStyling
                                                        .normal400Size14
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor)),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            else
                              SizedBox(),
                          ],
                        ),
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
                    status: topUpAmount > 0 &&
                            widget.goldLoanEntity.remainingAdvanceLimit >= topUpAmount &&
                            createdAccount != null
                        ? ButtonStatus.ENABLE
                        : ButtonStatus.DISABLE,
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        Navigator.pushNamed(
                          context,
                          Routes.kGoldLoanPaymentSummaryView,
                          arguments: GoldLoanPaymentSummeryArgs(
                            goldLoanEntity: widget.goldLoanEntity,
                            amount: topUpAmount,
                            selectAccountEntity: createdAccount,
                          ),
                        );
                      }
                    },
                    text: AppString.topUp.localize(context),
                  ),
                  CDBNoBorderBackgroundButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    status: !widget.goldLoanEntity.isActive ||
                            widget.goldLoanEntity.remainingAdvanceLimit == 0
                        ? ButtonStatus.DISABLE
                        : ButtonStatus.ENABLE,
                    text: AppString.cancel.localize(context),
                  ),
                ],
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
