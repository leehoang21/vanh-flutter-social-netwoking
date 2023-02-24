const _prefix = '/api/v1';

class ApiPath {
  static const String login = '$_prefix/login';

  //market
  static const String symbolStatic = '/media/symbol_static_data.json';
  static const String symbolLatest = '$_prefix/market/symbolLatest';

  //community
  static const String feed = '$_prefix/community/feed';
  static const String feed_react = '$_prefix/community/feed/react';

  //chat
  static const String room = '$_prefix/chat/room';
  static const String joinRoom = '$_prefix/chat/room/join';
  static const String leftRoom = '$_prefix/chat/room/left';
  static const String addUserToRoom = '$_prefix/chat/room/addUser';
  static const String removeUserToRoom = '$_prefix/chat/room/removeUser';
  static const String message = '$_prefix/chat/message';
  static const String userList = '$_prefix/chat/room/userList';
}
