import 'package:dapp/locator.dart';
import 'package:dapp/utils/navigation.dart';
import 'package:dapp/utils/router.dart';
import 'package:dapp/viewModel/providers.dart';
import 'package:dapp/views/UI/auth/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  locatorSetup();
  await Hive.initFlutter();
  await Hive.openBox('passwordBox');
  await Hive.openBox('privateKeyBox');
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _navService = locator<NavigationHandler>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      navigatorKey: _navService.navigatorKey,
      home: HomePage(),
    );
  }
}
