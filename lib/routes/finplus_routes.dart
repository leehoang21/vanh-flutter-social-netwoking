import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat/chat.dart';
import 'package:finplus/finplus/screens/chat_room/chat_room.dart';

import '../finplus/screens/chat/chat_bindings.dart';
import '../finplus/screens/chat_room/chat_room_bindings.dart';
import '../finplus/screens/home/home.dart';
import '../finplus/screens/home/home_bindings.dart';
import '../finplus/screens/login/login.dart';
import '../finplus/screens/login/login_bindings.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String chat_room = '/chat_room';
  static const String chat = '/chat';
}

class AppNavigate {
  static final List<GetPage<dynamic>> finplus = [
    GetPage(
      name: Routes.home,
      page: () => const Home(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const Chat(),
      binding: ChatBindings(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.chat_room,
      page: () => const ChatRoom(),
      binding: ChatRoomBindings(),
    ),
  ];
}
