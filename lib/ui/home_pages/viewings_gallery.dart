import 'package:flutter/material.dart';
import '/data/gallery-data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';


class GalleryDetailsPage extends StatelessWidget {
  const GalleryDetailsPage({
    Key? key,
    required this.gallery,
    this.customHeroTag,
  }) : super(key: key);

  final Gallery gallery;
  final String? customHeroTag;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Gallery Details'),
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
                tag:gallery.galleryName!,
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(getGalleryFilename(gallery)),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  gallery.galleryName!,
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
                  gallery.detailsEng ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ]
        ),
      ),
    );

  }
}
