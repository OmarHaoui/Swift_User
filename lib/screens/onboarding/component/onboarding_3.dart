import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_asset_image.dart';
import 'package:swift_user1/constant/app_screen_size.dart';
import 'package:swift_user1/constant/app_text_style.dart';
import 'package:swift_user1/screens/authentication/registration.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppAssetImage.onboardingScreen3,
              width: AppSceenSize.getWidth(context),
              height: AppSceenSize.getHeight(context) * 0.3,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            "Track your ride",
            style: AppTextStyle.onboaringTitle,
          ),
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            width: AppSceenSize.getWidth(context) * 0.7,
            child: Text(
              "Know your driver in advance and be able to view current location in real time on the map",
              style: AppTextStyle.onboaringSubtitle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return RegistrationScreen();
              }));
            },
            child: Container(
              width: AppSceenSize.getWidth(context) * 0.44,
              height: 50,
              decoration: BoxDecoration(
                  color: Color(0xFF28B910),
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                  child: Text(
                "GET STARTED!",
                style: AppTextStyle.getStarted,
              )),
            ),
          ),
        ],
      )),
    );
  }
}
