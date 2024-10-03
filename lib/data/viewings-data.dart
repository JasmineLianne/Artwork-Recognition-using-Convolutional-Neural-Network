import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ViewPaintings {
  final int? viewId;
  final String viewTitle;
  final String viewDetails;
  final String viewAddInfo;
  final String viewartistName;
  final String viewPeriod;
  final String viewartistDetails;
  final String viewImage;
  final String viewartistImage;
  final String viewAddlink;
  final String linkTitle;
  final String artLoc;
  final String locDetails;
  final String artLocImage;

  ViewPaintings(
      {this.viewId, required this.viewTitle, required this.viewDetails, required this.viewAddInfo, required this.viewartistName, required this.viewPeriod, required this.viewartistDetails, required this.viewImage, required this.viewartistImage, required this.viewAddlink, required this.linkTitle, required this.artLoc, required this.locDetails, required this.artLocImage });

  factory ViewPaintings.fromMap(Map<String, dynamic> json) =>
      ViewPaintings(
          viewId: json['viewId'],
          viewTitle: json['viewTitle'],
          viewDetails: json['viewDetails'],
          viewAddInfo: json['viewAddInfo'],
          viewartistName: json['viewartistName'],
          viewPeriod: json['viewPeriod'],
          viewartistDetails: json['viewartistDetails'],
          viewImage: json['viewImage'],
          viewartistImage: json['viewartistImage'],
          viewAddlink: json['viewAddlink'],
          linkTitle: json['linkTitle'],
          artLoc: json['artLoc'],
          locDetails: json['locDetails'],
          artLocImage: json['artLocImage']
      );

  Map<String, dynamic> toMap() {
    return {
      'viewId': viewId,
      'viewTitle': viewTitle,
      'viewDetails': viewDetails,
      'viewAddInfo': viewAddInfo,
      'viewartistName': viewartistName,
      'viewPeriod': viewPeriod,
      'viewartistDetails': viewartistDetails,
      'viewImage': viewImage,
      'viewartistImage': viewartistImage,
      'viewAddlink': viewAddlink,
      'linkTitle': linkTitle,
      'artLoc': artLoc,
      'locDetails': locDetails,
      'artLocImage': artLocImage
    };
  }
}
class ViewDatabaseHelper {
  ViewDatabaseHelper._privateConstructor();

  static final ViewDatabaseHelper instance = ViewDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ViewPaintings.db');
    return await openDatabase(
      path,
      version: 1,  // Update the version to handle the migration.
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ViewPaintings(
      viewId INTEGER PRIMARY KEY,
      viewTitle TEXT,
      viewDetails TEXT,
      viewAddInfo TEXT,
      viewartistName TEXT,
      viewPeriod TEXT,
      viewartistDetails TEXT,
      viewImage TEXT,
      viewartistImage TEXT,
      viewAddlink TEXT,
      linkTitle TEXT,
      artLoc TEXT,
      locDetails TEXT,
      artLocImage TEXT
    )
  ''');
    print("Viewings table created successfully!");
  }


  Future<void> importViewingsDataFromJson() async {
    String jsonString = await rootBundle.loadString('assets/data/viewings-db.json');
    List<dynamic> data = json.decode(jsonString);

    ViewDatabaseHelper databaseHelper = ViewDatabaseHelper.instance; // Access the instance from DatabaseHelper
    Database db = await databaseHelper.database;
    for (var item in data) {
      await db.insert(
        'ViewPaintings',
        ViewPaintings(
            viewId: item['viewId'],
            viewTitle: item['viewTitle'],
            viewDetails: item['viewDetails'],
            viewAddInfo: item['viewAddInfo']?? ' ',
            viewartistName: item['viewartistName'],
            viewPeriod: item['viewPeriod'],
            viewartistDetails: item['viewartistDetails'],
            viewImage: item['viewImage'],
            viewartistImage: item['viewartistImage'],
            viewAddlink: item['viewAddlink'],
            linkTitle: item['linkTitle'],
            artLoc: item['artLoc'],
            locDetails: item['locDetails'],
            artLocImage: item['artLocImage']

        ).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
  Future<List<ViewPaintings>> getAllViewPaintings() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('ViewPaintings');
    return result.map((viewpaintingsMap) => ViewPaintings.fromMap(viewpaintingsMap)).toList();
  }

  Future<ViewPaintings> getViewPaintingsById(String viewId) async {
    Database db = await database; // Assuming you have a reference to the database
    List<Map<String, dynamic>> results = await db.query('ViewPaintings', where: 'viewId = ?', whereArgs: [viewId]);
    if (results.isNotEmpty) {
      return ViewPaintings.fromMap(results.first);
    } else {
      throw Exception('Artwork not found');
    }
  }


}



String gist(ViewPaintings viewpaintings) => viewpaintings.viewAddInfo;

String description(ViewPaintings viewpaintings) => viewpaintings.viewDetails;

String getViewPaintingsFilename(ViewPaintings viewpaintings) => '${viewpaintings.viewImage}';

String getLocationFilename(ViewPaintings viewpaintings) => '${viewpaintings.artLocImage}';

String getViewPaintingsbyId(ViewPaintings viewpaintings) => '${viewpaintings.viewId}';

String artistdeets(ViewPaintings viewpaintings) => viewpaintings.viewartistDetails;

String lifespan(ViewPaintings viewpaintings) => viewpaintings.viewPeriod;

String getArtistFilename(ViewPaintings viewpaintings) => '${viewpaintings.viewartistImage}';
