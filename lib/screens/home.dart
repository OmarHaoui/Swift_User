import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swift_user1/constant/app_asset_image.dart';
import 'package:swift_user1/constant/app_color.dart';
import 'package:swift_user1/screens/about.dart';
import 'package:swift_user1/screens/contact.dart';
import 'package:swift_user1/screens/historique.dart';
import 'package:swift_user1/screens/authentication/registration.dart';
import 'package:swift_user1/screens/location/course.dart';
import 'package:swift_user1/screens/settings.dart';

class HomeScreen extends StatelessWidget {
  static String id = '/home';
  final String userName;
  final String role;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HomeScreen({super.key, required this.role, required this.userName});

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegistrationScreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              color: AppColor.appThemeColor,
              child: Center(
                child: ListTile(
                  title: Text(
                    //TODO: Get the name from the user
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  subtitle: Text(
                    //TODO: Get the email from the user
                    'your.email@example.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(AppAssetImage.profilePicture),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historique'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoriqueScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                await _signOut(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to your app!"),
            const SizedBox(height: 20.0),
            Text("Role: $role"),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CourseScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B4CE5),
                foregroundColor: Colors.white,
              ),
              child: const Text('Course'),
            ),
          ],
        ),
      ),
    );
  }
}
