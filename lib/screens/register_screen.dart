import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("REGISTER"),
            _buildInputField(_usernameController),
            _buildInputField(_passwordController),
            _registerBtn(),
            _backToLoginBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'Input',
      ),
    );
  }

  Widget _registerBtn() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.near_me),
    );
  }

  Widget _backToLoginBtn() {
    return IconButton(
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
      icon: Icon(Icons.arrow_back),
    );
  }
}
