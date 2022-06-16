import 'package:dapp/utils/navigation.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void locatorSetup() {
  locator
      .registerLazySingleton<NavigationHandler>(() => NavigationHandlerImpl());
}
