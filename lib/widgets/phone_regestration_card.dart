import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_user1/screens/home.dart';
import 'package:swift_user1/screens/authentication/otpscreen.dart';

class PhoneRegistrationCard extends StatefulWidget {
  final FirebaseAuth auth;

  PhoneRegistrationCard({Key? key, required this.auth});

  @override
  _PhoneRegistrationCardState createState() => _PhoneRegistrationCardState();
}

class _PhoneRegistrationCardState extends State<PhoneRegistrationCard> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _sendOtp(BuildContext context) async {
    try {
      await widget.auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await widget.auth.signInWithCredential(credential);
          _savePhoneNumber(phoneNumberController.text);
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
                auth: widget.auth,
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
    User? user = widget.auth.currentUser;

    if (user != null) {
      try {
        await user.reload();
        user = widget.auth.currentUser;

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
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        elevation: 3, // Elevation for a slight lift
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (phoneNumberController.text.isNotEmpty) {
                    _sendOtp(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF6B4CE5),
                ),
                child: const Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
