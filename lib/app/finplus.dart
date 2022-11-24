import 'package:commons/commons.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:flutter/material.dart';

class FinPlus extends StatelessWidget {
  const FinPlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: LoadingOverlay.instance.navigatorKey,
      getPages: AppNavigate.finplus,
      initialRoute: Routes.home,
      locale: const Locale('vi'),
      fallbackLocale: const Locale('en'),
    );
  }
}
