import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/customer_reg_request.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../../data/models/responses/city_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../bloc/on_boarding/contact_information/contact_information_bloc.dart';
import '../../bloc/on_boarding/contact_information/contact_information_event.dart';
import '../../bloc/on_boarding/contact_information/contact_information_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../../widgets/cdb_radio_button.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class ContactInformationView extends BaseView {
  final bool isEditingEnabled;

  const ContactInformationView({Key key, this.isEditingEnabled = false})
      : super(key: key);

  @override
  _ContactInformationViewState createState() => _ContactInformationViewState();
}

class _ContactInformationViewState
    extends BaseViewState<ContactInformationView> {
  /// Dependency Injection
  final ContactInformationBloc _contactInformationBloc =
      inject<ContactInformationBloc>();

  /// Variables
  String city;
  String mobileNo;
  String email;
  String address1;
  String address2;
  String address3;
  String equalityWithNic;
  int cityId;

  // Initial Variables
  String initialMobileNo;
  String initialEmail;
  String initialAddress1;
  String initialAddress2;
  String initialAddress3;

  CustomerRegistrationRequest _initialData;

  /// Init State
  @override
  void initState() {
    _contactInformationBloc.add(GetContactInformationEvent());
    super.initState();
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditingEnabled
          ? CDBProgressAppBar(
              step: KYCStep.CONTACTINFO,
              showStep: false,
              onTapBack: _handleBackClick,
            )
          : CDBProgressAppBar(
              step: KYCStep.CONTACTINFO,
              onTapBack: _handleBackClick,
            ),
      body: BlocProvider(
        create: (_) => _contactInformationBloc,
        child: BlocListener<ContactInformationBloc,
            BaseState<ContactInformationState>>(
          listener: (context, state) {
            if (state is ContactInformationFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            } else if (state is ContactInformationLoadedState) {
              getDataFromDataSource(state.walletOnBoardingData);
            } else if (state is ContactInformationSubmittedSuccessState) {
              if (state.isBackButtonClick) {
                Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              } else {
                // _contactInformationBloc.add(SubmitCusRegEvent());
                if (widget.isEditingEnabled) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pushReplacementNamed(
                      context, Routes.kEmploymentDetail,
                      arguments: false);
                }
              }
            } else if (state is ContactInfoApiSuccessState) {
              // if(widget.isEditingEnabled) {
              //   Navigator.pop(context, true);
              // } else {
              //   Navigator.pushReplacementNamed(context, Routes.kEmploymentDetail, arguments: false);
              // }
              storeDataAndStepperValue(
                  isBackButtonClick: false,
                  stepName: widget.isEditingEnabled
                      ? KYCStep.REVIEW.toString()
                      : KYCStep.EMPDETAILS.toString(),
                  stepVal: widget.isEditingEnabled
                      ? KYCStep.REVIEW.getStep()
                      : KYCStep.EMPDETAILS.getStep());
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
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Mobile Number
                          CdbCustomTextField(
                            key: Key(initialMobileNo ?? "mobileNo"),
                            initialValue: mobileNo,
                            maxLength: 10,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            labelText: AppString.mobileNo.localize(context),
                            onChange: (value) {
                              setState(() {
                                mobileNo = value;
                              });
                            },
                            textInputType: TextInputType.number,
                          ),

                          /// Mobile Number
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key(initialEmail ?? "email"),
                            initialValue: email,
                            labelText: AppString.email.localize(context),
                            onChange: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            textInputType: TextInputType.emailAddress,
                          ),

                          /// Hint Text
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          Text(
                            AppString.permAddress.localize(context),
                            style: AppStyling.normal400Size14.copyWith(
                              color: AppColors.textDarkColor,
                            ),
                          ),
                          CdbCustomTextField(
                            key:
                                Key("${initialAddress1}address1" ?? "address1"),
                            hintText: AppString.addressOne.localize(context),
                            initialValue: initialAddress1,
                            onChange: (value) {
                              setState(() {
                                address1 = value;
                              });
                            },
                            textInputType: TextInputType.emailAddress,
                          ),
                          CdbCustomTextField(
                            key:
                                Key("${initialAddress2}address2" ?? "address2"),
                            hintText: AppString.addressTwo.localize(context),
                            initialValue: initialAddress2,
                            onChange: (value) {
                              setState(() {
                                address2 = value;
                              });
                            },
                            textInputType: TextInputType.emailAddress,
                          ),
                          CdbCustomTextField(
                            key:
                                Key("${initialAddress3}address3" ?? "address3"),
                            hintText: AppString.addressThree.localize(context),
                            initialValue: initialAddress3,
                            onChange: (value) {
                              setState(() {
                                address3 = value;
                              });
                            },
                            textInputType: TextInputType.emailAddress,
                          ),

                          /// City
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbDropDown(
                            key: Key(city),
                            initialValue: city,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.city.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle:
                                      AppString.selectCity.localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetCityDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  city = result.description;
                                  cityId = result.id;
                                });
                              }
                            },
                          ),

                          /// Radio Buttons
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomRadioButton(
                            radioLabel: AppString.contactInfoRadioLabel
                                .localize(context),
                            key: Key(equalityWithNic ?? "martialStatus"),
                            initialValue: equalityWithNic,
                            radioButtonDataList: List.from([
                              RadioButtonModel(
                                label: AppString.yes.localize(context),
                                value: "true",
                              ),
                              RadioButtonModel(
                                label: AppString.no.localize(context),
                                value: "false",
                              ),
                            ]),
                            onChange: (value) {
                              setState(() {
                                equalityWithNic = value;
                              });
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Validate
  bool _isValidated() {
    if (city == null ||
        city == "" ||
        mobileNo == "" ||
        mobileNo == null ||
        email == "" ||
        email == null ||
        equalityWithNic == "" ||
        equalityWithNic == null ||
        address2 == "" ||
        address2 == null ||
        address1 == null ||
        address1 == "") {
      print("false");
      return false;
    } else {
      print("true");
      return true;
    }
  }

  /// On Next Tap
  void _onTap() {
    if (_isValidated()) {
      _contactInformationBloc.add(SubmitCusRegEvent(
          mobileNo: mobileNo,
          city: cityId,
          email: email,
          address1: address1,
          address2: address2,
          address3: address3,
          isAddSameAsNIC: equalityWithNic == "true"));
      // storeDataAndStepperValue(
      //     isBackButtonClick: false,
      //     stepName: widget.isEditingEnabled ? KYCStep.REVIEW.toString() : KYCStep.EMPDETAILS.toString(),
      //     stepVal: widget.isEditingEnabled ? KYCStep.REVIEW.getStep() : KYCStep.EMPDETAILS.getStep());
    }
  }

  /// Handle Back Click
  void _handleBackClick() {
    if (widget.isEditingEnabled) {

      if (mobileNo !=  _initialData.mobileNo ||
      city != ( _initialData.perAddress != null
          ? _initialData.perAddress[0].cityUiValue
          : null) ||
      cityId != (_initialData.perAddress != null
          ? _initialData.perAddress[0].city
          : null) ||

      email != _initialData.email ||
      initialEmail != _initialData.email ||

      address1 != (_initialData.perAddress != null
          ? _initialData.perAddress[0].addressLine1
          : null) ||
      initialAddress1 != (_initialData.perAddress != null
          ? _initialData.perAddress[0].addressLine1
          : null) ||

      address2 != (_initialData.perAddress != null
          ? _initialData.perAddress[0].addressLine2
          : null) ||
      initialAddress2 != (_initialData.perAddress != null
          ? _initialData.perAddress[0].addressLine2
          : null) ||

      address3 != (_initialData.perAddress != null
          ? _initialData.perAddress[0].addressLine3
          : null) ||
      initialAddress3 != (_initialData.perAddress != null
          ? _initialData.perAddress[0].addressLine3
          : null) ||

      equalityWithNic != (_initialData.perAddress != null
          ? _initialData.perAddress[0].equalityWithNic
          .toString()
          : null)) {
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
              stepName: KYCStep.CONTACTINFO.toString(),
              stepVal: KYCStep.CONTACTINFO.getStep());
        },
      );
    }
  }

  /// Store data and stepper value
  void storeDataAndStepperValue(
      {bool isBackButtonClick, String stepName, int stepVal}) {
    final PerAddress perAddress = PerAddress(
        addressLine1: address1,
        addressLine2: address2,
        addressLine3: address3,
        cityUiValue: city,
        equalityWithNic: equalityWithNic == "true",
        city: cityId);
    final CustomerRegistrationRequest customerRegistrationRequest =
        CustomerRegistrationRequest(
            email: email,
            mobileNo: mobileNo,
            perAddress: List.unmodifiable([perAddress]));
    _contactInformationBloc.add(StoreContactInformationEvent(
        stepName: stepName,
        stepValue: stepVal,
        customerRegistrationRequest: customerRegistrationRequest,
        isBackButtonClick: isBackButtonClick));
  }

  /// Load Data From Data Source
  void getDataFromDataSource(WalletOnBoardingData walletOnBoardingData) {
    if (walletOnBoardingData != null) {
      if (walletOnBoardingData.walletUserData != null) {
        if (walletOnBoardingData.walletUserData.customerRegistrationRequest !=
            null) {
          final CustomerRegistrationRequest customerRegistrationRequest =
              walletOnBoardingData.walletUserData.customerRegistrationRequest;

          _initialData =
              walletOnBoardingData.walletUserData.customerRegistrationRequest;
          setState(() {
            mobileNo = customerRegistrationRequest.mobileNo;
            initialMobileNo = customerRegistrationRequest.mobileNo;

            city = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].cityUiValue
                : null;
            cityId = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].city
                : null;

            email = customerRegistrationRequest.email;
            initialEmail = customerRegistrationRequest.email;

            address1 = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].addressLine1
                : null;
            initialAddress1 = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].addressLine1
                : null;

            address2 = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].addressLine2
                : null;
            initialAddress2 = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].addressLine2
                : null;

            address3 = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].addressLine3
                : null;
            initialAddress3 = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].addressLine3
                : null;

            equalityWithNic = customerRegistrationRequest.perAddress != null
                ? customerRegistrationRequest.perAddress[0].equalityWithNic
                    .toString()
                : null;
          });
        }
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _contactInformationBloc;
}
