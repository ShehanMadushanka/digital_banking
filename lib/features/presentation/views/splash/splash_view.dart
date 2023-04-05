import 'dart:math' as math;

import 'package:cdb_mobile/features/presentation/widgets/cdb_toast/cdb_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/cloud_notification_services.dart';
import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/datasources/local_data_source.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../bloc/splash/splash_event.dart';
import '../../bloc/splash/splash_state.dart';
import '../base_view.dart';

class SplashView extends BaseView {
  const SplashView({Key key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseViewState<SplashView> {
  final _cloudMessagingServices = inject<CloudMessagingServices>();
  final _analytics = inject<FirebaseAnalytics>();
  final LocalDataSource _localDataSource = inject<LocalDataSource>();
  final SplashBloc _splashBloc = inject<SplashBloc>();

  @override
  void initState() {
    super.initState();
    _splashBloc.add(RequestPushToken());
    _sendAnalyticsEvent();
  }

  Future<void> _sendAnalyticsEvent() async {
    await _analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true,
      },
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // Future.delayed(const Duration(milliseconds: 3000), () async {
    // await _localDataSource.removeAppWalletOnBoardingData();
    await _localDataSource.checkIfAppIsNewInstalled();
    // _splashBloc.add(GetStepperValueEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: BlocProvider(
          create: (_) => _splashBloc,
          child: BlocListener<SplashBloc, BaseState<SplashState>>(
            listener: (context, state) async {
              if (state is StepperValueLoadedState) {
                if (state.initialLaunchDone) {
                  if (state.routeString == Routes.kNewRegView) {
                    Navigator.pushReplacementNamed(
                        context, Routes.kLanguageView);
                  } else {
                    Navigator.pushReplacementNamed(context, state.routeString);
                  }
                } else {
                  Navigator.pushReplacementNamed(
                      context, Routes.kIntroductionSlider);
                }
              } else if (state is SplashFailedState) {
                ToastUtils.showCustomToast(
                    context, state.message, ToastStatus.fail);
              } else if (state is SplashLoadedState) {
                _splashBloc.add(GetStepperValueEvent());
              } else if (state is PushTokenSuccessState) {
                _splashBloc.add(SplashRequestEvent());
              } else if (state is PushTokenFailedState) {
                _splashBloc.add(RequestPushToken());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.64),
                                const Color(0xFFF3F3F3).withOpacity(0.14),
                                const Color(0xFFC0C0C0).withOpacity(0.36),
                              ],
                              radius: 1,
                              stops: const [
                                0.178706,
                                0.426676,
                                0.678907,
                              ],
                              transform: const GradientRotation(math.pi / 2),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Image.asset(AppImages.circleBgBottom,
                                fit: BoxFit.scaleDown),
                          ),
                        ),
                        Align(
                          child: Image.asset(AppImages.cdbIPayLogo,
                              width: 228, height: 78),
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(AppImages.circleBgBottom,
                                fit: BoxFit.scaleDown)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  color: AppColors.accentColor,
                  child: const Center(
                      child: Text('Powered by CDB',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() => _splashBloc;
}
