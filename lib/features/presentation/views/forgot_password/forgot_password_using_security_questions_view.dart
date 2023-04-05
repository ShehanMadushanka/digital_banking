import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/responses/city_response.dart';
import '../../../domain/entities/request/forgot_pw_reset_security_questions_request_entity.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../bloc/forgot_password/forgot_pw_reset_security_questions_bloc.dart';
import '../../bloc/forgot_password/forgot_pw_reset_security_questions_event.dart';
import '../../bloc/forgot_password/forgot_pw_reset_security_questions_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../../widgets/cdb_toast/cdb_toast.dart';
import '../base_view.dart';
import '../otp/otp_view.dart';

class ForgotPasswordRestUsingSecurityQuestionsView extends BaseView {
  const ForgotPasswordRestUsingSecurityQuestionsView({Key key})
      : super(key: key);

  @override
  _ForgotPasswordRestUsingSecurityQuestionsViewState createState() =>
      _ForgotPasswordRestUsingSecurityQuestionsViewState();
}

class _ForgotPasswordRestUsingSecurityQuestionsViewState
    extends BaseViewState<ForgotPasswordRestUsingSecurityQuestionsView> {
  String secQues1;
  String secQues2;

  String secQues1Answer;
  String secQuestion2Answer;

  String answer;
  String question;

  CommonDropDownResponse firstSelectedQuestion;
  CommonDropDownResponse secondSelectedQuestion;

  final _bloc = inject<ForgotPwResetSecQuestionsBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: AppString.forgotPasswordSecQuesTitle.localize(context),
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: kBottomMargin,
        ),
        child: BlocProvider<ForgotPwResetSecQuestionsBloc>(
          create: (_) => _bloc,
          child: BlocListener<ForgotPwResetSecQuestionsBloc,
              BaseState<ForgotPwResetSecQuestionsState>>(
            listener: (_, state) async {
              if (state is GetForgotPwResetSecQuestionsFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              } else if (state is GetForgotPwResetSecQuestionsSuccessState) {
                final _otpResult = await Navigator.pushNamed(
                    context, Routes.kCommonOTPView,
                    arguments: OTPViewArgs(
                        otpType: kOtpMessageTypeOnBoarding,
                        requestOTP: true)) as bool;
                if (_otpResult) {
                  Navigator.pushReplacementNamed(
                      context, Routes.kForgotPasswordCreateNewPassword);
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CDBScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.forgotPwSecurityQuestionsDes
                              .localize(context),
                          style: AppStyling.normal400Size14,
                        ),
                        SizedBox(
                          height: 56.h,
                        ),
                        CdbDropDown(
                          key: Key('${secQues1}_1' ?? "secQues1"),
                          initialValue: secQues1,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textDarkColor,
                          ),
                          labelText:
                              "${AppString.securityQuestion.localize(context)} 1",
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              Routes.kDropDownView,
                              arguments: DropDownViewScreenArgs(
                                pageTitle: AppString.selectSecurityQuestion
                                    .localize(context),
                                isSearchable: false,
                                dropDownEvent:
                                    GetSecurityQuestionDropDownEvent(),
                              ),
                            ) as CommonDropDownResponse;
                            if (result != null) {
                              if (result.description == secQues2) {
                                ToastUtils.showCustomToast(
                                    context,
                                    'Please select a different question',
                                    ToastStatus.fail);
                                setState(() {
                                  firstSelectedQuestion = null;
                                  secQues1 = 'secQues1';
                                });
                              } else {
                                setState(() {
                                  firstSelectedQuestion = result;
                                  secQues1 = result.description;
                                });
                              }
                            }
                          },
                        ),
                        CdbCustomTextField(
                          key: Key('${secQues1Answer}_2' ?? "secQues1Answer"),
                          hintText: AppString.answer.localize(context),
                          initialValue: secQues1Answer,
                          onChange: (value) {
                            secQues1Answer = value;
                          },
                        ),
                        SizedBox(
                          height: 39.h,
                        ),
                        CdbDropDown(
                          key: Key('${secQues2}_3' ?? "secQues2"),
                          initialValue: secQues2,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textDarkColor,
                          ),
                          labelText:
                              "${AppString.securityQuestion.localize(context)} 2",
                          onTap: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              Routes.kDropDownView,
                              arguments: DropDownViewScreenArgs(
                                pageTitle: AppString.selectSecurityQuestion
                                    .localize(context),
                                isSearchable: false,
                                dropDownEvent:
                                    GetSecurityQuestionDropDownEvent(),
                              ),
                            ) as CommonDropDownResponse;
                            if (result != null) {
                              if (result.description == secQues1) {
                                ToastUtils.showCustomToast(
                                    context,
                                    'Please select a different question',
                                    ToastStatus.fail);
                                setState(() {
                                  secondSelectedQuestion = null;
                                  secQues2 = 'secQues2';
                                });
                              } else {
                                setState(() {
                                  secondSelectedQuestion = result;
                                  secQues2 = result.description;
                                });
                              }
                            }
                          },
                        ),
                        CdbCustomTextField(
                          key: Key('${secQuestion2Answer}_4' ??
                              "secQuestion2Answer"),
                          hintText: AppString.answer.localize(context),
                          initialValue: secQuestion2Answer,
                          onChange: (value) {
                            secQuestion2Answer = value;
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
                        onTap: _validateQuestions,
                        text: AppString.next.localize(context),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateQuestions() {
    if (secQues1 == "secQues1" || secQues2 == "secQues2") {
      ToastUtils.showCustomToast(
          context, "Please choose a question.", ToastStatus.fail);
    } else if (secQues1Answer == null || firstSelectedQuestion == null) {
      ToastUtils.showCustomToast(
          context, "Please respond to the first question.", ToastStatus.fail);
    } else if (secQuestion2Answer == null || secondSelectedQuestion == null) {
      ToastUtils.showCustomToast(
          context, "Please respond to the second question.", ToastStatus.fail);
    } else {
      _bloc.add(GetForgotPwResetSecQuestionsEvent([
        AnswerEntity(
            answer: secQues1Answer, question: firstSelectedQuestion.id),
        AnswerEntity(
            answer: secQuestion2Answer, question: secondSelectedQuestion.id),
      ]));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
