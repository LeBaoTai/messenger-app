import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/models/user.dart';

class UserAuthService {

  signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set({
        'username': credential.user?.displayName,
        'email': credential.user?.email,
        'uuid': credential.user?.uid,
      }, SetOptions(merge: true));
      
      return 'Success.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found!';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password!';
      } 
    }
  }

  signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      final signUpAuth = FirebaseAuth.instance;
      UserCredential credential = await signUpAuth.createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(username);
      await credential.user!.reload();
      await signUpAuth.signOut();

      UserModel newUser = UserModel(uuid: credential.user!.uid, username: username, email: email, friends: [], pending: [], requests: [], currentChats: []);
      FirebaseFirestore.instance.collection('users').doc(credential.user?.uid).set(newUser.toMap());

      return 'Success.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    }
  }

  signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}