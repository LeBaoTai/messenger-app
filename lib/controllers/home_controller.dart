import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/services/auth/user_auth_service.dart';

class HomeController {
  final UserAuthService _service = UserAuthService();

  void signOut() {
    _service.signOut();
  }

  String? getUserName() {
    return FirebaseAuth.instance.currentUser?.email;
  }

}