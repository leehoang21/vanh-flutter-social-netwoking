import 'package:finplus/providers/chat_provider/chat_provider.dart';

class ChatRoomModel {
  int id;
  String name;
  ROOM_TYPE type;
  List<dynamic> listUid;

  ChatRoomModel({
    required this.id,
    required this.name,
    required this.type,
    required this.listUid,
  });
}
