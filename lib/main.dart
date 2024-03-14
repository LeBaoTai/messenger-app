import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/screens/home_screen.dart';
import 'package:messenger_app/screens/login_screen.dart';
import 'package:messenger_app/screens/register_screen.dart';
import 'package:messenger_app/services/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyC6qB8YbUoTTSxso9HjW1CZiqcOpHYEQ14',
        appId: '1:1023739173542:android:38ce7048a85c6cefa47267',
        messagingSenderId: '1023739173542',
        projectId: 'messenger-7a021'
    ),
  );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}