import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_asset_image.dart';
import 'package:swift_user1/constant/app_text_style.dart';

import '../../../../constant/app_screen_size.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

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
              AppAssetImage.onboardingScreen2,
              width: AppSceenSize.getWidth(context),
              height: AppSceenSize.getHeight(context) * 0.3,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            "Confirm Your Driver",
            style: AppTextStyle.onboaringTitle,
          ),
          const SizedBox(
            height: 36,
          ),
          SizedBox(
            width: AppSceenSize.getWidth(context) * 0.7,
            child: Text(
              "Huge drivers network helps you find comforable, safe and cheap ride",
              style: AppTextStyle.onboaringSubtitle,
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
    );
  }
}
