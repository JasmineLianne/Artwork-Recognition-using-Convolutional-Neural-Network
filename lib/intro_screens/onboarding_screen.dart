import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/pages/main_page.dart';
import '../utils/constants.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 44),
                RichText(

                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'fil',
                        style: GoogleFonts.prompt(
                          fontSize: 98,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          // Set the color for 'Fil'
                        ),
                      ),
                      TextSpan(
                        text: 'Arts',
                        style: GoogleFonts.prompt(
                          fontSize: 98,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor, // Set the color for 'Arts'
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 42), // Add some space between texts

                // Additional Text
                Text(
                  'Where Technology \n'
                      'meets Art, and where\n'
                      'every visit becomes\n'
                      'an unforgettable\n'
                      'experience.',
                  style: GoogleFonts.prompt(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 100), // Add some space between texts

                // "Let's get started" Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return MainPage();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00897B),
                    fixedSize: Size(300, 70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          25.0), // Set your desired border radius here
                    ),
                  ),
                  child: Text("Let's get started",
                    style: GoogleFonts.prompt(
                      fontSize: 25,
                      color: Colors.white,
                    ),),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
