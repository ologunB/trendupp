import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String Onboard = '/onboarding-view';
const String LoginLayout = '/login-layout-view';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginLayout:
      return _getPageRoute(
        routeName: settings.name!,
        view: Text(''),
        args: settings.arguments!,
      );

    default:
      return CupertinoPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute<dynamic> _getPageRoute(
    {required String routeName,
    required Widget view,
    required Object args,
    bool dialog = false}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view,
      fullscreenDialog: dialog);
}

void push(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.push<void>(
      context,
      CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => view, fullscreenDialog: dialog));
}

void pushReplacement(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.pushReplacement(
      context,
      CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => view, fullscreenDialog: dialog));
}

void pushAndRemoveUntil(BuildContext context, Widget view,
    {bool dialog = false}) {
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute<dynamic>(
        builder: (BuildContext context) => view, fullscreenDialog: dialog),
        (Route<dynamic> route) => false,
  );
}
