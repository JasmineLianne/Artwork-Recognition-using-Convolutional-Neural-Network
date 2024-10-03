import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'
;import 'dart:ui';

class MuseumPage extends StatefulWidget {
  const MuseumPage({Key? key}) : super(key: key);

  @override
  State<MuseumPage> createState() => _MuseumPageState();
}

class _MuseumPageState extends State<MuseumPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('National Museum of Fine Arts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Off-NMP.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'National Museum of Fine Arts',
                  style: GoogleFonts.openSansCondensed(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 150.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 8.0, 8.0),
              child: Text(
                'The National Museum of Fine Arts is home to 29 galleries and hallway exhibitions comprising of 19th century'
                    ' Filipino masters, National Artists, leading modern painters, sculptors, and printmakers. Also on view '
                    'are art loans from other government institutions, organizations, and individuals.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
