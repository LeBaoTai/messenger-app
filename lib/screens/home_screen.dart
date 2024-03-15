import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messenger_app/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputMessageController = TextEditingController();

  final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_homeController.getUserName()!),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildInputField() {
    return TextFormField(
      controller: _inputMessageController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'Nhap',
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

    if (_homeController.getAuthInstance().currentUser!.email != data['name']) {
      return ListTile(
        title: Text('${data['name']}'),
        onTap: () {
          print('taped');
        },
      );
    }
    return Container();
  }

  void _signOut() {
    _homeController.signOut();
  }
}
