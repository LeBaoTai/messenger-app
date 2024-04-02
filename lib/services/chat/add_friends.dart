import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Friend {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFriend(String friendId) async {
    String userId = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(userId).update({
    'listFriends': FieldValue.arrayUnion([friendId])
    });

    await _firestore.collection('users').doc(friendId).update({
      'listFriends': FieldValue.arrayUnion([userId])
    });
  }
}