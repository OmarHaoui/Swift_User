// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:swift/screens/home.dart';

// class OtpScreen extends StatelessWidget {
//   final FirebaseAuth auth;
//   final String verificationId;

//   OtpScreen({super.key, required this.auth, required this.verificationId});

//   final TextEditingController otpController = TextEditingController();

//   Future<void> _verifyOtp(BuildContext context) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otpController.text,
//       );

//       await auth.signInWithCredential(credential);

//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen(role: "user")),
//       );
//     } catch (e) {
//       print("OTP verification failed: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OTP Verification'),
//       ),
//       body: Center(
//         child: Card(
//           margin: const EdgeInsets.all(20.0),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextField(
//                   controller: otpController,
//                   decoration: const InputDecoration(labelText: 'OTP Code'),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Perform OTP verification
//                     if (otpController.text.isNotEmpty) {
//                       _verifyOtp(context);
//                     }
//                   },
//                   child: const Text('Verify OTP'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/screens/authentication/ask_name.dart';
import 'package:swift_user1/screens/home.dart';

class OtpScreen extends StatelessWidget {
  final FirebaseAuth auth;
  final String verificationId;

  OtpScreen({super.key, required this.auth, required this.verificationId});

  final TextEditingController otpController = TextEditingController();

  Future<void> _verifyOtp(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );

      await auth.signInWithCredential(credential);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AskName()),
      );
    } catch (e) {
      print("OTP verification failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: AppColor.appThemeColor,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: otpController,
                  decoration: const InputDecoration(
                    labelText: 'OTP Code',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Perform OTP verification
                    if (otpController.text.isNotEmpty) {
                      _verifyOtp(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.primaryColor,
                    backgroundColor: AppColor.appThemeColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
