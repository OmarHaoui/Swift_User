// import 'package:flutter/material.dart';
// import 'package:swift/screens/registration.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   void _navigateToRegistrationScreen() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => RegistrationScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Your splash screen image or design
//             Image.asset("assets/images/splash.png"),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: _navigateToRegistrationScreen,
//               child: const Text("GET STARTED"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_color.dart';

import 'package:swift_user1/screens/authentication/registration.dart';

class SplashScreenOld extends StatefulWidget {
  const SplashScreenOld({Key? key}) : super(key: key);

  @override
  State<SplashScreenOld> createState() => _SplashScreenOldState();
}

class _SplashScreenOldState extends State<SplashScreenOld> {
  void _navigateToRegistrationScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor, // Using the color #6B4CE5
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your splash screen image or design
            Image.asset("assets/images/swift1.jpg"),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _navigateToRegistrationScreen,
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF6B4CE5),
                backgroundColor: Colors.white, // Text color
                elevation: 3, // Elevation to give a lift to the button
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                "GET STARTED",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
