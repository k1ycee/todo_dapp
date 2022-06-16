import 'package:dapp/constants/routes.dart';
import 'package:dapp/views/UI/auth/mnemonic_key_selection.dart';
import 'package:dapp/views/UI/auth/password.dart';
import 'package:dapp/views/UI/auth/show_mnemonics.dart';
import 'package:dapp/views/UI/auth/welcome_screen.dart';
import 'package:dapp/views/UI/todo/todo_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.HOMEROUTE:
      return _getPageRoute(routeName: settings.name, view: HomePage());
    case Routes.SHOWMNEMONICS:
      return _getPageRoute(routeName: settings.name, view: ShowMnemonics());
    case Routes.MNEMONICKEYSELECTIONROUTE:
      return _getPageRoute(routeName: settings.name, view: MnemonicKeySelection());
    case Routes.PASSWORDROUTE: 
      return _getPageRoute(routeName: settings.name, view: Password());
    case Routes.TODOROUTE:
      return _getPageRoute(routeName: settings.name, view: TodoPage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, Widget? view}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => view!,
  );
}

Route animateNavigation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
