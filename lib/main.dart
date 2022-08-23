import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mms_app/core/routes/router.dart';
import 'package:mms_app/locator.dart';
import 'package:mms_app/views/auth/splash_view.dart';
import 'package:provider/provider.dart';
import 'core/storage/local_storage.dart';
import 'core/utils/navigator.dart';
import 'dart:io';

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
    await FlutterStatusbarManager.setNetworkActivityIndicatorVisible(true);
    await FlutterStatusbarManager.setHidden(false);
    await FlutterStatusbarManager.setTranslucent(true);
    await FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
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
        title: 'TrendUp',
        theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashView(),
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
