import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:url_launcher/url_launcher.dart';

class GetImagePage extends StatefulWidget {
  const GetImagePage({Key? key}) : super(key: key);

  @override
  State<GetImagePage> createState() => _GetImagePageState();
}

class _GetImagePageState extends State<GetImagePage> {
  late String output = '';

  late File pickedImage;

  bool isImageLoaded = false;

  late List result;

  late String accuracy = '';

  late String name = '';

  late String numbers = '';

  getImageCamera(String imgsrc) async {
    setState(() {
      hasLoaded = false;
    });
    var tempStore = await ImagePicker().pickImage(
      source: imgsrc == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    setState(() {
      pickedImage = File(tempStore!.path);
      isImageLoaded = true;
      applyModel(File(tempStore.path), context);
      hasLoaded = true;
    });
  }

  List works = [];

  loadmodel() async {
    try {
      await Tflite.loadModel(
        model: "assets/CNN/model.tflite",
        labels: "assets/CNN/labels.txt",
      );
    } catch (e) {
      print('error $e');
    }

    works = jsonDecode(await rootBundle.loadString('assets/data/main-db.json'));

    setState(() {
      hasLoaded = true;
    });
  }

  String str = '';

  applyModel(File file, BuildContext context) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (res != null && res.isNotEmpty) {
      setState(() {
        print('res $res');
        result = res!;
        print('result:$result');
        str = '${result[0]['label']}';
      });

      print(str);

      for (int i = 0; i < works.length; i++) {
        if (works[i]['labelName'] == str) {
          showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              final Size size = MediaQuery.of(context).size;
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            getImageCamera('gallery');
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: size.height * 0.4,
                          width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(works[i]['artworkImage']),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          works[i]['artTitle'],
                          style: GoogleFonts.openSansCondensed(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 8.0, 8.0),
                        child: Text(
                          works[i]['addInfo'],
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
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
                          works[i]['artDetails'] ?? '',
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
                              backgroundImage:
                              AssetImage(works[i]['artistImage']),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    works[i]['artistName'] ?? '',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    works[i]['period'] ?? '',
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
                          works[i]['artistDetails'] ?? '',
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * 0.6,
                          width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(works[i]['artLocImage']),
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
                  Container(
                    margin: EdgeInsets.only(bottom: 32.0), // Adjust the bottom margin as needed
                    child:
                      ElevatedButton(
                        onPressed: () {
                          // Handle the button press, you can also navigate to a new page here
                          if (works[i]['addlink'] != null) {
                            launch(works[i]['addlink'] !);
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
                                    image: AssetImage(works[i]['artworkImage']), // Assuming viewImage is the URL
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

                                        if (works[i]['addLink']!= null)
                                          TextSpan(
                                            text: works[i]['addLink'] ?? '',
                                            style: TextStyle(color: Colors.white),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launch(works[i]['addLink'] !);
                                              },
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]
                        ),
                      ),
                  )

                    ],
                  ),
                ),
              );
            },
          );
        }
      }
    } else {
      // No artwork detected, show an error message.
      displayNoArtworkMessage(context);
    }
  }

  void displayNoArtworkMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Artwork Detected"),
          content: Text("Sorry, we couldn't detect any artwork."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                getImageCamera('gallery');
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  bool hasLoaded = false;
  @override
  void initState() {
    super.initState();
    loadmodel();
    getImageCamera('gallery');
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}