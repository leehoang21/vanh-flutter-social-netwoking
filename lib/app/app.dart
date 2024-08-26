import 'package:commons/commons.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:flutter/material.dart';

import '../routes/finplus_routes.dart';
import '../utils/styles_config.dart';
import 'app_bindings.dart';

class FinPlus extends StatelessWidget {
  const FinPlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onDispose: AppConnection.closeListenerConnection,
      debugShowCheckedModeBanner: false,
      navigatorKey: LoadingOverlay.instance.navigatorKey,
      getPages: AppNavigate.finplus,
      initialRoute: Routes.login,
      locale: const Locale('vi'),
      fallbackLocale: const Locale('en'),
      theme: lightTheme,
      themeMode: ThemeMode.light,
      initialBinding: FinPlusBindings(),
    );
  }
}
