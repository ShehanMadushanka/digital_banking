import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:cdb_mobile/utils/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_extensions.dart';
import '../../../../utils/app_styling.dart';
import '../../../../utils/enums.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/on_boarding/tnc/tnc_bloc.dart';
import '../../bloc/on_boarding/tnc/tnc_event.dart';
import '../../bloc/on_boarding/tnc/tnc_state.dart';
import '../../widgets/cdb_buttons/cdb_border_gradient_button.dart';
import '../../widgets/cdb_default_appbar.dart';
import '../../widgets/cdb_scrollview.dart';
import '../base_view.dart';

class TnCView extends BaseView {
  final String termsType;
  final String viewType;

  const TnCView({Key key, this.termsType, this.viewType}) : super(key: key);

  @override
  _TnCViewState createState() => _TnCViewState();
}

class _TnCViewState extends BaseViewState<TnCView> {
  final _bloc = inject<TnCBloc>();
  String _termsData = '';
  int _termID = 0;
  ButtonStatus _acceptButtonStatus = ButtonStatus.DISABLE;

  @override
  void initState() {
    _bloc.add(GetTermsEvent(termType: widget.termsType));
    super.initState();
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _bloc;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: CDBMainAppBar(
        appBarTitle: widget.viewType == Routes.kAddPaymentInstrumentRootView
            ? 'CDB Terms and Conditions'
            : 'Terms and Conditions',
        onTapBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocProvider<TnCBloc>(
        create: (context) => _bloc,
        child: BlocListener<TnCBloc, BaseState<TnCState>>(
          listener: (context, state) {
            if (state is TermsLoadedState) {
              setState(() {
                _termsData = state.termsData.termBody.base64ToString();
                _termID = state.termsData.termId;
              });
            } else if (state is TermsSubmittedState) {
              Navigator.pushReplacementNamed(
                  context, Routes.kPersonalInformationView,
                  arguments: false);
            } else if (state is TermsFailedState) {
              ToastUtils.showCustomToast(
                  context, state.message, ToastStatus.fail);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollEndNotification) {
                        _onEndScroll(scrollNotification.metrics);
                        return true;
                      } else {
                        return false;
                      }
                    },
                    child: CDBScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      child: Html(
                        data: _termsData,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          style: AppStyling.normal500Size14
                              .copyWith(color: AppColors.textDarkColor),
                          children: [
                            const WidgetSpan(
                                child: Icon(Icons.info_outline_rounded,
                                    color: AppColors.primaryColor)),
                            TextSpan(
                              text: '  Important',
                              style: AppStyling.normal500Size16
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'At the end of the successful verification process a savings account will be set up according to the user’s information',
                        style: AppStyling.normal400Size14
                            .copyWith(color: AppColors.primaryColor),
                        textAlign: TextAlign.start,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 3),
                              child: CDBBorderGradientButton(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                gradient: AppColors.greyGradient,
                                child: Center(
                                  child: Text(
                                    'Decline',
                                    style: AppStyling.bold700Size16.copyWith(
                                      color: AppColors.grayColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 3),
                              child: CDBBorderGradientButton(
                                status: _acceptButtonStatus,
                                onTap: () {
                                  widget.viewType ==
                                          Routes.kAddPaymentInstrumentRootView
                                      ? Navigator.pushReplacementNamed(context,
                                          Routes.kCommonOTPView)
                                      : _bloc.add(AcceptTermsEvent(
                                          acceptedDate:
                                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                                  .format(DateTime.now()),
                                          termId: _termID));
                                },
                                text: 'Accept',
                              ),
                            ),
                          )
                        ],
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

  void _onEndScroll(ScrollMetrics metrics) {
    if (_termsData.isNotEmpty) {
      setState(() {
        _acceptButtonStatus = ButtonStatus.ENABLE;
      });
    }
  }
}
