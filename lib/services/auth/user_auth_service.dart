import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      _fireStore.collection('users').doc(credential.user?.uid).set({
        'name': credential.user?.email,
        'uuid': credential.user?.uid,
      }, SetOptions(merge: true));
      
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found!';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password!';
      } 
    }
  }

  signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _fireStore.collection('users').doc(credential.user?.uid).set({
        'name': credential.user?.email,
        'uuid': credential.user?.uid,
      });

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    }
  }

  signOut() async {
    return await _auth.signOut();
  }
}