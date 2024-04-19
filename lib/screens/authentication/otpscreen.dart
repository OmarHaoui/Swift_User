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

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:swift_user1/constant/app_color.dart';
// import 'package:swift_user1/constant/app_text_style.dart';
// import 'package:swift_user1/screens/authentication/ask_name.dart';
// import 'package:swift_user1/screens/home.dart';

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
//         MaterialPageRoute(builder: (context) => AskName()),
//       );
//     } catch (e) {
//       print("OTP verification failed: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(left: 16.0, right: 16, top: 30, bottom: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               "التحقق من رقم هاتفك",
//               style: AppTextStyle.phoneVerifyText,
//             ),
//             Text(
//               "ادخل الرمز المرسل",
//               style: AppTextStyle.enterOtp,
//             ),
//             Center(
//               child: Card(
//                 margin: const EdgeInsets.all(20.0),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 elevation: 5.0,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       TextField(
//                         controller: otpController,
//                         decoration: const InputDecoration(
//                           labelText: 'OTP Code',
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.all(12),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Perform OTP verification
//                           if (otpController.text.isNotEmpty) {
//                             _verifyOtp(context);
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: AppColor.primaryColor,
//                           backgroundColor: AppColor.appThemeColor,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 12.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         child: const Text(
//                           'Verify OTP',
//                           style: TextStyle(fontSize: 18.0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_text_style.dart';
import 'package:swift_user1/screens/authentication/ask_name.dart';
import 'package:swift_user1/screens/location/tracking_screen.dart';
import 'package:swift_user1/utils/utils.dart';

/// A screen for OTP verification.
class OtpScreen extends StatelessWidget {
  final FirebaseAuth auth;
  final String verificationId;

  /// Constructs an instance of [OtpScreen].
  ///
  /// The [auth] parameter is used for Firebase authentication.
  /// The [verificationId] parameter is the verification ID received from Firebase.
  OtpScreen({Key? key, required this.auth, required this.verificationId})
      : super(key: key);

  String pin = "";

  Future<void> _verifyOtp(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: pin,
      );

      await auth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TrackingScreen()),
      );
    } catch (e) {
      showSnackBar("OTP verification failed: $e", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "التحقق من رقم هاتفك",
                style: AppTextStyle.phoneVerifyText,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "ادخل الرمز المرسل",
                style: AppTextStyle.enterOtp,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (pin) => this.pin = pin,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appThemeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    _verifyOtp(context);
                  },
                  child: const Text(
                    "Verify Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
