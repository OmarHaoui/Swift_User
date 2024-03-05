import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String name = 'User name'; // Initial values, replace with actual user data
  String phone = 'phone number';
  String city = 'City Name';
  String selectedLanguage = 'English'; // Initial language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Color(0xFF6B4CE5),foregroundColor:Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: city,
                decoration: InputDecoration(
                  labelText: 'City',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedLanguage,
                decoration: InputDecoration(
                  labelText: 'Language',
                  fillColor: Colors.white,
                  filled: true,
                ),
                items: ['English', 'French', 'Arabic'].map((String lang) {
                  return DropdownMenuItem<String>(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Save the changes, you can add logic to persist data
                  // and update the app's state accordingly
                  // For simplicity, we are just printing the values here
                  print('Name: $name');
                  print('Phone: $phone');
                  print('City: $city');
                  print('Language: $selectedLanguage');
                  // Navigate back to the previous screen
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6B4CE5),foregroundColor:Colors.white,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
