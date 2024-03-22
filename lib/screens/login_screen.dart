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

  final _formKey = GlobalKey<FormState>();
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(right: 25, left: 25),
            children: [
              Image.asset('assets/login/login_banner.jpg'),
              _renderSizeBox(),
              _buildEmailInputField(_usernameController, 'Email'),
              _renderSizeBox(),
              _buildPasswordInputField(_passwordController, 'Password'),
              _renderSizeBox(),
              _register(),
              _renderSizeBox(),
              _loginBtn(),
            ],
          ),
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

  Widget _buildEmailInputField(
      TextEditingController controller, String labelText) {
    return TextFormField(
      validator: (text) => text!.isEmpty ? "Empty" : null,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: labelText,
      ),
    );
  }

  Widget _buildPasswordInputField(
      TextEditingController controller, String labelText) {
    return TextFormField(
      validator: (text) => text!.isEmpty ? "Empty" : null,
      controller: controller,
      obscureText: !_isShowPassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              _isShowPassword = !_isShowPassword;
            });
          },
          icon: _isShowPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: labelText,
      ),
    );
  }

  Widget _loginBtn() {
    return IconButton(
      onPressed: () {
        String email = _usernameController.text;
        String password = _passwordController.text;
        bool isLogin = _userController.login(email, password);
        bool validate = _formKey.currentState!.validate();

        if (!isLogin && !validate) {
          print('khong the dan nhap');
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
      ),
      icon: const Icon(Icons.login),
    );
  }

  Widget _register() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Create Account?",
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          child: const Text(
            "Click Here",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }

  Widget _renderSizeBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
