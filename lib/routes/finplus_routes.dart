import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/chat_room/chat_room.dart';
import 'package:finplus/finplus/screens/create_chat_room/create_chat_room.dart';
import 'package:finplus/finplus/screens/create_chat_room/create_chat_room_bindings.dart';
import 'package:finplus/finplus/screens/create_post/create_post.dart';
import 'package:finplus/finplus/screens/create_post/create_post_bindings.dart';
import 'package:finplus/finplus/screens/search_group/search_group_binding.dart';
import 'package:finplus/finplus/screens/upsert_group/upsert_group.dart';

import '../finplus/screens/chat_room/chat_room_bindings.dart';
import '../finplus/screens/home/home.dart';
import '../finplus/screens/home/home_bindings.dart';
import '../finplus/screens/login/login.dart';
import '../finplus/screens/login/login_bindings.dart';
import '../finplus/screens/search_group/search_group.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String chat_room = '/chat_room';
  static const String create_chat_room = '/create_chat_room';
  static const String create_post = '/create_post';
  static const String chat = '/chat';
  static const String search_group = '/search_group';
  static const String feed_detail = '/feed_detail';
  static const String upsert_group = '/upsert_group';
}

class AppNavigate {
  static final List<GetPage<dynamic>> finplus = [
    GetPage(
      name: Routes.home,
      page: () => const Home(),
      binding: HomeBindings(),
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
    GetPage(
      name: Routes.create_chat_room,
      page: () => const CreateChatRoom(),
      binding: CreateChatRoomBindings(),
    ),
    GetPage(
      name: Routes.create_post,
      page: () => const CreatePost(),
      binding: CreatePostBindings(),
    ),
    GetPage(
      name: Routes.search_group,
      page: () => const SearchGroup(),
      binding: SearchGroupBindings(),
    ),
    GetPage(
      name: Routes.upsert_group,
      page: () => const UpsertGroup(),
    ),
  ];
}
