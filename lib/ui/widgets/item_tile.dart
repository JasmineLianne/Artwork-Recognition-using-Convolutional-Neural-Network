import 'package:flutter/material.dart';
import '/data/viewings-data.dart';
import '/data/view-artist-data.dart';
import '/data/gallery-data.dart';
import '/ui/home_pages/viewings_page.dart';
import '/ui/home_pages/viewings_artist_page.dart';
import '/ui/home_pages/viewings_gallery.dart';

/// Displays the provided image at [imagePath] in a tile with rounded corners.
class Tile extends StatelessWidget {
  /// Creates a tile with rounded corners displaying the provided image.
  ///
  /// The [imagePath] and [tileWidth] arguments must not be null. If [tileHeight]
  /// is not specified, it will be set to equal to [tileWidth], i.e. a square
  /// tile will be created.
  const Tile({
    Key? key,
    required this.imagePath,
    required this.tileWidth,
    this.tileHeight,
    this.heroTag,
  }) : super(key: key);

  /// Path to the image to be displayed.
  final String imagePath;

  /// Desired width of the tile.
  final double tileWidth;

  /// Desired height of the tile.
  final double? tileHeight;

  /// Desired hero tag for the image displayed in the tile.
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tileWidth,
      height: tileHeight ?? tileWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Hero(
          tag: heroTag ?? imagePath,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// Displays the provided [Artist] or [Artwork] as an image tile, which when
/// tapped takes the user to a details page showing more info about the
/// provided object.
///
/// If [tileHeight] is not specified, it will be set to equal [tileWidth], i.e.
/// a square tile will be created. If neither is provided, they will default to
/// a value equal to 20% of the current screen height.
class ItemTile extends StatelessWidget {
  /// Creates a tile with rounded corners displaying the provided [Artist].
  ItemTile.ViewArtist({
    Key? key,
    required ViewArtist ViewArtist,
    this.tileWidth,
    this.tileHeight,
    String? customHeroTag,// Optional custom hero tag
  })  : _title = ViewArtist.viewartistName!,
        _subtitle = ViewArtist.viewPeriod!,
        _imgFileName = getViewArtistFilename(ViewArtist),
        _customHeroTag = customHeroTag ?? ViewArtist.viewartistName!,
        _detailsPage = ArtistsDetailsPage(viewartist: ViewArtist),
        super(key: key);

  /// Creates a tile with rounded corners displaying the provided [Artwork].
  ItemTile.ViewPaintings({
    Key? key,
    required ViewPaintings ViewPaintings,
    this.tileWidth,
    this.tileHeight,
    String? customHeroTag, // Optional custom hero tag
  })  : _title = ViewPaintings.viewTitle!,
        _subtitle = ViewPaintings.viewartistName!,
        _imgFileName = getViewPaintingsFilename(ViewPaintings),
        _customHeroTag = customHeroTag ?? ViewPaintings.viewTitle!,
        _detailsPage = ViewingsDetailsPage(viewpaintings: ViewPaintings),
        super(key: key);

  ItemTile.Gallery({
    Key? key,
    required Gallery Gallery,
    this.tileWidth,
    this.tileHeight,
    String? customHeroTag, // Optional custom hero tag
  })  : _title = Gallery.galleryName!,
        _subtitle = Gallery.detailsEng!,
        _imgFileName = getGalleryFilename(Gallery),
        _customHeroTag = customHeroTag ?? Gallery.galleryName!,
        _detailsPage = GalleryDetailsPage(gallery: Gallery),
        super(key: key);


  // todo add option to include title and subtitle below tiles
  final String _title;
  final String _subtitle;
  final String _imgFileName;
  final Widget _detailsPage;

  /// Desired width of the tile.
  final double? tileWidth;

  /// Desired height of the tile.
  final double? tileHeight;

  final String _customHeroTag;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _detailsPage),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Tile(
        imagePath: _imgFileName,
        heroTag: _customHeroTag,
        tileWidth: tileWidth ?? MediaQuery.of(context).size.height * 0.2,
        tileHeight: tileHeight ?? MediaQuery.of(context).size.height * 0.2,
      ),
    ),
  );
}