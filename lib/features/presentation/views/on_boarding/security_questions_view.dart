import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/data/models/requests/set_security_questions_request.dart';
import 'package:cdb_mobile/features/data/models/responses/city_response.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/security_questions/security_questions_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/security_questions/security_questions_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/on_boarding/security_questions/security_questions_state.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_event.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_buttons/cdb_no_border_background_button.dart';
import '../../widgets/cdb_drop_down/cdb_drop_down.dart';
import '../../widgets/cdb_drop_down/drop_down_view.dart';
import '../../widgets/cdb_header_underline.dart';
import '../../widgets/cdb_scrollview.dart';
import '../../widgets/cdb_text_fields/cdb_text_field.dart';
import '../base_view.dart';

class SecurityQuestionView extends BaseView {
  const SecurityQuestionView({Key key}) : super(key: key);

  @override
  _SecurityQuestionViewState createState() => _SecurityQuestionViewState();
}

class _SecurityQuestionViewState extends BaseViewState<SecurityQuestionView> {
  String secQues1;
  String secQues2;

  String secQues1Answer;
  String secQuestion2Answer;

  CommonDropDownResponse firstSelectedQuestion;
  CommonDropDownResponse secondSelectedQuestion;

  final _bloc = inject<SecurityQuestionsBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 68.h,
          bottom: kBottomMargin,
        ),
        child: BlocProvider<SecurityQuestionsBloc>(
          create: (_) => _bloc,
          child: BlocListener<SecurityQuestionsBloc,
              BaseState<SecurityQuestionsState>>(
            listener: (_, state) {
              if (state is SetSecurityQuestionsSuccessState) {
                _bloc.add(SaveSecurityQuestionsEvent());
              } else if (state is SetSecurityQuestionsFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              } else if (state is SaveSecurityQuestionsSuccessState) {
                Navigator.pushReplacementNamed(
                    context, Routes.kCreateProfileView);
              } else if (state is SaveSecurityQuestionsFailedState) {}
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
                          AppString.securityQuestions.localize(context),
                          style: AppStyling.normal500Size16
                              .copyWith(color: AppColors.textDarkColor),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: CdbHeaderUnderline()),
                        Padding(
                          padding: const EdgeInsets.only(top: 13),
                          child: Text(
                            AppString.securityQuestionsDes.localize(context),
                            style: AppStyling.normal400Size14,
                          ),
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
                          key: Key('${secQuestion2Answer}_4' ?? "secQuestion2Answer"),
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
                      CDBNoBorderBackgroundButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.kCreateProfileView);
                        },
                        text: AppString.skip.localize(context),
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
      _bloc.add(SetSecurityQuestionsEvent([
        AnswerList(answer: secQues1Answer, id: firstSelectedQuestion.id),
        AnswerList(answer: secQuestion2Answer, id: secondSelectedQuestion.id),
      ]));
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
