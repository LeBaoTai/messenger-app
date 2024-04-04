import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/services/auth/user_auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  final UserAuthService _authService = UserAuthService();

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
              _buildUserNameInputField(_userNameController, 'Username'),
              _renderSizeBox(),
              _buildEmailInputField(_emailController, 'Email'),
              _renderSizeBox(),
              _buildPasswordInputField(_passwordController, 'Password'),
              _renderSizeBox(),
              _buildPasswordInputField(_rePasswordController, 'Repeat Password'),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _checkMatchPassword() {
    String password = _passwordController.text;
    String rePassword = _rePasswordController.text;

    if (password != rePassword) {
      return 'Password doesn\'t match!';
    }
    return null;
  }

  _checkValidEmail() {
    String email = _emailController.text;
    return EmailValidator.validate(email) ? null : 'Email is not valid.';
  }


  Widget _buildUserNameInputField(TextEditingController controller, String labelText) {
    return TextFormField(
      validator: (text) => text!.isEmpty ? 'Empty!' : null,
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

  Widget _buildEmailInputField(TextEditingController controller, String labelText) {
    return TextFormField(
      validator: (text) => text!.isEmpty ? 'Empty!' : _checkValidEmail(),
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
      validator: (text) => text!.isEmpty ? 'Empty!' : _checkMatchPassword(),
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
        String username = _userNameController.text;
        String email = _emailController.text;
        String password = _passwordController.text;

        bool validate = _formKey.currentState!.validate();

        if (validate) {
          _authService.signUpWithEmailAndPassword(email, password, username).then((value) {
            final snackBar = SnackBar(
              content: Text(value),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  if (value == 'Success.') {
                    Navigator.pop(context);
                  }
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      },
      icon: const Icon(Icons.app_registration_rounded),
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
