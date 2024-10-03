import 'package:flutter/material.dart';
import '/data/view-artist-data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class ArtistsDetailsPage extends StatelessWidget {
  final ViewArtist viewartist;

  const ArtistsDetailsPage({Key? key, required this.viewartist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Artist Details'),
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
              tag: viewartist.viewartistName!,
              child: Container(
                height: size.height * 0.4,
                width: size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(getViewArtistFilename(viewartist)),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                viewartist.viewartistName!,
                style: GoogleFonts.openSansCondensed(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Text(
                lifespan(viewartist),
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Biography',
                style: GoogleFonts.openSansCondensed(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
              child: Text(
                viewartist.viewartistDetails ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
