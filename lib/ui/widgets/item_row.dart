import 'package:flutter/material.dart';
import '/data/viewings-data.dart';
import '/data/view-artist-data.dart';
import '/data/gallery-data.dart';
import '/ui/home_pages/viewings_page.dart';
import '/ui/home_pages/viewings_artist_page.dart';
import '/ui/home_pages/viewings_gallery.dart';
import '/ui/widgets/item_tile.dart';

class ItemRow extends StatelessWidget {
  ItemRow.ViewArtist({Key? key, required ViewArtist ViewArtist, this.rowHeight})
      : title = ViewArtist.viewartistName,
        subtitle = ViewArtist.viewPeriod,
        imgFileName = getViewArtistFilename(ViewArtist),
        _heroTag = ViewArtist.viewartistName,
        detailsPage = ArtistsDetailsPage(viewartist: ViewArtist),
        super(key: key);

  ItemRow.ViewPaintings({Key? key, required ViewPaintings ViewPaintings, this.rowHeight})
      : title = ViewPaintings.viewTitle,
        subtitle = ViewPaintings.viewAddInfo,
        imgFileName = getViewPaintingsFilename(ViewPaintings),
        _heroTag = ViewPaintings.viewTitle,
        detailsPage = ViewingsDetailsPage(viewpaintings: ViewPaintings),
        super(key: key);

  ItemRow.Gallery({Key? key, required Gallery Gallery, this.rowHeight})
      : title = Gallery.galleryName,
        subtitle =  Gallery.detailsEng,
        imgFileName = getGalleryFilename(Gallery),
        _heroTag = Gallery.galleryName,
        detailsPage = GalleryDetailsPage(gallery: Gallery),
        super(key: key);


  final String title;
  final String subtitle;
  final String imgFileName;
  final double? rowHeight;
  final Widget detailsPage;
  final String _heroTag;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detailsPage),
        );
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Tile(
              imagePath: imgFileName,
              heroTag: _heroTag,
              tileWidth:
              rowHeight ?? MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
