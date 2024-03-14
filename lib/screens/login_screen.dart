import 'package:flutter/material.dart';
import 'package:messenger_app/controllers/user_auth_controller.dart';
import 'package:messenger_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserAuthController _userController = UserAuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGIN"),
            _buildInputField(_usernameController, false),
            _buildInputField(_passwordController, true),
            _registerBtn(),
            _loginBtn(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Widget _buildInputField(TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
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
        bool isLogin = _userController.login(email, password);
        if(!isLogin) {
          print('khong the dan nhap');
        }
      },
      icon: Icon(
        Icons.login,
        size: 30,
      ),
    );
  }

  Widget _registerBtn() {
    return IconButton(
      onPressed: () {
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
        });
      },
      icon: Icon(Icons.add),
    );
  }
}
