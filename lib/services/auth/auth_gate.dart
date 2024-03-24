import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/screens/home_screen.dart';
import 'package:messenger_app/screens/login_screen.dart';

class AuthGate extends StatelessWidget {
  AuthGate({Key? key}) : super(key: key);
  final _authState = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _authState,
        builder: (context, snapshot) {
          // user login
          if(snapshot.hasData) {
            return HomeScreen(user: snapshot.data!);
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
