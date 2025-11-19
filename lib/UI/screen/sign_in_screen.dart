import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/scafold_message.dart';
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  if (!EmailValidator.validate(value!) || value.isEmpty) {
                    return "Please enter your email address";
                  }
                  return null;
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return "Enter password to log in";
                  }
                  if (value!.length < 6) {
                    return "password must be at least 6 character";
                  }
                },
              ),
              SizedBox(height: 8),
              Visibility(
                visible: loader == false,
                replacement: Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
                child: FilledButton(
                  onPressed: _onTabSignInButton,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
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
    if (_passwordController.text.length < 6){
      falseScaffoldMessage(context, "Password must be at least 6 character");
    }
    if (_emailController.text.trim().isNotEmpty ||
        _passwordController.text.isNotEmpty) {
      _signIn();
    } else {
      falseScaffoldMessage(context, "Enter Your email & password correctly");
    }
  }

  Future<void> _signIn() async {
    setState(() {});

    loader = true;

    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      MyUrls.login,
      body: requestBody,
    );

    loader = false;

    if (response.isSuccess) {
      trueScaffoldMessage(context, "Login in successfully✔️");
      Navigator.pushReplacementNamed(context, "/main-bottom-nav-screen");
    } else {
      falseScaffoldMessage(context, "Incorrect email or password!. Try again");
    }
    setState(() {});
  }
}
