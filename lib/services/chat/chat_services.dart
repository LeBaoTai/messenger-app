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
    await _fireStore.collection('users').doc(currentUserId).update({
      'current_chats': FieldValue.arrayUnion([receiverId])
    });

    await _fireStore.collection('users').doc(receiverId).update({
      'current_chats': FieldValue.arrayUnion([currentUserId])
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
