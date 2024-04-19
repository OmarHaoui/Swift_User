// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:swift/screens/home.dart';
// import 'package:swift/screens/otpscreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegistrationScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   RegistrationScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Phone Registration'),
//         ),
//         body: PhoneRegistrationCard(auth: _auth),
//       ),
//     );
//   }
// }

// class PhoneRegistrationCard extends StatefulWidget {
//   final FirebaseAuth auth;

//   PhoneRegistrationCard({Key? key, required this.auth});

//   @override
//   _PhoneRegistrationCardState createState() => _PhoneRegistrationCardState();
// }

// class _PhoneRegistrationCardState extends State<PhoneRegistrationCard> {
//   final TextEditingController phoneNumberController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _checkUserLoggedIn();
//   }

//   Future<void> _sendOtp(BuildContext context) async {
//     try {
//       await widget.auth.verifyPhoneNumber(
//         phoneNumber: phoneNumberController.text,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await widget.auth.signInWithCredential(credential);
//           _savePhoneNumber(phoneNumberController.text);
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen(role: "user")),
//           );
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print("Phone verification failed: ${e.message}");
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => OtpScreen(
//                 verificationId: verificationId,
//                 auth: widget.auth,
//               ),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } catch (e) {
//       print("Phone verification failed: $e");
//     }
//   }

//   void _savePhoneNumber(String phoneNumber) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('phoneNumber', phoneNumber);
//   }

// Future<void> _checkUserLoggedIn() async {
//   User? user = widget.auth.currentUser;

//   if (user != null) {
//     try {
//       await user.reload(); // Reloads the user to get the latest information from Firebase
//       user = widget.auth.currentUser; // Refresh the user variable

//       if (user?.phoneNumber != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen(role: "user")),
//         );
//       }
//     } catch (e) {
//       print("Error checking user authentication: $e");
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: const EdgeInsets.all(20.0),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               TextField(
//                 controller: phoneNumberController,
//                 decoration: const InputDecoration(labelText: 'Phone Number'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Perform phone number authentication
//                   if (phoneNumberController.text.isNotEmpty) {
//                     _sendOtp(context);
//                   }
//                 },
//                 child: const Text('Send OTP'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_user1/constant/app_asset_image.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/constant/app_screen_size.dart';
import 'package:swift_user1/screens/authentication/otpscreen.dart';
import 'package:swift_user1/screens/home.dart';
import 'package:swift_user1/widgets/social_media_button.dart';
import 'package:swift_user1/widgets/selectable_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  RegistrationScreen({Key? key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _refController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading = false;

  Future<void> _sendOtp(BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+213${_phoneNumberController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _savePhoneNumber(_phoneNumberController.text);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(userName: 'getfrmProvider', role: "user")),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Phone verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                auth: _auth,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Phone verification failed: $e");
    }
  }

  void _savePhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);
  }

  Future<void> _checkUserLoggedIn() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user
            .reload(); // Reloads the user to get the latest information from Firebase
        user = _auth.currentUser; // Refresh the user variable

        if (user?.phoneNumber != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(userName: 'getfrmProvider', role: "user")),
          );
        }
      } catch (e) {
        print("Error checking user authentication: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //body: PhoneRegistrationCard(auth: _auth),
        // body: Stack(
        //   alignment: Alignment.topCenter,
        //   children: [
        //     //purple container
        //     Container(
        //       alignment: Alignment.bottomCenter,
        //       color: AppColor.appThemeColor,
        //       height: AppSceenSize.getHeight(context) / 2.8,
        //       child: Image.asset(
        //         "assets/images/transbuild.png",
        //         fit: BoxFit.fitWidth,
        //       ),
        //     ),
        //     //The white card that contains the phone number text field
        //     Padding(
        //       padding: const EdgeInsets.all(16.0),
        //       child: Center(
        //         child: Container(
        //           width: double.infinity,
        //           height: AppSceenSize.getHeight(context) / 2,
        //           padding: const EdgeInsets.all(8.0),
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(20),
        //             boxShadow: const [
        //               BoxShadow(blurRadius: 10.0, color: Colors.grey)
        //             ],
        //           ),
        //           child: SingleChildScrollView(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 //switch buttons with a line under the selected button
        //                 ButtonSelectionDemo(),
        //                 const SizedBox(height: 30),
        //                 // phone otp sign in method
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     // The phone number text field
        //                     IntlPhoneField(
        //                       //controller: _provider!.mobileNumberController,
        //                       controller: _phoneNumberController,
        //                       decoration: InputDecoration(
        //                         enabledBorder: OutlineInputBorder(
        //                           borderSide: BorderSide(
        //                             color: Colors.grey.shade200,
        //                           ), // Customize the border color here
        //                           borderRadius: BorderRadius.circular(8.0),
        //                         ),
        //                         border: OutlineInputBorder(
        //                           borderSide:
        //                               BorderSide(color: Colors.grey.shade200),
        //                           borderRadius: BorderRadius.circular(8.0),
        //                         ),
        //                       ),
        //                       initialCountryCode: 'DZ',
        //                     ),
        //                     const SizedBox(
        //                       height: 20,
        //                     ),
        //                     // The referral code text field
        //                     TextFormField(
        //                       controller: _refController,
        //                       decoration: InputDecoration(
        //                         hintText: "Referral Code",
        //                         enabledBorder: OutlineInputBorder(
        //                           borderSide: BorderSide(
        //                             color: Colors.grey.shade200,
        //                           ), // Customize the border color here
        //                           borderRadius: BorderRadius.circular(8.0),
        //                         ),
        //                         border: OutlineInputBorder(
        //                           borderSide:
        //                               BorderSide(color: Colors.grey.shade200),
        //                           borderRadius: BorderRadius.circular(8.0),
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       height: 20,
        //                     ),
        //                     isLoading
        //                         ? AppSceenSize.loadingIcon
        //                         : Container(
        //                             height: 50,
        //                             width: double.infinity,
        //                             child: ElevatedButton(
        //                               style: ButtonStyle(
        //                                 shape: MaterialStateProperty.all<
        //                                     RoundedRectangleBorder>(
        //                                   RoundedRectangleBorder(
        //                                       borderRadius:
        //                                           BorderRadius.circular(8.0)),
        //                                 ),
        //                                 backgroundColor:
        //                                     MaterialStateProperty.all<Color>(
        //                                   AppColor.btnColorYellow,
        //                                 ),
        //                               ),
        //                               onPressed: () async {
        //                                 setState(() {
        //                                   isLoading = true;
        //                                 });

        //                                 //await _provider!.registerCustomer(context, _refController.text);
        //                                 await _sendOtp(context);
        //                                 setState(() {
        //                                   isLoading = false;
        //                                 });
        //                               },
        //                               child: const Text(
        //                                 'Next',
        //                                 style: TextStyle(
        //                                     color: AppColor.appThemeColor),
        //                               ),
        //                             ),
        //                           ),
        //                     const SizedBox(
        //                       height: 20,
        //                     ),
        //                   ],
        //                 ),
        //                 //0561684876
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     // The facebook connect button
        //     Positioned(
        //       top: AppSceenSize.getHeight(context) - 100,
        //       child: Container(
        //         margin: const EdgeInsets.symmetric(horizontal: 16.0),
        //         width: AppSceenSize.getWidth(context) - 48,
        //         child: FacebookConnectButton(
        //           //TODO: Implement the facebook login
        //           onPressed: () {},
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/images/userimage.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(5),
                  shadowColor: MaterialStateProperty.all<Color>(
                    Colors.black,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColor.appThemeColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                onPressed: () {
                  // Perform phone number authentication
                  if (_phoneNumberController.text.isNotEmpty) {
                    _sendOtp(context);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: const Text('SWIFT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 20, bottom: 10, right: 16),
                child: const Text(
                  'رحلتك تبدأ هنا',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              // The phone number text field
              Container(
                padding: const EdgeInsets.all(16.0),
                child: IntlPhoneField(
                  //enabled: false,
                  //TODO: FIX AND MAKE IT WITH PROVIDER
                  //controller: _provider!.mobileNumberController,
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "رقم الهاتف",
                    hintTextDirection: TextDirection.rtl,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 192, 189, 189),
                      ), // Customize the border color here
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 2),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  initialCountryCode: 'DZ',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton(
                      buttonColor: AppColor.fbColor,
                      buttonText: 'Facebook',
                      buttonImage: AppAssetImage.fbLogo,
                      textColor: AppColor.primaryColor,
                      onPressed: () {
                        // Perform facebook authentication
                        //TODO: Implement the facebook authentication
                      }),
                  const SizedBox(width: 10),
                  Container(
                    //margin: const EdgeInsets.only(left: 10),
                    child: SocialMediaButton(
                        buttonColor: AppColor.primaryColor,
                        buttonText: 'Google',
                        buttonImage: AppAssetImage.googleLogo,
                        textColor: Colors.black,
                        onPressed: () {
                          // Perform facebook authentication
                          //TODO: Implement the facebook authentication
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
