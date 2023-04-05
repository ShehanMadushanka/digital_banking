import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/api_msg_types.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/requests/customer_reg_request.dart';
import '../../../data/models/responses/city_response.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../bloc/on_boarding/personal_information/personal_information_bloc.dart';
import '../../bloc/on_boarding/personal_information/personal_information_event.dart';
import '../../bloc/on_boarding/personal_information/personal_information_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_date_picker.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_progress_appbar.dart';
import '../../widgets/cdb_radio_button.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';

class PersonalInformationView extends BaseView {
  final bool isEditingEnabled;

  const PersonalInformationView({Key key, this.isEditingEnabled = false})
      : super(key: key);

  @override
  _PersonalInformationViewState createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState
    extends BaseViewState<PersonalInformationView> {
  /// Dependency Injection
  final PersonalInformationBloc _personalInformationBloc =
      inject<PersonalInformationBloc>();

  /// Variables
  String title;
  String language;
  String religion;
  String dateOfBirth;
  String initials;
  String initialsInFull;
  String lastName;
  String nationality;
  String gender;
  String nic;
  String martialStatus;
  String mothersMaidenName;

  String initialInitials;
  String initialInitialsInFull;
  String initialLastName;
  String initialNationality;
  String initialNic;
  String initialMothersMaidenName;

  CustomerRegistrationRequest initialData;

  /// Init State
  @override
  void initState() {
    _personalInformationBloc.add(GetPersonalInformationEvent());
    super.initState();
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditingEnabled
          ? CDBProgressAppBar(
              step: KYCStep.PERSONALINFO,
              showStep: false,
              onTapBack: _handleBackClick,
            )
          : CDBProgressAppBar(
              step: KYCStep.PERSONALINFO,
              onTapBack: _handleBackClick,
            ),
      body: BlocProvider(
        create: (_) => _personalInformationBloc,
        child: BlocListener<PersonalInformationBloc,
            BaseState<PersonalInformationState>>(
          listener: (context, state) {
            if (state is PersonalInformationLoadedState) {
              if (state.walletOnBoardingData != null) {
                if (state.walletOnBoardingData.stepperValue > 0 &&
                    state.walletOnBoardingData.walletUserData != null) {
                  initialData = state.walletOnBoardingData.walletUserData
                      .customerRegistrationRequest;
                  getDataFromDataSource(state.walletOnBoardingData
                      .walletUserData.customerRegistrationRequest);
                }
              }
            }

            if (state is PersonalInformationStoredState) {
              if (state.isBackButtonClick) {
                Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              } else {
                if (widget.isEditingEnabled) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pushReplacementNamed(
                      context, Routes.kContactInformation,
                      arguments: false);
                }
              }
            } else if (state is VerifyNICSuccessState) {
              storeDataAndStepperValue(
                  isBackButtonClick: false,
                  stepName: widget.isEditingEnabled
                      ? KYCStep.REVIEW.toString()
                      : KYCStep.CONTACTINFO.toString(),
                  stepVal: widget.isEditingEnabled
                      ? KYCStep.REVIEW.getStep()
                      : KYCStep.CONTACTINFO.getStep());
            } else if (state is PersonalInformationFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            } else if (state is SubmitPersonalInfoSuccessState) {
              storeDataAndStepperValue(
                isBackButtonClick: false,
                stepName: KYCStep.REVIEW.toString(),
                stepVal: KYCStep.REVIEW.getStep(),
              );
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
                          /// Title
                          CdbDropDown(
                            key: Key("${title}title" ?? "title"),
                            initialValue: title,
                            suffixIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor,
                            ),
                            labelText: AppString.title.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle:
                                      AppString.selectTitle.localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetTitleDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;
                              if (result != null) {
                                setState(() {
                                  title = result.description;
                                });
                              }
                            },
                          ),

                          /// Name Initials
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key:
                                Key("${initialInitials}initials" ?? "initials"),
                            labelText: AppString.nameInitials.localize(context),
                            initialValue: initials,
                            onChange: (value) {
                              setState(() {
                                initials = value;
                              });
                            },
                          ),

                          /// Name
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key("${initialInitialsInFull}initialFull" ??
                                "initialsInFull"),
                            labelText:
                                AppString.representName.localize(context),
                            initialValue: initialsInFull,
                            onChange: (value) {
                              setState(() {
                                initialsInFull = value;
                              });
                            },
                          ),

                          /// Last Name
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key:
                                Key("${initialLastName}lastName" ?? "lastName"),
                            labelText: AppString.lastName.localize(context),
                            initialValue: lastName,
                            onChange: (value) {
                              setState(() {
                                lastName = value;
                              });
                            },
                          ),

                          /// Nationality
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key("${initialNationality}national" ??
                                "nationality"),
                            labelText: AppString.nationality.localize(context),
                            initialValue: nationality,
                            onChange: (value) {
                              setState(() {
                                nationality = value;
                              });
                            },
                          ),

                          /// Language
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbDropDown(
                            key: Key("${language}lang" ?? "lang"),
                            initialValue: language,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                color: AppColors.textDarkColor),
                            labelText: AppString.language.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.selectLanguage
                                      .localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetLanguageDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  language = result.description;
                                });
                              }
                            },
                          ),

                          /// Religion
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbDropDown(
                            key: Key("${religion}rel" ?? "rel"),
                            initialValue: religion,
                            suffixIcon: const Icon(Icons.keyboard_arrow_down,
                                color: AppColors.textDarkColor),
                            labelText: AppString.religion.localize(context),
                            onTap: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle: AppString.selectReligion
                                      .localize(context),
                                  isSearchable: true,
                                  dropDownEvent: GetReligionDropDownEvent(),
                                ),
                              ) as CommonDropDownResponse;

                              if (result != null) {
                                setState(() {
                                  religion = result.description;
                                });
                              }
                            },
                          ),

                          /// NIC
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomTextField(
                            key: Key("${initialNic}nic" ?? "nic"),
                            labelText: AppString.nic.localize(context),
                            maxLength: 12,
                            initialValue: nic,
                            onChange: (value) {
                              setState(() {
                                nic = value;
                              });
                            },
                          ),

                          /// Gender
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomRadioButton(
                            key: Key("${gender}gender" ?? "gender"),
                            radioLabel: AppString.gender.localize(context),
                            initialValue: gender,
                            radioButtonDataList: List.from([
                              RadioButtonModel(
                                label: AppString.male.localize(context),
                                value: "male",
                              ),
                              RadioButtonModel(
                                label: AppString.female.localize(context),
                                value: "female",
                              ),
                            ]),
                            onChange: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                          ),

                          /// DOB
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbDatePicker(
                            key: Key("${dateOfBirth}dob" ?? "dob"),
                            labelText: AppString.dob.localize(context),
                            initialValue: dateOfBirth,
                            onChange: (value) {
                              dateOfBirth = value;
                            },
                          ),

                          /// Martial Status
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),
                          CdbCustomRadioButton(
                            radioLabel:
                                AppString.martialStatus.localize(context),
                            key: Key(
                                "${martialStatus}status" ?? "martialStatus"),
                            initialValue: martialStatus,
                            radioButtonDataList: List.from([
                              RadioButtonModel(
                                label: AppString.single.localize(context),
                                value: "single",
                              ),
                              RadioButtonModel(
                                label: AppString.married.localize(context),
                                value: "married",
                              ),
                            ]),
                            onChange: (value) {
                              setState(() {
                                martialStatus = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: kOnBoardingMarginBetweenFields,
                          ),

                          /// Mothers Maiden Name
                          CdbCustomTextField(
                            key: Key("${initialMothersMaidenName}mother" ??
                                "mothersMaidenName"),
                            labelText:
                                AppString.mothersMaidenName.localize(context),
                            maxLength: 12,
                            initialValue: mothersMaidenName,
                            onChange: (value) {
                              setState(() {
                                mothersMaidenName = value;
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
                          width: double.maxFinite,
                          onTap: _onTap,
                          status: _isValidated()
                              ? ButtonStatus.ENABLE
                              : ButtonStatus.DISABLE,
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

  /// Validate Fields
  bool _isValidated() {
    if (title == "" ||
        title == null ||
        initials == "" ||
        initials == null ||
        initialsInFull == null ||
        initialsInFull == "" ||
        lastName == null ||
        lastName == "" ||
        nationality == "" ||
        nationality == null ||
        language == null ||
        language == "" ||
        religion == null ||
        religion == "" ||
        nic == null ||
        nic == "" ||
        gender == "" ||
        gender == null ||
        dateOfBirth == null ||
        dateOfBirth == "" ||
        martialStatus == null ||
        martialStatus == "" ||
        mothersMaidenName == null ||
        mothersMaidenName == "") {
      return false;
    }

    return true;
  }

  /// Handle Back Click
  void _handleBackClick() {
    if (widget.isEditingEnabled) {
      if (title != initialData.title ||
          language != initialData.language ||
          religion != initialData.religion ||
          dateOfBirth != initialData.dateOfBirth ||
          initials != initialData.initials ||
          initialInitials != initialData.initials ||
          initialsInFull != initialData.initialsInFull ||
          initialInitialsInFull != initialData.initialsInFull ||
          lastName != initialData.lastName ||
          initialLastName != initialData.lastName ||
          mothersMaidenName != initialData.mothersMaidenName ||
          initialMothersMaidenName != initialData.mothersMaidenName ||
          nationality != initialData.nationality ||
          initialNationality != initialData.nationality ||
          gender != initialData.gender ||
          initialNic != initialData.nic ||
          nic != initialData.nic ||
          martialStatus != initialData.maritalStatus) {
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
        positiveButtonTap: () async {
          storeDataAndStepperValue(
              stepName: widget.isEditingEnabled
                  ? KYCStep.REVIEW.toString()
                  : KYCStep.PERSONALINFO.toString(),
              stepVal: widget.isEditingEnabled
                  ? KYCStep.REVIEW.getStep()
                  : KYCStep.PERSONALINFO.getStep(),
              isBackButtonClick: true);
        },
      );
    }
  }

  /// Store Data And Step Value
  void storeDataAndStepperValue(
      {bool isBackButtonClick, String stepName, int stepVal}) {
    final CustomerRegistrationRequest customerRegistrationRequest =
        CustomerRegistrationRequest(
      messageType: kMessageTypeCusRegistrationReq,
      title: title,
      initials: initials,
      initialsInFull: initialsInFull,
      lastName: lastName,
      nationality: nationality,
      gender: gender,
      religion: religion,
      nic: nic,
      dateOfBirth: dateOfBirth,
      language: language,
      maritalStatus: martialStatus,
      mothersMaidenName: mothersMaidenName,
    );
    _personalInformationBloc.add(StorePersonalInformationEvent(
        customerRegistrationRequest: customerRegistrationRequest,
        stepName: stepName,
        stepValue: stepVal,
        isBackButtonClick: isBackButtonClick));
  }

  /// Get data from dataSource and set the data
  void getDataFromDataSource(CustomerRegistrationRequest data) {
    setState(() {
      title = data.title;
      language = data.language;
      religion = data.religion;
      dateOfBirth = data.dateOfBirth;

      initials = data.initials;
      initialInitials = data.initials;

      initialsInFull = data.initialsInFull;
      initialInitialsInFull = data.initialsInFull;

      lastName = data.lastName;
      initialLastName = data.lastName;

      mothersMaidenName = data.mothersMaidenName;
      initialMothersMaidenName = data.mothersMaidenName;

      nationality = data.nationality;
      initialNationality = data.nationality;

      gender = data.gender;

      initialNic = data.nic;
      nic = data.nic;

      martialStatus = data.maritalStatus;
    });
  }

  /// On tap
  void _onTap() {
    if (_isValidated()) {
      if (widget.isEditingEnabled) {
        _personalInformationBloc.add(SubmitPersonalInfoEvent(
            title: title,
            language: language,
            religion: religion,
            dateOfBirth: dateOfBirth,
            initials: initials,
            initialsInFull: initialInitialsInFull,
            lastName: lastName,
            nationality: nationality,
            gender: gender,
            nic: nic,
            martialStatus: martialStatus,
            mothersMaidenName: mothersMaidenName));
      } else {
        _personalInformationBloc
            .add(VerifyNICEvent(nic: nic, dob: dateOfBirth));
      }

      // storeDataAndStepperValue(
      //     isBackButtonClick: false,
      //     stepName: widget.isEditingEnabled ? KYCStep.REVIEW.toString() : KYCStep.CONTACTINFO.toString(),
      //     stepVal: widget.isEditingEnabled ? KYCStep.REVIEW.getStep() : KYCStep.CONTACTINFO.getStep());
    }
  }

  /// Get Bloc
  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _personalInformationBloc;
}
