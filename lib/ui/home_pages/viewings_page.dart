import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/ui/home_pages/viewings_loc_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '/data/viewings-data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';


class ViewingsDetailsPage extends StatelessWidget {
  const ViewingsDetailsPage({
    Key? key,
    required this.viewpaintings,
    this.customHeroTag,
  }) : super(key: key);

  final ViewPaintings viewpaintings;
  final String? customHeroTag;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Artwork Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        // Rest of your code remains unchanged
        padding: const EdgeInsets.only(bottom: 30.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag:viewpaintings.viewTitle!,
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(getViewPaintingsFilename(viewpaintings)),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  viewpaintings.viewTitle!,
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                child: Text(
                  gist(viewpaintings) ?? 'No additional information available',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Description',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                child: Text(
                  viewpaintings.viewDetails ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'About the Artist',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(viewpaintings.viewartistImage),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewpaintings.viewartistName ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            viewpaintings.viewPeriod ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                child: Text(
                  artistdeets(viewpaintings),
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Artwork Location',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to a new page when the photo is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewingsLocPage(viewpaintings: viewpaintings)), // Replace NewPage with the actual page you want to navigate to
                  );
                },
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(getLocationFilename(viewpaintings)),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'More About this Artwork',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        ElevatedButton(
          onPressed: () {
            // Handle the button press, you can also navigate to a new page here
            if (viewpaintings.viewAddlink != null) {
              launch(viewpaintings.viewAddlink!);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Set your desired border radius here
            ),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Square Avatar
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  width: 100.0, // Set your desired width
                  height: 80.0, // Set your desired height
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle, // Set your desired border radius
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(viewpaintings.viewImage ?? ''), // Assuming viewImage is the URL
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            'Follow this link:',
            style: const TextStyle(fontSize: 16,
            color: Colors.white),
          ),
        ),

              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16,
                  color: Colors.white),
                  children: [

                    if (viewpaintings.viewAddlink != null)
                      TextSpan(
                        text: viewpaintings.viewAddlink ?? '',
                        style: TextStyle(color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(viewpaintings.viewAddlink!);
                          },
                      ),
                  ],
                ),
              ),
              ],
          ),
        ]
      ),
        )
            ]
        ),
      ),
    );

  }
}
