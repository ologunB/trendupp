import 'package:get_it/get_it.dart';
import 'package:mms_app/core/api/auth_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/utils/navigator.dart';
import 'core/viewmodels/auth_vm.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton(() => AuthApi());
  locator.registerFactory(() => AuthViewModel());
}

final List<SingleChildWidget> allProviders = <SingleChildWidget>[
  ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
];
