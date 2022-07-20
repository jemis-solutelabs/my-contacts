import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_project/config.dart';
import 'package:flutter_base_project/src/analytics/analytics.dart';
import 'package:flutter_base_project/src/core/colors.dart';
import 'package:flutter_base_project/src/error_logger/error_logger.dart';
import 'package:flutter_base_project/src/features/contacts/presentation/pages/dashboard.dart';
import 'package:flutter_base_project/src/features/contacts/presentation/stores/contact_store.dart';
import 'package:flutter_base_project/src/remote_config/remote_config_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();
  await initContactStore();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  final shouldEnablePerformanceMonitoring =
      Config.appFlavor is Production && Config.appMode == AppMode.release;
  await FirebasePerformance.instance
      .setPerformanceCollectionEnabled(shouldEnablePerformanceMonitoring);

  try {
    await RemoteConfigRepository().initConfig();
    await RemoteConfigRepository().syncConfig();
  } catch (e) {
    debugPrint(e.toString());
  }

  await runZonedGuarded<Future<void>>(
    () async {
      runApp(
        EasyLocalization(
          path: 'lib/assets/strings',
          supportedLocales: const <Locale>[
            Locale('en', 'US'),
          ],
          child: App(),
        ),
      );
    },
    (error, StackTrace stackTrace) async {
      if (Config.appMode == AppMode.release) {
        await FirebaseCrashlytics.instance.recordError(error, stackTrace);
        await getErrorLogger().logEvent(
          exception: error,
          stackTrace: stackTrace,
        );
      }
    },
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //Change App Title
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context)!.delegate,
        ],
        locale: EasyLocalization.of(context)!.locale,
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        navigatorObservers: [
          navigationObserverAnalytics(),
        ],
        theme: ThemeData(
            primarySwatch: MaterialColor(
          0xFF000000,
          <int, Color>{
            50: Color(0xFF000000),
            100: Color(0xFF000000),
            200: Color(0xFF000000),
            300: Color(0xFF000000),
            400: Color(0xFF000000),
            500: Color(0xFF000000),
            600: Color(0xFF000000),
            700: Color(0xFF000000),
            800: Color(0xFF000000),
            900: Color(0xFF000000),
          },
        )),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
            primaryColor: Colors.deepOrange,
            appBarTheme: AppBarTheme(backgroundColor: transparent),
            scaffoldBackgroundColor: Colors.black54),
        home: ContactsDashboard()
        // Scaffold(
        //   body: Center(
        //     child: Builder(
        //       builder: (context) => Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Text(
        //             'welcome_message'.tr(),
        //           ),
        //           Text(
        //             RemoteConfigRepository().getString('welcome_msg'),
        //           ),
        //           ElevatedButton(
        //             onPressed: () async {

        //             },
        //             child: const Text('Action'),
        //           ),
        //           AppUpdateWidget(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
