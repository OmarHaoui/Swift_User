import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_screen_size.dart';
import 'package:swift_user1/screens/onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const OnboardingScreen())),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/swift1.jpg",
          width: AppSceenSize.getWidth(context) - 80,
        ),
      ),
    );
  }
}
