import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/ui/pages/tutorial_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import '../../utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'About',
                  style: GoogleFonts.prompt(
                    color: kPrimaryColor,  // Change the color as needed
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: const Text('National Museum of the Philippines'),
                subtitle: const Text('Website for the Museum'),
                leading: const Icon(Icons.web),
                onTap: () {
                  const String url = 'https://www.nationalmuseum.gov.ph/';
                  launch(url);
                },
              ),
              ListTile(
                title: const Text('App Information'),
                subtitle: const Text('About us & App version'),
                leading: const Icon(Icons.info_outline_rounded),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(32.0, 200.0, 32.0, 230.0),
                        width: double.infinity,
                        height: 200,
                        child: Card(
                          margin: EdgeInsets.all(32),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),  // Adjust the radius as needed
                                        child: Image.asset(
                                          'assets/icon/icon_app.png',  // Update with your actual icon path
                                          height: 40,  // Set the height as needed
                                          width: 40,   // Set the width as needed
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    RichText(
                                      text: TextSpan(
                                        text: 'fil',
                                        style: GoogleFonts.prompt(
                                          color: Colors.white,  // Change the color as needed
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Arts',
                                            style: GoogleFonts.prompt(
                                              color: kPrimaryColor,  // Change the color as needed
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Text('App for the National Museum of Fine Arts',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Made by the 4th year Students of Pamantasan ng Lungsod ng Maynila',
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'App Version: 1.00',
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 16),
                                ),
                                const Spacer(), // Add this to push the close text to the bottom
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Other',
                  style: GoogleFonts.prompt(
                    color: kPrimaryColor,  // Change the color as needed
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: const Text('App Tutorial'),
                subtitle: const Text('Tutorial for CNN & AR Feature'),
                leading: const Icon(Icons.book),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TutorialPage();
                  }));
                },
              ),
              // Add two more empty ListTile widgets here if needed
            ],
          ),
        ],
      ),
    );
  }
}