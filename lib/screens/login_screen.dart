import 'package:flutter/material.dart';
import 'package:messenger_app/controllers/userAuthController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserAuthController _loginController = UserAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN"),
            _buildInputField(_usernameController),
            _buildInputField(_passwordController),
            _registerBtn(),
            _loginBtn(),
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

  Widget _loginBtn() {
    return IconButton(
      onPressed: () {
        String email = _usernameController.text;
        String password = _passwordController.text;
        bool isLogin = _loginController.loginWithEmailAndPassword(email, password);

        if (isLogin) {
          setState(() {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } else {
          print('khong the dang nhap');
        }
      },
      icon: Icon(
        Icons.near_me,
        size: 30,
      ),
    );
  }

  Widget _registerBtn() {
    return IconButton(
      onPressed: () {
        setState(() {
          Navigator.pushNamed(context, '/register');
        });
      },
      icon: Icon(Icons.add),
    );
  }
}
