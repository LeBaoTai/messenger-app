import 'package:flutter/material.dart';
import 'package:messenger_app/controllers/user_auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

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
            padding: const EdgeInsets.only(left: 25, right: 25),
            children: [
              Image.asset('assets/login/register_banner.jpg'),
              _renderSizeBox(),
              _buildEmailInputField(_usernameController, 'Email'),
              _renderSizeBox(),
              _buildPasswordInputField(_passwordController, 'Password'),
              _renderSizeBox(),
              _registerBtn(),
              _renderSizeBox(),
              _backToLoginBtn(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildEmailInputField(TextEditingController controller, String labelText) {
    return TextFormField(
      validator: (text) => text!.isEmpty ? "Không được để trống" : null,
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

  Widget _buildPasswordInputField(TextEditingController controller, String labelText) {
    return TextFormField(
      validator: (text) => text!.isEmpty ? "Không được để trống" : null,
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
          icon: _isShowPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelText: labelText,
      ),
    );
  }

  Widget _registerBtn() {
    return IconButton(
      onPressed: () {
        String email = _usernameController.text;
        String password = _passwordController.text;

        bool validate = _formKey.currentState!.validate();

        bool isRegister = _userController.register(email, password);
        if (!isRegister) {
          if(!validate) {
            print('kh the tao acc');
          }
        }
      },
      icon: const Icon(Icons.near_me),
    );
  }

  Widget _backToLoginBtn() {
    return IconButton(
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _renderSizeBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
