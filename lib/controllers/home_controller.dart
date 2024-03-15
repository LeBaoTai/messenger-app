import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth getAuthInstance() {
    return _auth;
  }

  void signOut() {
    _auth.signOut();
  }

  String? getUserName() {
    return _auth.currentUser?.email;
  }

}