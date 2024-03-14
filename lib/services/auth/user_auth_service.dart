import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(credential.user?.uid).set({
        'name': credential.user?.email,
      }, SetOptions(merge: true));

      return credential;
    } catch(e) {
      return null;
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(credential.user?.uid).set({
        'name': credential.user?.email,
      });

      return credential.user;
    } catch(e) {
      return null;
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}