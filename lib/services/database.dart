// ignore_for_file: unnecessary_await_in_return

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finplus/models/chat_room_model.dart';
import 'package:finplus/models/message_chat_model.dart';

import '../models/post_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  final database = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future updateUserData(String uid, String name) async {
    return await userCollection.add(
      {
        'uid': uid,
        'name': name,
      },
    );
  }

  Future post(PostModel post) async {
    return await FirebaseFirestore.instance.collection('post').add({
      'name': post.name,
      'uid': post.uid,
      'content': post.content,
      'time': post.time,
    });
  }

  Future postInGroup(PostModel post) async {
    return await FirebaseFirestore.instance.collection('postInGroup').add({
      'name': post.name,
      'uid': post.uid,
      'content': post.content,
      'time': post.time,
    });
  }

  Future createChatRoom(ChatRoomModel chatRoom) async {
    return await FirebaseFirestore.instance.collection('chatRoom').add(
      {
        'name': chatRoom.name,
        'id': chatRoom.id,
        'type': chatRoom.type.name,
        'listUid': FieldValue.arrayUnion(chatRoom.listUid),
      },
    );
  }

  Future sendMessage(int id, MessageChatModel message, int idMessage) async {
    return await FirebaseFirestore.instance.collection('chatMessage').add(
      {
        'id': id,
        'listMessage': FieldValue.arrayUnion(
          [
            {
              'content': message.content,
              'name': message.name,
              'time': message.time,
            },
          ],
        ),
        'idMessage': idMessage,
      },
    );
  }

  Future saveCredential(String credential, String publicKey) async {
    return await FirebaseFirestore.instance.collection('credentials').add(
      {
        'credential': credential,
        'publcKey': publicKey,
      },
    );
  }
}
