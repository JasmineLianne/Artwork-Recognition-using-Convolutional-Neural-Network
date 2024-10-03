import 'package:flutter/material.dart';
import '/data/main-data.dart';
import 'package:google_fonts/google_fonts.dart';



class ArtworksLocPage extends StatelessWidget {
  const ArtworksLocPage({
    Key? key,
    required this.artworks,
    this.customHeroTag,
  }) : super(key: key);

  final Artworks artworks;
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
                tag:artworks.artLoc!,
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(getLocationFilename(artworks)),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  artworks.artLoc!,
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
                  artworks.locDetails ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ]
        ),
      ),
    );

  }
}
