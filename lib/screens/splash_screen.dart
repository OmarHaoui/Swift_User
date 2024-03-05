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

import 'package:swift_user1/screens/authentication/registration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigateToRegistrationScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6B4CE5), // Using the color #6B4CE5
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your splash screen image or design
            Image.asset("assets/images/splash.png"),
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
