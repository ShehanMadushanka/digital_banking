import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';


import 'package:cdb_mobile/features/presentation/bloc/base_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:installer_info/installer_info.dart';
import 'package:lottie/lottie.dart';
import 'package:trust_fall/trust_fall.dart';
//import 'package:trust_fall/trust_fall.dart';

import '../../../core/configurations/app_config.dart';
import '../../../core/services/platform_services.dart';
import '../../../flavors/flavor_banner.dart';
import '../../../utils/app_animations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../../../utils/navigation_routes.dart';
import '../bloc/base_bloc.dart';
import '../widgets/cdb_dialog.dart';

abstract class BaseView extends StatefulWidget {
  const BaseView({Key key}) : super(key: key);
}

abstract class BaseViewState<Page extends BaseView> extends State<Page> {
  AndroidNotificationChannel channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool isRealDevice = true, isJailBroken = false, isADBEnabled = true;
  SecurityFailureType _securityFailureType = SecurityFailureType.SECURE;
  InstallerInfo installerInfo;
  bool _isProgressShow = false;
  static Timer _timer;

  // Abstract Methods
  Widget buildView(BuildContext context);

  BaseBloc getBloc();

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(seconds: kAppSessionTimeout), _stopTimer);
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;

    // TODO Show session timeout message
  }

  @override
  void initState() {
    super.initState();
    if(kDeviceOS == DeviceOS.ANDROID) {
      _setupLocalNotifications();
      _configureNotification();
    }
  }

  Future<void> _configureNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification.body}');
      }

      final RemoteNotification notification = message.notification;
      final AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //TODO Override this method to handle notification tap
    });
  }

  Future<void> _setupLocalNotifications() async {
    channel = const AndroidNotificationChannel(
      'cdb_high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _dontMessWithUs() async {
    if (kIsEmulatorCheckAvailable) {
      if (Platform.isAndroid) {
        isRealDevice = await PlatformServices.isRealDevice;
      } else {
        isRealDevice = await TrustFall.isRealDevice;
      }
    } else {
      isRealDevice = true;
    }

    if (kIsRootCheckAvailable) {
      if (Platform.isAndroid) {
        isJailBroken = await PlatformServices.isRooted;
      } else {
        isJailBroken = await PlatformServices.isJailBroken;
      }
    } else {
      isJailBroken = false;
    }

    if (Platform.isAndroid && kIsADBCheckAvailable) {
      isADBEnabled = await PlatformServices.getADBStatus;
      if (isADBEnabled) _securityFailureType = SecurityFailureType.ADB;
    }

    if (kIsSourceVerificationAvailable) {
      installerInfo = await getInstallerInfo();
      if (installerInfo != null) {
        if (!((installerInfo.installerName == kVendorAndroid) ||
            (installerInfo.installerName == kVendorHuawei) ||
            (installerInfo.installerName == kVendorApple ||
                installerInfo.installerName == kVendorTestFlight))) {
          _securityFailureType = SecurityFailureType.SOURCE;
        }
      } else {
        _securityFailureType = SecurityFailureType.SOURCE;
      }
    }

    if (isJailBroken) {
      _securityFailureType = SecurityFailureType.ROOT;
    }

    if (!isRealDevice) {
      _securityFailureType = SecurityFailureType.EMU;
    }

    setState(() {});
  }

  void _handleUserInteraction(s) {
    if (AppConstants.IS_USER_LOGGED) {
      _initializeTimer();
    }
  }

  void logout() {
    AppConstants.IS_USER_LOGGED = false;
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.kSplashView, (route) => false);
  }

  void showProgress(BuildContext context) {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      alignment: FractionalOffset.center,
                      child: Wrap(
                        children: [
                          Container(
                            color: Colors.transparent,
                            height: 150,
                            width: 150,
                            child: Lottie.asset(
                              AppAnimation.animLoading,
                              onLoaded: (composition) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {});
    }
  }

  void hideProgressBar() {
    if (_isProgressShow) {
      Navigator.pop(context);
      _isProgressShow = false;
    }
  }

  void showCDBDialog({
    String alertImagePath = AppImages.alertIcon,
    @required String title,
    @required Widget body,
    bool isTwoButton = false,
    @required String negativeButtonText,
    String positiveButtonText,
    Color negativeButtonTextColor = AppColors.grayColor,
    Color positiveButtonTextColor = AppColors.accentColor,
    Gradient negativeButtonGradient = AppColors.greyGradient,
    Gradient positiveButtonGradient = AppColors.outlineGradient,
    @required Function negativeButtonTap,
    Function positiveButtonTap,
    bool isPng = false,
  }) {
    showGeneralDialog(
        context: context,
        barrierLabel: "",
        barrierDismissible: false,
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: CDBDialog(
                title: title,
                negativeButtonText: negativeButtonText,
                positiveButtonText: positiveButtonText,
                negativeButtonTap: negativeButtonTap,
                positiveButtonTap: positiveButtonTap,
                body: body,
                isTwoButton: isTwoButton,
                negativeButtonTextColor: negativeButtonTextColor,
                positiveButtonTextColor: positiveButtonTextColor,
                negativeButtonGradient: negativeButtonGradient,
                positiveButtonGradient: positiveButtonGradient,
                alertImagePath: alertImagePath,
                isPng: isPng,
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _dontMessWithUs();
    if (AppConstants.IS_USER_LOGGED) {
      _initializeTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: BlocProvider<BaseBloc>(
        create: (_) => getBloc(),
        child: BlocListener<BaseBloc, BaseState>(
          bloc: getBloc(),
          listener: (context, state) {
            if (state is APILoadingState) {
              showProgress(context);
            } else {
              hideProgressBar();
              if (state is SessionExpireState) {
                if (AppConstants.IS_USER_LOGGED) {
                  showCDBDialog(
                      title: 'Error',
                      negativeButtonTap: () {
                        logout();
                      },
                      negativeButtonText: 'Logout',
                      body: const Text('Session timeout!'));
                }
              }
            }
          },
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerCancel: _handleUserInteraction,
            onPointerDown: _handleUserInteraction,
            onPointerMove: _handleUserInteraction,
            onPointerSignal: _handleUserInteraction,
            onPointerUp: _handleUserInteraction,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Platform.isAndroid
                  ? buildView(context)
                  : SafeArea(
                      left: false,
                      right: false,
                      top: false,
                      bottom: false,
                      minimum: const EdgeInsets.only(bottom: 10),
                      child: buildView(context)),
            ),
          ),
        ),
      ),
    );
  }
}
