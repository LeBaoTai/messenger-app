import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/screens/home_screen.dart';
import 'package:messenger_app/screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user login
          if(snapshot.hasData) {
            return HomeScreen();
          }
          // user not login
          else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
