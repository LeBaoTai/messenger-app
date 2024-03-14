import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/services/auth/user_auth_service.dart';

class UserAuthController {
  final UserAuthService _userAuthService = UserAuthService();

  bool login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    Future<UserCredential?> userCredential = _userAuthService.signInWithEmailAndPassword(email, password);
    return userCredential != null;
  }

  bool register(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    Future<User?> user = _userAuthService.signUpWithEmailAndPassword(email, password);
    return user != null;
  }
}