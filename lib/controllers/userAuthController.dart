import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_app/services/auth/user_auth_service.dart';

class UserAuthController {
  final UserAuthService _userAuthService = UserAuthService();

  bool loginWithEmailAndPassword(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }

    Future<User?> returnUser = _userAuthService.signInWithEmailAndPassword(email, password);
    return returnUser != null;
  }
}