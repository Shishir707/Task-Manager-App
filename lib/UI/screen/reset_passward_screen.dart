import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';

class ResetPasswardScreen extends StatefulWidget {
  const ResetPasswardScreen({super.key});

  @override
  State<ResetPasswardScreen> createState() => _ResetPasswardScreenState();
}

class _ResetPasswardScreenState extends State<ResetPasswardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          children: [
            SizedBox(height: 60,),
            Text('Reset Passward',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('Minimum length of passward should more than 8 characters',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8,),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'New Passward'
              )
            ),
            SizedBox(),
            TextFormField(
                decoration: InputDecoration(
                    hintText: 'Confirm Passward'
                )
            ),
            SizedBox(height: 8,),
            FilledButton(
                onPressed: _onTabSubmitButton, child: Text('Confirm',)
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
  }

  void _onTapSignInButon () {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (predicate) => false);
  }
}
