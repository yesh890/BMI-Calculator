import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_form_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/page_header.dart';
import '../widgets/page_heading.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  static const routeName = "/Loginpage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLogin = true;
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: PageHeading(
              title: "BMI Calculator",
            ),
            backgroundColor: Colors.lightBlueAccent),
        body: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                PageHeader(),
                PageHeading(
                  title: 'Log-in',
                ),
                CustomInputField(
                    controller: _emailController,
                    labelText: 'Email Address',
                    hintText: 'Your email id',
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'Email is required!';
                      }
                      if (!EmailValidator.validate(textValue)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                CustomInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Your password',
                  obscureText: true,
                  suffixIcon: true,
                  validator: (textValue) {
                    if (textValue == null || textValue.isEmpty) {
                      return 'Password is required!';
                    }
                    if (textValue.length < 8) {
                      return "Password Must be of atleast 8 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: CustomFormButton(
                    innerText: _isLogin ? 'Login' : "Signup",
                    onPressed: _handleLoginUser,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: 
                    Text(_isLogin
                        ? "Create an account"
                        : 'I already have an account',style:const TextStyle(color: Colors.grey),)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLoginUser() async {
    // login user
    final isVaild = _loginFormKey.currentState!.validate();

    if (!isVaild) {
      return;
    }
    _loginFormKey.currentState!.save();
    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString());
      } else {
        await _firebase.createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Authentication failed.')));
    }
  }
}
