import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
import '../../bloc/on_boarding/employment_details/employemnt_details_state.dart';
import '../../bloc/on_boarding/employment_details/employment_details_bloc.dart';
import '../../bloc/on_boarding/employment_details/employment_details_event.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';

class EmploymentDetailView extends BaseView {
  final bool isEditingEnabled;

  const EmploymentDetailView({Key key, this.isEditingEnabled = false}) : super(key: key);

  @override
  _EmploymentDetailViewState createState() => _EmploymentDetailViewState();
}

class _EmploymentDetailViewState extends BaseViewState<EmploymentDetailView> {
  final EmploymentDetailsBloc _employmentDetailsBloc = inject<EmploymentDetailsBloc>();
  String empType;
  String filedOfEmp;
  String designation;
  int designationKey;
  String income;
  String employerName;
  String address1;
  String address2;
  String address3;

  String initialEmployerName;
  String initialAddress1;
  String initialAddress2;
  String initialAddress3;

  EmpDetailRequest _initialData;

  @override
  void initState() {
    _employmentDetailsBloc.add(GetEmploymentDetailsEvent());
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditingEnabled
          ? CDBProgressAppBar(
              step: KYCStep.EMPDETAILS,
              onTapBack: _handleBackClick,
              showStep: false,
            )
          : CDBProgressAppBar(
              step: KYCStep.EMPDETAILS,
              onTapBack: _handleBackClick,
            ),
      body: BlocProvider(
        create: (_) => _employmentDetailsBloc,
        child: BlocListener<EmploymentDetailsBloc, BaseState<EmploymentDetailsState>>(
          listener: (context, state) {
            if (state is EmploymentDetailsFailedState) {
              debugPrint(state.message);
            } else if (state is EmploymentDetailsLoadedState) {
              getDataFromSource(state.walletOnBoardingData);
            } else if (state is EmploymentDetailsSuccessState) {
              if (state.isBackButtonClick) {
                Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              } else {
                if (widget.isEditingEnabled) {
                  _employmentDetailsBloc.add(UpdateEmployeeDetailsEvent());
                } else {
                  Navigator.pushReplacementNamed(context, Routes.kUserOtherInfoView, arguments: false);
                }
              }
            }else if (state is UpdateEmployeeDetailsSuccess) {
              Navigator.pop(context, true);
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
                          CdbDropDown(
                            key: Key("${empType}emp"),
                            initialValue: empType,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.empType.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.selectEmploymentField.localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetEmpTypeDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  empType = result.description;
                                });
                              }
                            },
                          ),

                          /// Employer Name
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key(initialEmployerName ?? "EmployerName"),
                            initialValue: initialEmployerName,
                            labelText: AppString.employerName.localize(context),
                            onChange: (value) {
                              setState(() {
                                employerName = value;
                              });
                            },
                          ),

                          /// Employment Address
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          Text(
                            AppString.employerAddress.localize(context),
                            style: AppStyling.normal400Size14.copyWith(
                              color: AppColors.textDarkColor,
                            ),
                          ),
                          CdbCustomTextField(
                            key: Key(initialAddress1 ?? "address1"),
                            initialValue: initialAddress1,
                            hintText: AppString.addressOne.localize(context),
                            onChange: (value) {
                              setState(() {
                                address1 = value;
                              });
                            },
                            textInputType: TextInputType.emailAddress,
                          ),
                          CdbCustomTextField(
                            key: Key(initialAddress2 ?? "address2"),
                            initialValue: initialAddress2,
                            hintText: AppString.addressTwo.localize(context),
                            onChange: (value) {
                              setState(() {
                                address2 = value;
                              });

                            },
                            textInputType: TextInputType.emailAddress,
                          ),
                          CdbCustomTextField(
                            key: Key(initialAddress3 ?? "address3"),
                            initialValue: initialAddress3,
                            hintText: AppString.addressThree.localize(context),
                            onChange: (value) {
                              setState(() {
                                address3 = value;
                              });
                            },
                            textInputType: TextInputType.emailAddress,
                          ),

                          /// Employment Field
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbDropDown(
                            key: Key("${filedOfEmp}field" ?? "empField"),
                            initialValue: filedOfEmp,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.employmentField.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.selectEmploymentField.localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetEmpFieldDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  filedOfEmp = result.description;
                                });
                              }
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),

                          /// Designation
                          CdbDropDown(
                            key: Key("${designation}designation" ?? "designation"),
                            initialValue: designation,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.designation.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.selectDesignation.localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetEmpDesignation(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  designation = result.description;
                                  designationKey = result.id;
                                });
                              }
                            },
                          ),

                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),

                          /// Annual Income
                          CdbDropDown(
                            key: Key("${income}income" ?? "income"),
                            initialValue: income,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.income.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.selectIncome.localize(context),
                                  isSearchable: false,
                                  dropDownEvent: GetAnnualIncome(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  income = result.description;
                                });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 60,
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
                          status: _isValidated()
                              ? ButtonStatus.ENABLE
                              : ButtonStatus.DISABLE,
                          onTap: _onTap,
                          text: widget.isEditingEnabled ? 'Save and Review' : AppString.next.localize(context),
                        ),
                        CDBNoBorderBackgroundButton(
                          onTap: _handleBackClick,
                          text: widget.isEditingEnabled ? 'Go Back to Review' : AppString.completeLater.localize(context),
                        ),
                      ],
                    ),
                  ),
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
      if (empType != _initialData.empType ||
      filedOfEmp != _initialData.filedOfEmp ||
      income != _initialData.annualIncome ||

      employerName != _initialData.nameOfEmp ||
      initialEmployerName != _initialData.nameOfEmp ||

      designation != _initialData.designationUiValue ||
      designationKey != _initialData.designation ||

      address1 != _initialData.addressOfEmp.addressLine1 ||
      initialAddress1 != _initialData.addressOfEmp.addressLine1 ||
      address2 != _initialData.addressOfEmp.addressLine2 ||
      initialAddress2 != _initialData.addressOfEmp.addressLine2 ||
      address3 != _initialData.addressOfEmp.addressLine3 ||
      initialAddress3 != _initialData.addressOfEmp.addressLine3) {
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
            Text('Do you want to leave the registration form? \n\nNote: All the data that you entered will be saved. You can continue from where you left at later convenient time.'),
          ],
        ),
        negativeButtonText: AppString.cancel.localize(context),
        negativeButtonTap: () {},
        positiveButtonText: AppString.saveExit.localize(context),
        positiveButtonTap: () {
          storeDataAndStepperValue(isBackButtonClick: true, stepName: KYCStep.EMPDETAILS.toString(), stepVal: KYCStep.EMPDETAILS.getStep());
        },
      );
    }
  }

  /// On Next Tap
  void _onTap() {
    if (_isValidated()) {
      storeDataAndStepperValue(
          isBackButtonClick: false,
          stepName: widget.isEditingEnabled ? KYCStep.REVIEW.toString() : KYCStep.OTHERINFO.toString(),
          stepVal: widget.isEditingEnabled ? KYCStep.REVIEW.getStep() : KYCStep.OTHERINFO.getStep());
    }
  }

  /// Check if fields are validated
  bool _isValidated() {
    if(empType == "" || empType == null || employerName == "" || employerName == null || address1 == "" || address1 == null || address2 == "" || address2 == null || filedOfEmp == "" || filedOfEmp == null || designation == null || designation == "" || income == "" || income == null) {
      return false;
    }
    return true;
  }

  /// Store Data and Stepper Value
  void storeDataAndStepperValue({bool isBackButtonClick, String stepName, int stepVal}) {
    final AddressOfEmp addressOfEmp = AddressOfEmp(addressLine1: address1, addressLine2: address2, addressLine3: address3);
    final EmpDetailRequest empDetailRequest =
        EmpDetailRequest(empType: empType, nameOfEmp: employerName, filedOfEmp: filedOfEmp, designationUiValue: designation, annualIncome: income, addressOfEmp: addressOfEmp,designation: designationKey);
    _employmentDetailsBloc.add(StoreEmploymentDetailsEvent(stepName: stepName, stepValue: stepVal, isBackButtonClick: isBackButtonClick, empDetailRequest: empDetailRequest));
  }

  /// Get Data From Source
  void getDataFromSource(WalletOnBoardingData walletOnBoardingData) {
    if (walletOnBoardingData != null) {
      if (walletOnBoardingData.walletUserData != null) {
        if (walletOnBoardingData.walletUserData.empDetailRequest != null) {
          final EmpDetailRequest empDetailRequest = walletOnBoardingData.walletUserData.empDetailRequest;
          _initialData = walletOnBoardingData.walletUserData.empDetailRequest;
          setState(() {
            empType = empDetailRequest.empType;
            filedOfEmp = empDetailRequest.filedOfEmp;
            income = empDetailRequest.annualIncome;

            employerName = empDetailRequest.nameOfEmp;
            initialEmployerName = empDetailRequest.nameOfEmp;

            designation = empDetailRequest.designationUiValue;
            designationKey = empDetailRequest.designation;

            address1 = empDetailRequest.addressOfEmp.addressLine1;
            initialAddress1 = empDetailRequest.addressOfEmp.addressLine1;
            address2 = empDetailRequest.addressOfEmp.addressLine2;
            initialAddress2 = empDetailRequest.addressOfEmp.addressLine2;
            address3 = empDetailRequest.addressOfEmp.addressLine3;
            initialAddress3 = empDetailRequest.addressOfEmp.addressLine3;
          });
        }
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _employmentDetailsBloc;
  }
}
