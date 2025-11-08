import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 8,
          children: [
            SizedBox(height: 60,),
            Text('OTP Verification',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text('A 6 digit OTP has been sent to your email address',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: 8,),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              appContext: context,
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

  void _onTabSubmitButton (){}

  void _onTapSignInButon () {
    Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (predicate)=>false);
  }
}
