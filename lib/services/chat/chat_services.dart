import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/models/message.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    // get current user
    final String currentUserId = _auth.currentUser!.uid.toString();
    final String currentUserName = _auth.currentUser!.displayName.toString();
    final Timestamp timestamp = Timestamp.now();


    // insert user when send first message
    DocumentSnapshot userDocSend = await _fireStore.collection('users').doc(currentUserId).get();
    Map<String, dynamic> userDataSend = userDocSend.data() as Map<String, dynamic>;
    List chatIdListSend = userDataSend['current_chats'];

    if (chatIdListSend.contains(receiverId)) {
      chatIdListSend.remove(receiverId);
      chatIdListSend.add(receiverId);
      chatIdListSend.reversed;
    } else {
      chatIdListSend.add(receiverId);
      chatIdListSend.reversed;
    }

    DocumentSnapshot userDocRec = await _fireStore.collection('users').doc(receiverId).get();
    Map<String, dynamic> userDataRec = userDocRec.data() as Map<String, dynamic>;
    List chatIdListRec = userDataRec['current_chats'];

    if (chatIdListRec.contains(currentUserId)) {
      chatIdListRec.remove(currentUserId);
      chatIdListRec.add(currentUserId);
      chatIdListRec.reversed;
    } else {
      chatIdListRec.add(currentUserId);
      chatIdListRec.reversed;
    }

    await _fireStore.collection('users').doc(currentUserId).update({
      'current_chats': FieldValue.delete()
    });

    await _fireStore.collection('users').doc(currentUserId).update({
      'current_chats': FieldValue.arrayUnion(chatIdListSend)
    });

    await _fireStore.collection('users').doc(receiverId).update({
      'current_chats': FieldValue.delete(),
    });

    await _fireStore.collection('users').doc(receiverId).update({
      'current_chats': FieldValue.arrayUnion(chatIdListRec),
    });

    MessageModel newMessage = MessageModel(
        senderId: currentUserId,
        senderName: currentUserName,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    List ids = [currentUserId, receiverId];
    ids.sort();

    String chatRoomId = ids.join('_');

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();

    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
