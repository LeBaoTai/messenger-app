import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/screens/chat_screen.dart';
import 'package:messenger_app/screens/friends_screen.dart';
import 'package:messenger_app/screens/profile_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.displayName ?? 'Null'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: const Icon(Icons.info),
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FriendsScreen(user: widget.user)));
              },
              icon: const Icon(
                Icons.people,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        var currentDoc = snapshot.data!.docs
            .firstWhere((doc) => doc.id == widget.user.uid);
        Map<String, dynamic> current = currentDoc.data() as Map<String, dynamic>;
        List currentChats = current['current_chats'];

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs
              .map((doc) => _buildUserItem(doc, currentChats))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserItem(DocumentSnapshot doc, List currentChat) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (currentChat.contains(data['uuid'])) {
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
                      receiverName: data['username'].toString(),
                      receiverId: data['uuid'],
                    ),
              ),
            );
          },
        ),
      );
    }
    return const SizedBox();
  }
}
