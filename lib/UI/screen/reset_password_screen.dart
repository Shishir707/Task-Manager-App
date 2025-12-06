import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';
import 'package:task_manager/UI/widgets/center_progress.dart';
import '../../data/service/network_caller.dart';
import '../../data/utils/my_urls.dart';
import '../widgets/scaffold_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

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
                  'Reset Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Minimum length of password should more than 8 characters',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _newController,
                  decoration: InputDecoration(hintText: 'New Password'),
                  validator: (String? value) {
                    if (value!.isEmpty || value.length < 6) {
                      return "Password at least 6 digit";
                    }
                    return null;
                  },
                ),
                SizedBox(),
                TextFormField(
                  controller: _confirmController,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  validator: (String? value) {
                    if (value != _newController.text) {
                      return "Confirm password does not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Visibility(
                  visible: isLoading == false,
                  replacement: CenterCircularProgress(),
                  child: FilledButton(
                    onPressed: _onTabSubmitButton,
                    child: Text('Confirm'),
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
      ),
    );
  }

  Future<void> _onTabSubmitButton() async {
    if (_formKey.currentState!.validate()) {
      final password = _confirmController.text;

      isLoading = true;
      setState(() {});
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final email = args["email"];
      final otp = args["otp"];

      Map<String, dynamic> requestBody = {
        "email": email,
        "OTP": otp,
        "password": password,
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        MyUrls.resetPassword,
        body: requestBody,
      );

      if (response.isSuccess) {
        trueScaffoldMessage(context, "Successfully Reset. Please log in..!");
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/sign-in',
          (predicate) => false,
        );
      } else {
        falseScaffoldMessage(context, response.errorMessage);
      }
      isLoading = false;
      setState(() {});
    }
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
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
