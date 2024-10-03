import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../utils/constants.dart';


class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Artwork Recognition',
              style: GoogleFonts.prompt(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            _buildListTile("Capture or Upload an Image",
                "Use the camera feature within the app to capture an image of the artwork or select an existing image from your device's gallery."),
            _buildListTile("Wait for Recognition",
                "After capturing or uploading the image, wait for the app to process and recognize the artwork. Be patient, as recognition may take a few moments."),
            _buildListTile("Review Recognition Results",
                "Once the artwork is recognized, review the information provided by the app. Look for details such as artist name, title, and additional information."),
            Text(
              'Augmented Reality',
              style: GoogleFonts.prompt(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            _buildListTile("Select a Hallway",
                "Once in AR mode, you will likely see a camera view with an overlay. Aim your device's camera towards the hallway or area where you want to apply artwork recognition."),
            _buildListTile("Scan the Environment",
                "Move your device around to scan the environment. The AR feature will detect surfaces and prepare to overlay artwork information."),
            _buildListTile("Wait for Calibration",
                "Allow the app a moment to calibrate and recognize the physical space."),
            _buildListTile("Interact with Artworks",
                "You can now start trying the artwork recognition feature if the hallway applies the feature"),
          ],
        ),
      ),
      )
    );
  }

  Widget _buildListTile(String title, String description) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}