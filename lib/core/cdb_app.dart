import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_localizations.dart';
import '../utils/navigation_routes.dart';
import 'services/dependency_injection.dart';

class CDBApp extends StatefulWidget {
  @override
  _CDBAppState createState() => _CDBAppState();
}

class _CDBAppState extends State<CDBApp> {
  final observer = inject<FirebaseAnalyticsObserver>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        title: kAppName,
        onGenerateRoute: Routes.generateRoute,
        navigatorObservers: <NavigatorObserver>[observer],
          initialRoute: Routes.kSplashView,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.85),
          child: child,
        ),
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: AppColors.primaryColor,
          accentColor: AppColors.accentColor,
          fontFamily: kFontFamily,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10.0),
            trackBorderColor:
                MaterialStateProperty.all(AppColors.separationLinesColor),
            thickness: MaterialStateProperty.all(6.0),
            thumbColor: MaterialStateProperty.all(AppColors.accentColor),
          ),
          splashColor: AppColors.primaryColor,
          highlightColor: AppColors.primaryColor,
          unselectedWidgetColor: AppColors.textDarkColor,
        ),
        supportedLocales: const [
          Locale(kLocaleEN, "US"),
          Locale(kLocaleSI, "LK"),
          Locale(kLocaleTA, "TA")
        ],
        locale: const Locale(kLocaleEN, "US"),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
