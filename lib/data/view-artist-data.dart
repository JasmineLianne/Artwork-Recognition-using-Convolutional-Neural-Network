import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class ViewArtist {
  final int? viewartistId;
  final String viewartistName;
  final String viewPeriod;
  final String viewartistDetails;
  final String viewartistImage;

  ViewArtist({
    this.viewartistId,
    required this.viewartistName,
    required this.viewPeriod,
    required this.viewartistDetails,
    required this.viewartistImage,
  });

  factory ViewArtist.fromMap(Map<String, dynamic> json) => ViewArtist(
    viewartistId: json['viewartistId'],
    viewartistName: json['viewartistName'],
    viewPeriod: json['viewPeriod'],
    viewartistDetails: json['viewartistDetails'],
    viewartistImage: json['viewartistImage'],
  );

  Map<String, dynamic> toMap() {
    return {
      'viewartistId': viewartistId,
      'viewartistName': viewartistName,
      'viewPeriod': viewPeriod,
      'viewartistDetails': viewartistDetails,
      'viewartistImage': viewartistImage,
    };
  }
}
class ViewArtistDatabaseHelper {
  ViewArtistDatabaseHelper._privateConstructor();

  static final ViewArtistDatabaseHelper instance = ViewArtistDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ViewArtist.db');
    return await openDatabase(
      path,
      version: 1,  // Update the version to handle the migration.
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ViewArtist(
      viewartistId INTEGER PRIMARY KEY,
      viewartistName TEXT,
      viewPeriod TEXT,
      viewartistDetails TEXT,
      viewartistImage TEXT
    )
  ''');
    print("ViewArtist table created successfully!");
  }

  Future<void> importArtistDataFromJson() async {
    String jsonString = await rootBundle.loadString('assets/data/view-artist.json');
    List<dynamic> data = json.decode(jsonString);

    ViewArtistDatabaseHelper databaseHelper = ViewArtistDatabaseHelper.instance; // Access the instance from DatabaseHelper
    Database db = await databaseHelper.database;
    for (var item in data) {
      await db.insert(
        'ViewArtist',
        ViewArtist(
            viewartistId: item['viewId'],
            viewartistName: item['viewartistName'],
            viewPeriod: item['viewPeriod'],
            viewartistDetails: item['viewartistDetails'],
            viewartistImage: item['viewartistImage']
        ).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
  Future<List<ViewArtist>> getAllViewArtist() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('ViewArtist');
    return result.map((viewartistMap) => ViewArtist.fromMap(viewartistMap)).toList();
  }

  Future<ViewArtist> getViewArtistById(String viewartistId) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('ViewArtist', where: 'viewartistId = ?', whereArgs: [viewartistId]);
    if (results.isNotEmpty) {
      return ViewArtist.fromMap(results.first);
    } else {
      throw Exception('Artist not found');
    }
  }

}



String description(ViewArtist viewartist) => viewartist.viewartistDetails;

String lifespan(ViewArtist viewartist) => viewartist.viewPeriod;

String getViewArtistFilename(ViewArtist viewartist) => '${viewartist.viewartistImage}';

String getViewArtistbyId(ViewArtist viewartist) => '${viewartist.viewartistId}';