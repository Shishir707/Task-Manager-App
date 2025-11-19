import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/scafold_message.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 8,
              children: [
                SizedBox(height: 60),
                Text(
                  'Join with US',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter a valid email";
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return "Your email is not valid";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _firstController,
                  decoration: InputDecoration(hintText: 'First name'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter your first name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastController,
                  decoration: InputDecoration(hintText: 'Last name'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return "Enter your mobile number";
                    }
                    if (value!.length > 11 || value!.length < 11) {
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Enter a password";
                    }
                    if (value!.length < 6) {
                      return "Password must be at least 6 character";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Visibility(
                  visible: loading == false,
                  replacement: Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                  child: FilledButton(
                    onPressed: _onTabSignUpButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
                SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                        style: TextStyle(color: Colors.green),
                        text: "Sign In",
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onTapSignInButon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButon() {
    Navigator.pop(context);
  }

  void _onTabSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    loading = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstController.text.trim(),
      "lastName": _lastController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      MyUrls.registration,
      body: requestBody,
    );

    if (response.isSuccess) {
      trueScaffoldMessage(
        context,
        "Registration Successful!. Please Log in...",
      );
      _clearController();
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }
    loading = false;
    setState(() {});
  }

  void _clearController(){
    _emailController.clear();
    _firstController.clear();
    _lastController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstController.dispose();
    _lastController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
