import 'package:flutter/material.dart';
import 'package:task_manager/UI/screen/sign_in_screen.dart';
import 'package:task_manager/UI/screen/sign_up_screen.dart';
import 'UI/screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)
          ),

        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
          ),
        ),

        textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
        ),

      ),
      routes: <String , WidgetBuilder>{
        '/': (_) => SplashScreen(),
        '/sign-in':(_) => SignInScreen(),
        '/sign-up':(_) => SignUpScreen()
      },
      initialRoute: '/',
    );
  }
}
