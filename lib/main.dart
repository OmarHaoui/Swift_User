import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:swift_user1/constant/apiendpoints.dart';
import 'package:swift_user1/constant/app_screen_size.dart';
import 'package:swift_user1/firebase_options.dart';
import 'package:swift_user1/screens/authentication/splash_page.dart';
import 'package:swift_user1/screens/home.dart';
import 'package:swift_user1/screens/authentication/registration.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:swift_user1/screens/location/tracking_screen.dart';
import 'package:swift_user1/screens/tracking_2.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swift',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/ ',
      routes: {
        '/': (context) => const SplashScreen(),
        TrackingScreen.id: (context) => const TrackingScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) =>
            HomeScreen(userName: 'getfrmProvider', role: 'User'),
      },
    );
  }
}
