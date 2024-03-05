import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Color(0xFF6B4CE5),foregroundColor:Colors.white, // Use the specified color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF6B4CE5), // Use the specified color
              ),
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/swift.png"),
                radius: 80.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'App Name',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4CE5), // Use the specified color
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'A brief description about the app goes here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Connect with us on social media:',
              style: TextStyle(color: Color(0xFF6B4CE5)), // Use the specified color
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  color: Color(0xFF6B4CE5), // Use the specified color
                  onPressed: () {
                    // Open Facebook page
                    // Implement your social media link logic here
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mail),
                  color: Color(0xFF6B4CE5), // Use the specified color
                  onPressed: () {
                    // Open Twitter profile
                    // Implement your social media link logic here
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  color: Color(0xFF6B4CE5), // Use the specified color
                  onPressed: () {
                    // Open LinkedIn profile
                    // Implement your social media link logic here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
