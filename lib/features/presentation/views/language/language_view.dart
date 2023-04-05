import 'package:cdb_mobile/core/services/dependency_injection.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:cdb_mobile/features/presentation/bloc/language/language_bloc.dart';
import 'package:cdb_mobile/features/presentation/bloc/language/language_event.dart';
import 'package:cdb_mobile/features/presentation/bloc/language/language_state.dart';
import 'package:cdb_mobile/features/presentation/views/base_view.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_buttons/cdb_border_gradient_button.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_header_underline.dart';
import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/app_colors.dart';
import 'package:cdb_mobile/utils/app_constants.dart';
import 'package:cdb_mobile/utils/app_images.dart';
import 'package:cdb_mobile/utils/app_styling.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LanguageView extends BaseView {
  const LanguageView({Key key}) : super(key: key);

  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends BaseViewState<LanguageView> {
  final _bloc = inject<LanguageBloc>();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider<LanguageBloc>(
          create: (_) => _bloc,
          child: BlocListener<LanguageBloc, BaseState<LanguageState>>(
            bloc: _bloc,
            listener: (_, state) {
              if (state is SetPreferredLanguageSuccessState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.kLoginView,
                  (route) => false,
                );
              } else if (state is SetPreferredLanguageFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: kLeftRightMarginOnBoarding,
                    right: kLeftRightMarginOnBoarding,
                    top: kTopMarginOnBoarding,
                    bottom: kBottomMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select Your Preferred Language',
                        style: AppStyling.normal500Size16
                            .copyWith(color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: CdbHeaderUnderline(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(AppImages.languageBackground),
                      ),
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.icLanguage,
                                height: 72,
                                width: 72,
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10),
                                child: CDBBorderGradientButton(
                                  width: double.maxFinite,
                                  backgroundColor: Colors.white,
                                  height: 58,
                                  radius: const Radius.circular(10),
                                  text: 'English',
                                  textColor: _getTextColor(_selectedIndex == 0),
                                  gradient:
                                      _getGradientColor(_selectedIndex == 0),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 0;
                                    });

                                    _dispatchLanguageChangeEvent();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10),
                                child: CDBBorderGradientButton(
                                  width: double.maxFinite,
                                  text: 'සිංහල',
                                  height: 58,
                                  radius: const Radius.circular(10),
                                  textColor: _getTextColor(_selectedIndex == 1),
                                  backgroundColor: Colors.white,
                                  gradient:
                                      _getGradientColor(_selectedIndex == 1),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 1;
                                    });

                                    _dispatchLanguageChangeEvent();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10),
                                child: CDBBorderGradientButton(
                                  width: double.maxFinite,
                                  text: 'Tamil',
                                  height: 58,
                                  radius: const Radius.circular(10),
                                  textColor: _getTextColor(_selectedIndex == 2),
                                  backgroundColor: Colors.white,
                                  gradient:
                                      _getGradientColor(_selectedIndex == 2),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = 2;
                                    });

                                    _dispatchLanguageChangeEvent();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dispatchLanguageChangeEvent() {
    _bloc.add(SetPreferredLanguageEvent(
      language: _selectedIndex == 0
          ? kLocaleEN
          : (_selectedIndex == 1 ? kLocaleSI : kLocaleTA),
      selectedDate: DateFormat("yyyy-mm-dd HH:mm:ss").format(DateTime.now()),
    ));
  }

  Color _getTextColor(bool isSelected) {
    if (isSelected) {
      return AppColors.accentColor;
    } else {
      return AppColors.textTitleColor;
    }
  }

  LinearGradient _getGradientColor(bool isSelected) {
    if (isSelected) {
      return AppColors.outlineGradient;
    } else {
      return AppColors.greyGradient;
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;
}
