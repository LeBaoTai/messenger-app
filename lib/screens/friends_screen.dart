import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key, required this.user});

  final User user;

  @override
  State<FriendsScreen> createState() => _GroupState();
}

class _GroupState extends State<FriendsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _leftGes = true;
  bool _rightGes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 4,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          _friendViewBar(),
          _buildUserList(),
        ],
      ),
    );
  }

  Row _friendViewBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 150,
            decoration: BoxDecoration(
                color: _leftGes ? Colors.grey : null,
                borderRadius: BorderRadius.circular(20)),
            child: const Text(
              'All Friends',
              style: TextStyle(
                fontSize: 19,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _leftGes = true;
              _rightGes = false;
            });
          },
        ),
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 150,
            decoration: BoxDecoration(
                color: _rightGes ? Colors.grey : null,
                borderRadius: BorderRadius.circular(20)),
            child: const Text(
              'Requests',
              style: TextStyle(
                fontSize: 19,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _rightGes = true;
              _leftGes = false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildUserList() {
    if (_leftGes) {
      return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          var currentDoc = snapshot.data!.docs
              .firstWhere((doc) => doc.id == widget.user.uid);
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((doc) => _buildUserItem(doc, currentDoc))
                .toList(),
          );
        },
      );
    } else if(_rightGes) {
      return Container();
    } else {
      return Container();
    }
  }

  Widget _buildUserItem(DocumentSnapshot doc, DocumentSnapshot currentDoc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Map<String, dynamic> current = currentDoc.data() as Map<String, dynamic>;

    if (current['listFriends'].contains(data['uuid'])) {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 5),
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
    return SizedBox();
  }
}
