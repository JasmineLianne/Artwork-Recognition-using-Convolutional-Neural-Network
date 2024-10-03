import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class Gallery {
  final int? galleryId;
  final String galleryName;
  final String detailsEng;
  final String galleryImage;

  Gallery({
    this.galleryId,
    required this.galleryName,
    required this.detailsEng,
    required this.galleryImage,
  });

  factory Gallery.fromMap(Map<String, dynamic> json) => Gallery(
      galleryId: json['galleryId'],
      galleryName: json['galleryName'],
      detailsEng: json['detailsEng'],
      galleryImage: json['galleryImage']
  );

  Map<String, dynamic> toMap() {
    return {
      'galleryId': galleryId,
      'galleryName': galleryName,
      'detailsEng': detailsEng,
      'galleryImage': galleryImage
    };
  }
}
class GalleryDatabaseHelper {
  GalleryDatabaseHelper._privateConstructor();

  static final GalleryDatabaseHelper instance = GalleryDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Gallery.db');
    return await openDatabase(
      path,
      version: 1,  // Update the version to handle the migration.
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Gallery(
      galleryId INTEGER PRIMARY KEY,
      galleryName TEXT,
      detailsEng TEXT,
      galleryImage TEXT
    )
  ''');
    print("Gallery table created successfully!");
  }

  Future<void> importGalleryDataFromJson() async {
    String jsonString = await rootBundle.loadString('assets/data/gallery.json');
    List<dynamic> data = json.decode(jsonString);

    GalleryDatabaseHelper databaseHelper = GalleryDatabaseHelper.instance; // Access the instance from DatabaseHelper
    Database db = await databaseHelper.database;
    for (var item in data) {
      await db.insert(
        'Gallery',
        Gallery(
            galleryId: item['galleryId'],
            galleryName: item['galleryName'],
            detailsEng: item['detailsEng'],
            galleryImage: item['galleryImage']
        ).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
  Future<List<Gallery>> getAllGallery() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('Gallery');
    return result.map((galleryMap) => Gallery.fromMap(galleryMap)).toList();
  }

  Future<Gallery> getGalleryById(String galleryId) async {
    Database db = await database; // Assuming you have a reference to the database
    List<Map<String, dynamic>> results = await db.query('Gallery', where: 'galleryId = ?', whereArgs: [galleryId]);
    if (results.isNotEmpty) {
      return Gallery.fromMap(results.first);
    } else {
      throw Exception('Gallery not found');
    }
  }

}


String description(Gallery gallery) => gallery.detailsEng;

String getGalleryFilename(Gallery gallery) => '${gallery.galleryImage}';

String getGallerybyId(Gallery gallery) => '${gallery.galleryId}';