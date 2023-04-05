import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/emp_detail_request.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../data/models/responses/city_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../bloc/on_boarding/user_other_info/user_other_info_bloc.dart';
import '../../bloc/on_boarding/user_other_info/user_other_info_event.dart';
import '../../bloc/on_boarding/user_other_info/user_other_info_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_check_box_view.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../../widgets/cdb_radio_button.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class UserOtherInformationView extends BaseView {
  final bool isEditingEnabled;

  const UserOtherInformationView({Key key, this.isEditingEnabled = false})
      : super(key: key);

  @override
  _UserOtherInformationViewState createState() =>
      _UserOtherInformationViewState();
}

class _UserOtherInformationViewState
    extends BaseViewState<UserOtherInformationView> {
  final UserOtherInformationBloc _userOtherInformationBloc =
      inject<UserOtherInformationBloc>();
  String politicalExposed,
      purpose,
      sourceOfFunds,
      transactionMode,
      depositPerMonth,
      referenceCode,
      initialReferenceCode,
      initialDepositPerMonth,
      taxPayeeInUs;
  bool isInvolvedPolitics = false;
  bool isHoldingPosition = false;
  bool isMemberOfCabinet = false;

  EmpDetailRequest _initialData;

  @override
  void initState() {
    _userOtherInformationBloc.add(GetUserOtherInformationEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditingEnabled
          ? CDBProgressAppBar(
              step: KYCStep.OTHERINFO,
              onTapBack: _handleBackClick,
              showStep: false,
            )
          : CDBProgressAppBar(
              step: KYCStep.OTHERINFO,
              onTapBack: _handleBackClick,
            ),
      body: BlocProvider(
        create: (_) => _userOtherInformationBloc,
        child: BlocListener<UserOtherInformationBloc,
            BaseState<UserOtherInfoState>>(
          listener: (context, state) {
            if (state is UserOtherInfoFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            } else if (state is UserOtherInfoLoadedState) {
              getDataFromSource(state.walletOnBoardingData);
            } else if (state is UserOtherInfoSubmittedSuccessState) {
              // if(state.isBackButtonClick) {
              //   Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              // } else {
              //   _userOtherInformationBloc.add(SubmitOtherAndEmpDetailsEvent());
              // }
              if (state.isBackButtonClick) {
                Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              } else {
                if (widget.isEditingEnabled) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pushReplacementNamed(
                      context, Routes.kDocumentVerificationView,
                      arguments: false);
                }
              }
            } else if (state is SuccessSubmitOtherDetailsAndEmpInfo) {
              storeDataAndStepperValue(
                  isBackButtonClick: false,
                  stepName: widget.isEditingEnabled
                      ? KYCStep.REVIEW.toString()
                      : KYCStep.DOCUMENTVERIFY.toString(),
                  stepVal: widget.isEditingEnabled
                      ? KYCStep.REVIEW.getStep()
                      : KYCStep.DOCUMENTVERIFY.getStep());
              // if(widget.isEditingEnabled) {
              //   Navigator.pop(context, true);
              // } else {
              //   Navigator.pushReplacementNamed(context, Routes.kDocumentVerificationView, arguments: false);
              // }
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              _handleBackClick();
              return false;
            },
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CdbCustomRadioButton(
                            onTapIcon: () {},
                            key: Key(politicalExposed ?? "politicalExposed"),
                            initialValue: politicalExposed,
                            isInfoIcon: true,
                            radioLabel:
                                AppString.politicallyExposed.localize(context),
                            radioButtonDataList: List.from([
                              RadioButtonModel(
                                  label: AppString.yes.localize(context),
                                  value: "true"),
                              RadioButtonModel(
                                  label: AppString.no.localize(context),
                                  value: "false"),
                            ]),
                            onChange: (value) {
                              setState(() {
                                politicalExposed = value;
                              });
                            },
                          ),
                          if (politicalExposed == "true")
                            const SizedBox(
                              height: kOnBoardingMarginBetweenFields,
                            )
                          else
                            Container(),
                          if (politicalExposed == "true")
                            Text(
                              AppString.politicalExposure.localize(context),
                              style: AppStyling.normal400Size14
                                  .copyWith(color: AppColors.textTitleColor),
                            )
                          else
                            Container(),
                          if (politicalExposed == "true")
                            Column(
                              children: [
                                SizedBox(
                                  height: 8.h,
                                ),
                                CdbCheckBoxView(
                                  label: AppString.involvedInPolitics
                                      .localize(context),
                                  value: isInvolvedPolitics,
                                  onTap: () {
                                    setState(() {
                                      isInvolvedPolitics = !isInvolvedPolitics;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                CdbCheckBoxView(
                                  label: AppString.holdingPosition
                                      .localize(context),
                                  value: isHoldingPosition,
                                  onTap: () {
                                    setState(() {
                                      isHoldingPosition = !isHoldingPosition;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                CdbCheckBoxView(
                                  label: AppString.memberParliament
                                      .localize(context),
                                  value: isMemberOfCabinet,
                                  onTap: () {
                                    setState(() {
                                      isMemberOfCabinet = !isMemberOfCabinet;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: kOnBoardingMarginBetweenFields,
                                ),
                              ],
                            ),
                          CdbDropDown(
                            key: Key("${purpose}purpose"),
                            initialValue: purpose,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.purposeAccountOpening
                                .localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.purposeAccountOpening
                                      .localize(context),
                                  isSearchable: true,
                                  dropDownEvent:
                                      GetPurposeOfAccountDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;
                              setState(() {
                                purpose = result.description;
                              });
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomRadioButton(
                            onTapIcon: () {},
                            isInfoIcon: true,
                            initialValue: taxPayeeInUs,
                            radioLabel: AppString.taxPayerUsa.localize(context),
                            radioButtonDataList: List.from([
                              RadioButtonModel(
                                  label: AppString.yes.localize(context),
                                  value: "true"),
                              RadioButtonModel(
                                  label: AppString.no.localize(context),
                                  value: "false"),
                            ]),
                            onChange: (value) {
                              setState(() {
                                taxPayeeInUs = value;
                              });
                            },
                          ),
                          CdbDropDown(
                            key: Key("${sourceOfFunds}sourceFunds" ??
                                "sourceOfFunds"),
                            initialValue: sourceOfFunds,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText:
                                AppString.sourceOfFunds.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle:
                                      AppString.sourceOfFunds.localize(context),
                                  isSearchable: true,
                                  dropDownEvent:
                                      GetSourceOfFundsDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;
                              setState(() {
                                sourceOfFunds = result.description;
                              });
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbDropDown(
                            key: Key("${transactionMode}transMode" ??
                                "transactionMode"),
                            initialValue: transactionMode,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText:
                                AppString.transactionMode.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.transactionMode
                                      .localize(context),
                                  isSearchable: true,
                                  dropDownEvent:
                                      GetTransactionModeDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;
                              setState(() {
                                transactionMode = result.description;
                              });
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key("${initialDepositPerMonth}initialDep" ??
                                "initialDepositPerMonth"),
                            initialValue: depositPerMonth,
                            textInputType: TextInputType.number,
                            isCurrency: true,
                            labelText:
                                AppString.anticipatedDeposits.localize(context),
                            onChange: (value) {
                              setState(() {
                                depositPerMonth = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key(initialReferenceCode ?? "referenceCode"),
                            initialValue: referenceCode,
                            labelText:
                                AppString.marketingReference.localize(context),
                            onChange: (value) {
                              setState(() {
                                referenceCode = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
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
                          status: isValidated()
                              ? ButtonStatus.ENABLE
                              : ButtonStatus.DISABLE,
                          onTap: _onTap,
                          text: widget.isEditingEnabled
                              ? 'Save and Review'
                              : AppString.next.localize(context),
                        ),
                        CDBNoBorderBackgroundButton(
                          onTap: _handleBackClick,
                          text: widget.isEditingEnabled
                              ? 'Go Back to Review'
                              : AppString.completeLater.localize(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Handle Back Click
  void _handleBackClick() {
    if (widget.isEditingEnabled) {
      if (politicalExposed != _initialData.isPoliticallyExposed ||
          purpose != _initialData.purposeOfAcc ||
          transactionMode != _initialData.expectedTransactionMode ||
          depositPerMonth != _initialData.anticipatedDepositPerMonth ||
          initialDepositPerMonth != _initialData.anticipatedDepositPerMonth ||
          referenceCode != _initialData.marketingRefCode ||
          initialReferenceCode != _initialData.marketingRefCode ||
          sourceOfFunds != _initialData.sourceOfIncome ||
          taxPayeeInUs != _initialData.isTaxPayerUs) {
        showCDBDialog(
          title: 'Changes will be Lost',
          isTwoButton: true,
          body: Column(
            children: const [
              Text(
                  'We noticed you changed something.\nWant to go back without saving your changes ?'),
            ],
          ),
          negativeButtonText: AppString.cancel.localize(context),
          negativeButtonTap: () {},
          positiveButtonText: 'Yes, Go Back',
          positiveButtonTap: () async {
            Navigator.pop(context, false);
          },
        );
      } else {
        Navigator.pop(context, false);
      }
    } else {
      showCDBDialog(
        title: AppString.leaveRegForm.localize(context),
        isTwoButton: true,
        body: Column(
          children: const [
            Text(
                'Do you want to leave the registration form? \n\nNote: All the data that you entered will be saved. You can continue from where you left at later convenient time.'),
          ],
        ),
        negativeButtonText: AppString.cancel.localize(context),
        negativeButtonTap: () {},
        positiveButtonText: AppString.saveExit.localize(context),
        positiveButtonTap: () {
          storeDataAndStepperValue(
              isBackButtonClick: true,
              stepName: KYCStep.OTHERINFO.toString(),
              stepVal: KYCStep.OTHERINFO.getStep());
        },
      );
    }
  }

  /// On Next Tap
  void _onTap() {
    if (isValidated()) {
      _userOtherInformationBloc.add(SubmitOtherAndEmpDetailsEvent(
          isPoliticallyExposed: politicalExposed,
          purposeOfAccOpening: purpose,
          taxPayeeInUS: taxPayeeInUs,
          sourceOfFunds: sourceOfFunds,
          expectedTransMode: transactionMode,
          amountDepositPerMonth: depositPerMonth,
          referralCode: referenceCode,
          isPoliticsInvolved: isInvolvedPolitics,
          isMP: isMemberOfCabinet,
          isPositionParty: isHoldingPosition));
      // storeDataAndStepperValue(
      //     isBackButtonClick: false,
      //     stepName: widget.isEditingEnabled ? KYCStep.REVIEW.toString() : KYCStep.DOCUMENTVERIFY.toString(),
      //     stepVal: widget.isEditingEnabled ? KYCStep.REVIEW.getStep() : KYCStep.DOCUMENTVERIFY.getStep());
    }
  }

  /// Check Validate
  bool isValidated() {
    if (politicalExposed == "" ||
        politicalExposed == null ||
        purpose == "" ||
        purpose == null ||
        sourceOfFunds == null ||
        sourceOfFunds == "" ||
        transactionMode == null ||
        transactionMode == "" ||
        depositPerMonth == "" ||
        depositPerMonth == null ||
        depositPerMonth == "0.00" ||
        taxPayeeInUs == "" ||
        taxPayeeInUs == null) {
      return false;
    } else {
      if (politicalExposed == "true") {
        if (!isInvolvedPolitics && !isHoldingPosition && !isMemberOfCabinet) {
          return false;
        }
      }
      return true;
    }
  }

  /// Get Data From Source
  void getDataFromSource(WalletOnBoardingData walletOnBoardingData) {
    if (walletOnBoardingData != null) {
      if (walletOnBoardingData.walletUserData != null) {
        if (walletOnBoardingData.walletUserData.empDetailRequest != null) {
          final EmpDetailRequest empDetailRequest =
              walletOnBoardingData.walletUserData.empDetailRequest;
          _initialData = walletOnBoardingData.walletUserData.empDetailRequest;
          setState(() {
            politicalExposed = empDetailRequest.isPoliticallyExposed;
            purpose = empDetailRequest.purposeOfAcc;
            transactionMode = empDetailRequest.expectedTransactionMode;

            depositPerMonth = empDetailRequest.anticipatedDepositPerMonth;
            initialDepositPerMonth =
                empDetailRequest.anticipatedDepositPerMonth;

            referenceCode = empDetailRequest.marketingRefCode;
            initialReferenceCode = empDetailRequest.marketingRefCode;

            sourceOfFunds = empDetailRequest.sourceOfIncome;
            taxPayeeInUs = empDetailRequest.isTaxPayerUs;

            if (empDetailRequest.isInvolvedInPolitics == "true") {
              isInvolvedPolitics = true;
            } else {
              isInvolvedPolitics = false;
            }
            if (empDetailRequest.isPositionInParty == "true") {
              isHoldingPosition = true;
            } else {
              isHoldingPosition = false;
            }
            if (empDetailRequest.isMemberOfInst == "true") {
              isMemberOfCabinet = true;
            } else {
              isMemberOfCabinet = false;
            }
          });
        }
      }
    }
  }

  /// Store Data and Stepper Value
  void storeDataAndStepperValue(
      {bool isBackButtonClick, String stepName, int stepVal}) {
    final EmpDetailRequest empDetailRequest = EmpDetailRequest(
      isPoliticallyExposed: politicalExposed,
      purposeOfAcc: purpose,
      expectedTransactionMode: transactionMode,
      anticipatedDepositPerMonth: depositPerMonth,
      marketingRefCode: referenceCode,
      sourceOfIncome: sourceOfFunds,
      isTaxPayerUs: taxPayeeInUs,
      isInvolvedInPolitics: isInvolvedPolitics.toString(),
      isPositionInParty: isHoldingPosition.toString(),
      isMemberOfInst: isMemberOfCabinet.toString(),
    );

    _userOtherInformationBloc.add(StoreUserOtherInformationEvent(
        stepName: stepName,
        stepValue: stepVal,
        isBackButtonClick: isBackButtonClick,
        empDetailRequest: empDetailRequest));
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _userOtherInformationBloc;
  }
}
