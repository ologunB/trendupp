import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/locator.dart';
import 'package:mms_app/views/auth/onboarding_view.dart';
import 'package:mms_app/views/auth/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:status_bar_control/status_bar_control.dart';

import 'core/storage/local_storage.dart';
import 'core/utils/navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('.config');
  await AppCache.init();
  setupLocator();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details, forceReport: true);
  };

  if (Platform.isIOS) {
    await StatusBarControl.setNetworkActivityIndicatorVisible(true);
    await StatusBarControl.setHidden(false);
    await StatusBarControl.setTranslucent(true);
    await StatusBarControl.setStyle(StatusBarStyle.LIGHT_CONTENT);
  }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TrendUpp',
        theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppCache.getIsFirst() ? OnboardingView() : SplashView(),
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
