import 'package:flutter/material.dart';
import '/data/viewings-data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class ViewingsLocPage extends StatelessWidget {
  const ViewingsLocPage({
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
        title: Text('Artwork Location'),
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
                tag:viewpaintings.artLoc!,
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
                  viewpaintings.artLoc!,
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
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
                  viewpaintings.locDetails ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ]
        ),
      ),
    );

  }
}
