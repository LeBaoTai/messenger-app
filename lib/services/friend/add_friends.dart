import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFriend(String friendId) async {
    String userId = _auth.currentUser!.uid;
    try {
      await _firestore.collection('users').doc(userId).update({
      'listFriends': FieldValue.arrayUnion([friendId])
      });

      await _firestore.collection('users').doc(friendId).update({
        'listFriends': FieldValue.arrayUnion([userId])
      });

      await _firestore.collection('users').doc(friendId).update({
        'pending': FieldValue.arrayRemove([userId])
      });
    } catch(e) {
      print(e);
    }
  }

  Future<void> pendingRequest(String requestId) async {
    String userId = _auth.currentUser!.uid;

    try {
      await _firestore.collection('users').doc(requestId).update({
        'requests': FieldValue.arrayUnion([userId])
      });

      await _firestore.collection('users').doc(userId).update({
        'pending': FieldValue.arrayUnion([requestId])
      });
    } catch(e) {
      print(e);
    }
  }
}