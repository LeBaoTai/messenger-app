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
      body: Text("home page"),
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

  void _signOut() {
    _homeController.signOut();
  }
}
