import 'package:commons/commons.dart';

import '../finplus/screens/home/home.dart';
import '../finplus/screens/login/login.dart';
import '../finplus/screens/login/login_bindings.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
}

class AppNavigate {
  static final List<GetPage<dynamic>> finplus = [
    GetPage(name: Routes.home, page: () => const Home()),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBindings(),
    ),
  ];
}