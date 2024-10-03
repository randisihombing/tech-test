import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tech_test/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splash: Column(
            children: [
              Image.asset(
                "assets/images/splash_screen.png",
                height: 250,
              ),
              const SizedBox(height: 10,),
              const Text(
                "Deptech Test",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          nextScreen: const LoginPage(),
          splashIconSize: 350,
        ),
      ),
    );
  }
}
