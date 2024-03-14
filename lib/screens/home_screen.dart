import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
