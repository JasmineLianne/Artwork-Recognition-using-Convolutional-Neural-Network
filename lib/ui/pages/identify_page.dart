
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/ui/pages/settings_page.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../identify_pages/get_camera.dart';
import '../identify_pages/get_image.dart';
import 'main_page.dart';
import 'dart:ui';

class IdentifyPage extends StatelessWidget {
  const IdentifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Identify Page",
            textAlign: TextAlign.end,
            style: GoogleFonts.openSansCondensed(
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsPage();
                }));
              },
              iconSize: 28,
            ),
          ],
        ),
        body: Stack(
          children: [

            Center(
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 44),
                  RichText(

                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'CNN',
                          style: GoogleFonts.prompt(
                            fontSize: 58,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            // Set the color for 'Fil'
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(width: 10), // Adjust the width based on your desired space
                        ),
                        TextSpan(
                          text: 'Enabled',
                          style: GoogleFonts.prompt(
                            fontSize: 58,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set the color for 'Arts'
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                    child: Text(
                      'Feature',
                      style: GoogleFonts.prompt(fontSize: 58, height: 0.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 36.0, 8.0, 8.0),
                    child: Text(
                      'Discover the story behind every masterpiece. Our artwork recognition feature allows you to explore detailed information'
                          ' about artworks instantly, making your art journey more enriching and captivating.',
                      style: GoogleFonts.prompt(
                        fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                    child: Text(
                      'Engage with masterpieces by either capturing them in real-time with your device camera or selecting an image from your gallery.',
                      style: GoogleFonts.prompt(
                        fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 8.0, 16.0),
                    child: Text(
                      'Note: This Feature is only applicable for the Paintings exhibited at the Museum\'s Hallway.',
                      style: GoogleFonts.prompt(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              // Replace 'MainPage()' with your actual widget
                              return GetCameraPage();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0), // Set your desired border radius here
                            ),// Replace with your color
                          ),
                          icon: Icon(Icons.camera),
                          label: Text('Use Camera'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              // Replace 'MainPage()' with your actual widget
                              return GetImagePage();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0), // Set your desired border radius here
                            ),// Replace with your color
                          ),
                          icon: Icon(Icons.browse_gallery),
                          label: Text('Browse Gallery'),
                        ),
                      ],
                    ),
                  ),

                ]
              ),
            ),
          ],
        ),
      );
    }
  }
