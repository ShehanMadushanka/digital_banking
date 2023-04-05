import 'package:cdb_mobile/features/data/models/requests/schedule_verification_request.dart';
import 'package:cdb_mobile/features/data/models/responses/city_response.dart';
import 'package:cdb_mobile/features/presentation/bloc/drop_down/drop_down_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/schedule_verification/schedule_verification_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/schedule_verification/schedule_verification_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/schedule_verification/schedule_verification_state.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_default_appbar.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/cdb_drop_down.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_drop_down/drop_down_view.dart';
import 'package:cdb_mobile/utils/app_utils.dart';
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
import '../../../data/datasources/local_data_source.dart';
import '../../../data/models/requests/wallet_onboarding_data.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';

class ScheduleVerificationView extends BaseView {
  final bool isEditingEnabled;

  const ScheduleVerificationView({Key key, this.isEditingEnabled})
      : super(key: key);

  @override
  _ScheduleVerificationViewState createState() =>
      _ScheduleVerificationViewState();
}

class _ScheduleVerificationViewState
    extends BaseViewState<ScheduleVerificationView> {
  /// Dependency Injection
  final LocalDataSource _localDataSource = inject<LocalDataSource>();
  final ScheduleVerificationBloc _scheduleVerificationBloc =
      inject<ScheduleVerificationBloc>();

  ///Controllers
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  /// Variables
  String date;
  String timeSlot;
  String language;

  // Initial Variables
  String initialDate;
  String initialTimeSlot;
  String initialLanguage;

  /// Init State
  @override
  void initState() {
    _scheduleVerificationBloc.add(GetScheduleInformationEvent());
    super.initState();
  }

  /// Build View
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.titleScheduleVerification.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider(
        create: (_) => _scheduleVerificationBloc,
        child: BlocListener<ScheduleVerificationBloc,
            BaseState<ScheduleVerificationState>>(
          listener: (context, state) {
            if (state is ScheduleVerificationInformationFailedState) {
              debugPrint(state.message);
            } else if (state is ScheduleVerificationInformationLoadedState) {
              getDataFromDataSource(state.walletOnBoardingData);
            } else if (state
                is ScheduleVerificationInformationSubmittedSuccessState) {
              if (state.isBackButtonClick) {
                Navigator.pushReplacementNamed(context, Routes.kRegProgress);
              } else {
                if (widget.isEditingEnabled) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.kReviewView);
                }
              }
            } else if (state is SubmitScheduleDataSuccessState) {
              showCDBDialog(
                title:
                    AppString.titleOtherProductSubmitSuccess.localize(context),
                body: Column(
                  children: [
                    Text(AppString.descriptionOtherProductSubmitSuccess
                        .localize(context)),
                  ],
                ),
                positiveButtonText: AppString.done.localize(context),
                positiveButtonTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.kLoginView, (route) => false);
                },
                negativeButtonText: '',
                negativeButtonTap: () {},
              );
            }
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
                        Text(
                          AppString.svDescription.localize(context),
                          style: AppStyling.normal400Size14
                              .copyWith(color: AppColors.textTitleColor),
                        ),

                        const SizedBox(
                          height: kLeftRightMarginOnBoarding,
                        ),

                        GestureDetector(
                          // key: Key(date ?? "date"),
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              Routes.kDropDownView,
                              arguments: DropDownViewScreenArgs(
                                pageTitle:
                                    AppString.svPickDate.localize(context),
                                isSearchable: true,
                                dropDownEvent: GetScheduleDatesDropDownEvent(),
                              ),
                            ) as CommonDropDownResponse;
                            if (result != null) {
                              setState(() {
                                date = result.description;
                                _dateController.text = date;
                              });
                            }
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: _dateController,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.accentColor,
                                size: 18,
                              ),
                              labelText: AppString.svPickDate.localize(context),
                              labelStyle: AppStyling.normal500Size16.copyWith(
                                color: AppColors.textDarkColor,
                              ),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.textFieldBottomBorderEnabled,
                                  width: kTextFieldBottomBorderHeight,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.textFieldBottomBorderEnabled,
                                  width: kTextFieldBottomBorderHeight,
                                ),
                              ),
                            ),
                            style: AppStyling.normal500Size16.copyWith(
                              color: AppColors.textDarkColor,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),

                        GestureDetector(
                          // key: Key(timeSlot ?? "timeSlot"),
                          onTap: () async {
                            if (date != null && date.isNotEmpty) {
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.kDropDownView,
                                arguments: DropDownViewScreenArgs(
                                  pageTitle:
                                      AppString.svPickTime.localize(context),
                                  isSearchable: true,
                                  dropDownEvent:
                                      GetScheduleTimeSlotDropDownEvent(
                                          selectedDate: date),
                                ),
                              ) as CommonDropDownResponse;
                              if (result != null) {
                                setState(() {
                                  timeSlot = AppUtils.convert12Hto24(
                                      result.description);
                                  _timeController.text = TimeOfDay(
                                          hour:
                                              int.parse(timeSlot.split(':')[0]),
                                          minute:
                                              int.parse(timeSlot.split(':')[1]))
                                      .format(context);
                                });
                              }
                            }
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: _timeController,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.access_time,
                                color: AppColors.accentColor,
                                size: 18,
                              ),
                              labelText: AppString.svPickTime.localize(context),
                              labelStyle: AppStyling.normal500Size16.copyWith(
                                color: AppColors.textDarkColor,
                              ),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.textFieldBottomBorderEnabled,
                                  width: kTextFieldBottomBorderHeight,
                                ),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.textFieldBottomBorderEnabled,
                                  width: kTextFieldBottomBorderHeight,
                                ),
                              ),
                            ),
                            style: AppStyling.normal500Size16.copyWith(
                              color: AppColors.textDarkColor,
                            ),
                          ),
                        ),

                        ///Language
                        const SizedBox(
                          height: kOnBoardingMarginBetweenFields,
                        ),
                        CdbDropDown(
                          key: Key(language ?? "lang"),
                          initialValue: language,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.textDarkColor),
                          labelText: AppString.language.localize(context),
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              Routes.kDropDownView,
                              arguments: DropDownViewScreenArgs(
                                pageTitle:
                                    AppString.selectLanguage.localize(context),
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
                        text: AppString.next.localize(context),
                      ),
                      CDBNoBorderBackgroundButton(
                        onTap: _handleBackClick,
                        text: AppString.completeLater.localize(context),
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

  /// Validate
  bool _isValidated() {
    if (date == null ||
        date == "" ||
        timeSlot == "" ||
        timeSlot == null ||
        language == "" ||
        language == null) {
      return false;
    }
    return true;
  }

  /// On Next Tap
  void _onTap() {
    if (_isValidated()) {
      _scheduleVerificationBloc.add(SubmitScheduleDataEvent(
          date: date, timeSlot: timeSlot, language: language));

      /*storeDataAndStepperValue(
          isBackButtonClick: false,
          stepName: KYCStep.REVIEW.toString(),
          stepVal: KYCStep.REVIEW.getStep());*/
    }
  }

  /// Handle Back Click
  void _handleBackClick() {
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
            stepName: KYCStep.SCHEDULEVERIFY.toString(),
            stepVal: KYCStep.SCHEDULEVERIFY.getStep());
      },
    );
  }

  /// Store data and stepper value
  void storeDataAndStepperValue(
      {bool isBackButtonClick, String stepName, int stepVal}) {
    final ScheduleVerificationRequest scheduleVerificationRequest =
        ScheduleVerificationRequest(
            timeSlot: timeSlot, language: language, date: date);
    _scheduleVerificationBloc.add(StoreScheduleVerificationInformationEvent(
        stepName: stepName,
        stepValue: stepVal,
        scheduleVerificationRequest: scheduleVerificationRequest,
        isBackButtonClick: isBackButtonClick));
  }

  /// Load Data From Data Source
  void getDataFromDataSource(WalletOnBoardingData walletOnBoardingData) {
    if (walletOnBoardingData != null) {
      if (walletOnBoardingData.walletUserData != null) {
        if (walletOnBoardingData.walletUserData.scheduleVerificationRequest !=
            null) {
          final ScheduleVerificationRequest scheduleVerificationRequest =
              walletOnBoardingData.walletUserData.scheduleVerificationRequest;
          setState(() {
            date = scheduleVerificationRequest.date ?? '';
            timeSlot = scheduleVerificationRequest.timeSlot ?? '';
            language = scheduleVerificationRequest.language ?? '';

            initialDate = scheduleVerificationRequest.date ?? 'date';
            initialTimeSlot =
                scheduleVerificationRequest.timeSlot ?? 'timeSlot';
            initialLanguage =
                scheduleVerificationRequest.language ?? 'language';

            _dateController.text = date;
            _timeController.text = timeSlot;
          });
        }
      }
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _scheduleVerificationBloc;
  }
}
