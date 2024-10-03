
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '/intro_screens/onboarding_screen.dart';
import 'data/main-data.dart';
import 'data/viewings-data.dart';
import 'data/view-artist-data.dart';
import 'data/gallery-data.dart';
import 'dart:ui';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  await ArtworksDatabaseHelper.instance.importArtworkDataFromJson();
  await ViewDatabaseHelper.instance.importViewingsDataFromJson();
  await ViewArtistDatabaseHelper.instance.importArtistDataFromJson();
  await GalleryDatabaseHelper.instance.importGalleryDataFromJson();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Builder(
        builder: (context) {
          // Initialize SizeConfig here
          //SizeConfig().init(context);
          return OnboardingScreen();
        },
      ),
    );
  }
}