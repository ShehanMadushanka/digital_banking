//region Description
// This is the main class for the Production environment
//endregion

import 'package:cdb_mobile/core/cdb_app.dart';
import 'package:cdb_mobile/core/services/dependency_injection.dart' as di;
import 'package:cdb_mobile/features/presentation/views/intro/marketing_banner_one_view.dart';
import 'package:cdb_mobile/utils/enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flavor_config.dart';

void main() async {
  FlavorConfig(flavor: Flavor.LIVE, color: Colors.amber, values: FlavorValues());
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await di.setupLocator();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (_) {},
      child: CDBApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
