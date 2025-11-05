import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          children: [
            SizedBox(height: 60,),
            Text('Join with US',style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 8,),
            TextFormField(decoration: InputDecoration(hintText: 'Email')),
            TextFormField(decoration: InputDecoration(hintText: 'First name')),
            TextFormField(decoration: InputDecoration(hintText: 'Last name')),
            TextFormField(decoration: InputDecoration(hintText: 'Mobile')),
            TextFormField(decoration: InputDecoration(hintText: 'Passward')),
            SizedBox(height: 8,),
            FilledButton(
                onPressed: _onTabSignUpButton, child: Icon(Icons.arrow_circle_right_outlined)
            ),
            SizedBox(height: 24,),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                text: "Already have an account? ",
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

  void _onTabSignUpButton (){}

  void _onTapSignInButon () {
    Navigator.pushNamed(context, '/sign-in');
  }
}
