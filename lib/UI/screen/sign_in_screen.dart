import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              TextFormField(decoration: InputDecoration(hintText: 'Email')),
              TextFormField(decoration: InputDecoration(hintText: 'Passward')),
              SizedBox(height: 8),
              FilledButton(
                onPressed: _onTabSignInButton,
                child: Icon(Icons.arrow_circle_right_outlined),
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: _onTanForgotPasswardButton,
                child: Text('Forgot Passward?'),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  text: "Dont have an account? ",
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

  void _onTabSignInButton() {}

  void _onTanForgotPasswardButton() {
    Navigator.pushNamed(context, '/forgot-email');
  }

  void _onTapSignUpButon() {
    Navigator.pushNamed(context, '/sign-up');
  }
}
