import 'package:shyal/Screens/LoginScreen.dart';
import 'package:shyal/const.dart';
import 'package:flutter/material.dart';
import 'package:shyal/Component/CustomButton.dart';

class DriverSettingsScreen extends StatefulWidget {
  @override
  _DriverSettingsScreenState createState() => _DriverSettingsScreenState();
}

class _DriverSettingsScreenState extends State<DriverSettingsScreen> {
  bool isDarkMode = false;
  bool isAviliable = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      appBar: AppBar(
        backgroundColor: background_color,
        title: const Text('Setting', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Color(0xFFFFFFFF)),
              title:
                  Text(' Profile', style: TextStyle(color: Color(0xFFFFFFFF))),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            SwitchListTile(
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              title:
                  Text('Dark Mode', style: TextStyle(color: Color(0xFFFFFFFF))),
              secondary: Icon(Icons.brightness_2, color: Color(0xFFFFFFFF)),
            ),
            SwitchListTile(
              value: isAviliable,
              onChanged: (bool value) {
                setState(() {
                  isAviliable = value;
                });
              },
              title:
                  Text('Aviliable', style: TextStyle(color: Color(0xFFFFFFFF))),
              secondary: Icon(Icons.brightness_2, color: Color(0xFFFFFFFF)),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.language, color: Color(0xFFFFFFFF)),
              title:
                  Text('Language', style: TextStyle(color: Color(0xFFFFFFFF))),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
                items: <String>['English', 'العربية']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child:
                        Text(value, style: TextStyle(color: Color(0xFFFFFFFF))),
                  );
                }).toList(),
                dropdownColor: Color(0xFF424242),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Color(0xFFFFFFFF)),
              title: Text('Privacy Policy',
                  style: TextStyle(color: Color(0xFFFFFFFF))),
              onTap: () {
                // Implement navigation or functionality for privacy policy
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.description, color: Color(0xFFFFFFFF)),
              title: Text('Terms & Conditions',
                  style: TextStyle(color: Color(0xFFFFFFFF))),
              onTap: () {
                // Implement navigation or functionality for terms and conditions
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Color(0xFFFFFFFF)),
              title: Text('Contact Us',
                  style: TextStyle(color: Color(0xFFFFFFFF))),
              onTap: () {
                // Implement navigation or functionality for contact us
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Color(0xFFFFFFFF)),
              title: const Text('Share App',
                  style: TextStyle(color: Color(0xFFFFFFFF))),
              onTap: () {
                // Implement navigation or functionality for sharing the app
              },
            ),
            const SizedBox(
              height: 150,
            ),
            CustomButton(
                title: 'Logout',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
