import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '/ui/home_pages/museum_page.dart';
import '/ui/pages/settings_page.dart';
import '/utils/constants.dart';
import '/data/gallery-data.dart';
import '/data/view-artist-data.dart';
import '/data/viewings-data.dart';
import '/data/main-data.dart';
import '/ui/widgets/item_featured.dart';
import '/ui/widgets/item_list.dart';
import 'package:google_fonts/google_fonts.dart'
;import 'dart:ui';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              stretch: true,
              expandedHeight: size.height * 0.3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(8.0),
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Add your non-rounded app icon here with margin
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),  // Adjust the radius as needed
                      child: Image.asset(
                        'assets/icon/icon_app.png',  // Update with your actual icon path
                        height: 40,  // Set the height as needed
                        width: 40,   // Set the width as needed
                      ),
                    ),
                    SizedBox(width: 8),  // Adjust the space between the icon and text
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
                centerTitle: false,  // Set this to false to align the text to the start
                background: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return MuseumPage();
                    }));
                  },
                  child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/Off-NMP.png',
                      fit: BoxFit.cover,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.white.withAlpha(0),
                            Colors.white12,
                            Colors.white38,
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Featured Artwork'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: ViewDatabaseHelper.instance.getViewPaintingsById('9'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return FeaturedTile(
                          viewpaintings: snapshot.data as ViewPaintings, // Changed snapshot data type to Artworks
                          tileHeight: size.height * 0.35,
                          tileWidth: size.width,
                        );
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Artworks'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future:ViewDatabaseHelper.instance.getAllViewPaintings(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ViewPaintings> artworks = snapshot.data as List<ViewPaintings>;
                        return ListHorizontal(
                          itemList: artworks,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Artists'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: ViewArtistDatabaseHelper.instance.getAllViewArtist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ViewArtist> artists = snapshot.data as List<ViewArtist>;
                        return ListHorizontal(
                          itemList: artists,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Gallery'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: GalleryDatabaseHelper.instance.getAllGallery(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Gallery> gallery = snapshot.data as List<Gallery>;
                        return ListHorizontal(
                          itemList: gallery,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: headline('Hallway Artworks'), // Modified the headline method call
                  ),
                  FutureBuilder(
                    future: ArtworksDatabaseHelper.instance.getAllArtworks(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Artworks> artists = snapshot.data as List<Artworks>;
                        return ListHorizontal(
                          itemList: artists,
                        );// Replaced ItemList with the appropriate widget and passed artworks as an argument
                      }
                      return Container();
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget headline(String text) => Text(
  text.toUpperCase(),
  style: GoogleFonts.openSansCondensed(fontSize: 25),
);

