import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/screens/onboarding/component/onboarding_1.dart';
import 'package:swift_user1/screens/onboarding/component/onboarding_2.dart';
import 'component/onboarding_3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _numPages = 3; // Replace with the number of onboarding pages
  int _currentPage = 0;

  List<Widget> _screens = [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return _screens[index];
            },
            itemCount: _numPages,
          ),
          Positioned(
            bottom: 30.0,
            left: 0.0,
            right: 0.0,
            child: DotsIndicator(
              dotsCount: _numPages,
              position: _currentPage,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeColor: AppColor.appThemeColor,
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
