import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/scaffold_message.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  final bool isVerifyInProgress = false;

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
                'Your Email Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'A 6 digit OTP sent will be sent to your email address',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 8),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter email to forget your password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Visibility(
                visible: isVerifyInProgress == false,
                replacement: CircularProgressIndicator(),
                child: FilledButton(
                  onPressed: _onTabSubmitButton,
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
                  text: "Have account? ",
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
    );
  }

  void _onTabSubmitButton() async {
    isVerifyInProgress == true;
    setState(() {});
    final myEmail = _emailController.text.trim();
    if (myEmail.isNotEmpty) {
      NetworkResponse response = await NetworkCaller.getRequest(
        MyUrls.verifyEmail(myEmail),
      );

      if (response.isSuccess) {
        trueScaffoldMessage(context, "OTP sent successfully!");
        Navigator.pushNamed(context, '/verify-otp');
      } else {
        falseScaffoldMessage(context, response.errorMessage);
      }
      isVerifyInProgress == false;
      setState(() {});
    }
  }

  void _onTapSignInButon() {
    Navigator.pop(context);
  }
}
