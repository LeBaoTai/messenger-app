import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              icon: Icon(
                Icons.home,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FriendsScreen()));
              },
              icon: Icon(
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
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        final Map<String, dynamic> userData =
            snapshot.data?.data() as Map<String, dynamic>;
        final friendList = List.from(userData['listFriend']);
        return ListView(
          children:
              friendList.map((friend) => _buildFriendItem(friend)).toList(),
        );
      },
    );
  }

  Widget _buildFriendItem(User friend) {
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
        title: Text(friend.displayName!),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                receiverEmail: friend.email.toString(),
                receiverId: friend.uid,
              ),
            ),
          );
        },
      ),
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
                builder: (context) => ChatScreen(
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
