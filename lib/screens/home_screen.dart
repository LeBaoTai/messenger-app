import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/models/user.dart';
import 'package:messenger_app/screens/chat_screen.dart';
import 'package:messenger_app/screens/search_screen.dart';
import 'package:messenger_app/services/auth/user_auth_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserAuthService _authService = UserAuthService();
  final Stream<
      QuerySnapshot<Map<String, dynamic>>> _firestoreStream = FirebaseFirestore
      .instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.displayName ?? 'Null'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: const Icon(Icons.add_comment_outlined),
          ),
          IconButton(
            onPressed: () => _authService.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    if (widget.user.email != data['email']) {
      return Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/home/user.png',
              width: 35,
              height: 35,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          title: Text(data['username']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(
                      receiverEmail: data['email'].toString(),
                      receiverId: data['uuid'],
                    ),
              ),
            );
          },
        ),
      );
    }
    return Container();
  }
}
