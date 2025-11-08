import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';

class ForgotPasswardEmailScreen extends StatefulWidget {
  const ForgotPasswardEmailScreen({super.key});

  @override
  State<ForgotPasswardEmailScreen> createState() => _ForgotPasswardEmailScreenState();
}

class _ForgotPasswardEmailScreenState extends State<ForgotPasswardEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          children: [
            SizedBox(height: 60,),
            Text('Your Email Address',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('A 6 digit OTP sent will be sent to your email address',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email'
              )
            ),
            SizedBox(height: 8,),
            FilledButton(
                onPressed: _onTabSubmitButton, child: Icon(Icons.arrow_circle_right_outlined)
            ),
            SizedBox(height: 24,),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                text: "Have account? ",
                children: [
                  TextSpan(
                    style: TextStyle(
                      color: Colors.green
                    ),
                    text: "Sign In",
                    recognizer: TapGestureRecognizer()
                      ..onTap = _onTapSignInButon
                  )
                ]
              ),
            )
          ],
        ),
      )
      ),
    );
  }

  void _onTabSubmitButton (){
    Navigator.pushNamed(context, '/verify-otp');
  }

  void _onTapSignInButon () {
    Navigator.pop(context);
  }
}
