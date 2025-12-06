import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/scaffold_message.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/my_urls.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isInProgress = false;

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
                'OTP Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'A 6 digit OTP has been sent to your email address',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 8),
              PinCodeTextField(
                controller: _otpController,
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
                  inactiveFillColor: Colors.white,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                appContext: context,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return "Enter 6 digit OTP from email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              Visibility(
                visible: isInProgress == false,
                replacement: CircularProgressIndicator(),
                child: FilledButton(
                  onPressed: _onTabSubmitButton,
                  child: Text('Verify'),
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
    isInProgress = true;
    setState(() {});
    final otp = _otpController.text;
    final email = ModalRoute.of(context)!.settings.arguments.toString();

    NetworkResponse response = await NetworkCaller.getRequest(
      MyUrls.verifyOtp(email, otp),
    );

    if (response.isSuccess) {
      trueScaffoldMessage(context, "OTP verified!");
      Navigator.pushNamed(
        context,
        '/reset-password',
        arguments: {"email": email, "otp": otp},
      );
    } else {
      falseScaffoldMessage(context, response.errorMessage);
    }
    isInProgress = false;
    setState(() {});
  }

  void _onTapSignInButon() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/sign-in',
      (predicate) => false,
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
