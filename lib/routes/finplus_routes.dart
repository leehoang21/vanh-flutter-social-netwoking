import 'package:commons/commons.dart';

import '../finplus/screens/home/home.dart';

class Routes {
  static const String home = '/home';
}

class AppNavigate {
  static final List<GetPage<dynamic>> finplus = [
    GetPage(name: Routes.home, page: () => const Home()),
  ];
}
