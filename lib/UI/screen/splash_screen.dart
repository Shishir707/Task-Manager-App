import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/UI/controller/auth_controller.dart';
import 'package:task_manager/UI/screen/sign_in_screen.dart';
import 'package:task_manager/UI/widgets/backgroundScreen.dart';

import 'main_bottom_nav_holder_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 4));
    bool isAlreadyLogin = await AuthController.isUserLogin();
    if (isAlreadyLogin) {
      await AuthController.getLoginData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainBottomNavHolderScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        //child: Center(child: SvgPicture.asset(AssetsPaths.logoSvg, width: 120)),
        child: Center(
          child: Lottie.network(
            "https://lottie.host/aad9ea0a-59f4-4906-88ed-0d86ad4f18de/u9KIGn3Ob1.json",
          ),
        ),
      ),
    );
  }
}
