import 'package:commons/commons.dart';

import '../finplus/screens/chat/chat.dart';
import '../finplus/screens/chat/chat_bindings.dart';
import '../finplus/screens/chat_room/chat_room.dart';
import '../finplus/screens/chat_room/chat_room_bindings.dart';
import '../finplus/screens/create_chat_room/create_chat_room.dart';
import '../finplus/screens/create_chat_room/create_chat_room_bindings.dart';
import '../finplus/screens/create_post/create_post.dart';
import '../finplus/screens/create_post/create_post_bindings.dart';
import '../finplus/screens/home/home.dart';
import '../finplus/screens/home/home_bindings.dart';
import '../finplus/screens/images_view/images_view.dart';
import '../finplus/screens/login/login.dart';
import '../finplus/screens/login/login_bindings.dart';
import '../finplus/screens/search_group/search_group.dart';
import '../finplus/screens/search_group/search_group_binding.dart';
import '../finplus/screens/webview/webview.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String chat_room = '/chat_room';
  static const String create_chat_room = '/create_chat_room';
  static const String create_post = '/create_post';
  static const String chat = '/chat';
  static const String webview = '/webview';
  static const String images_view = '/images_view';
  static const String search_group = '/search_group';
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
      name: Routes.webview,
      page: () => const WebView(),
    ),
    GetPage(
      name: Routes.images_view,
      page: () => const ImagesView(),
    ),
    GetPage(
      name: Routes.search_group,
      page: () => const SearchGroup(),
      binding: SearchGroupBindings(),
    )
  ];
}
