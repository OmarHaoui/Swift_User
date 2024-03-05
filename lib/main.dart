import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:swift_user1/firebase_options.dart';
import 'package:swift_user1/screens/course.dart';
import 'package:swift_user1/screens/home.dart' as HomeScreen;
import 'package:swift_user1/screens/authentication/registration.dart'
    as RegistrationScreen;
import 'package:swift_user1/screens/onboarding/onboarding.dart';
import 'package:swift_user1/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swift',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CourseScreen(),
        '/.': (context) => const OnboardingScreen(),
        '/registration': (context) => RegistrationScreen.RegistrationScreen(),
        '/home': (context) =>
            HomeScreen.HomeScreen(userName: 'getfrmProvider', role: 'User'),
      },
    );
  }
}
