import 'package:flutter/material.dart';
import '/data/viewings-data.dart';
import '/ui/widgets/item_tile.dart';

class FeaturedTile extends StatelessWidget {
  const FeaturedTile({
    Key? key,
    required this.viewpaintings,
    required this.tileWidth,
    required this.tileHeight,
  }) : super(key: key);

  final ViewPaintings viewpaintings;

  /// Desired width of the tile.
  final double tileWidth;

  /// Desired height of the tile.
  final double tileHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        ItemTile.ViewPaintings(
          ViewPaintings: viewpaintings,
          tileWidth: tileWidth,
          tileHeight: tileHeight,
          customHeroTag: '${viewpaintings.viewTitle!}_featured',
        ),
        Container(
          color: Colors.black45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${viewpaintings.viewTitle}, ',
                        style: const TextStyle(
                          fontSize: 28,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      TextSpan(
                        text: viewpaintings.viewartistName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
