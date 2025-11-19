import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            spacing: 8,
            children: [
              SizedBox(height: 60),
              Text(
                'Get Started With',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              SizedBox(height: 8),
              TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email')),
              TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Passward')),
              SizedBox(height: 8),
              FilledButton(
                onPressed: _onTabSignInButton,
                child: Icon(Icons.arrow_circle_right_outlined),
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: _onTanForgotPasswordButton,
                child: Text('Forgot Password?'),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  text: "Don't have an account? ",
                  children: [
                    TextSpan(
                      style: TextStyle(color: Colors.green),
                      text: "Sign Up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onTapSignUpButon,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTanForgotPasswordButton() {
    Navigator.pushNamed(context, '/forgot-email');
  }

  void _onTapSignUpButon() {
    Navigator.pushNamed(context, '/sign-up');
  }

  void _onTabSignInButton() {

  }

  void _signIn() {
    setState(() {});

    loader = true;

    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        MyUrls.login, body: requestBody);

    if (response.isSuccess){

    }else{

    }
  }


}
