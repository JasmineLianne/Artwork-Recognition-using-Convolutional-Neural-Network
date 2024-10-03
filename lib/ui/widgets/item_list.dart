import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/data/viewings-data.dart';
import '/data/view-artist-data.dart';
import '/data/gallery-data.dart';
import '/ui/widgets/item_tile.dart';

class ListHorizontal extends StatelessWidget {
  const ListHorizontal({
    Key? key,
    required this.itemList,
    this.listHeight,
  }) : super(key: key);

  // todo make input argument simple List
  final List<dynamic> itemList;
  final double? listHeight;

  @override
  Widget build(BuildContext context) {
    final double height =
        listHeight ?? MediaQuery.of(context).size.height * 0.2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: height,
        child: itemList.isNotEmpty
            ? ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            if (itemList[0].runtimeType == ViewArtist) {
              return ItemTile.ViewArtist(
                ViewArtist: itemList[index] as ViewArtist,
                tileWidth: height,
              );
            } else if (itemList[0].runtimeType == ViewPaintings) {
              return ItemTile.ViewPaintings(
                ViewPaintings: itemList[index] as ViewPaintings,
                tileWidth: height,
              );
            } else if (itemList[0].runtimeType == Gallery) {
              return ItemTile.Gallery(
                Gallery: itemList[index] as Gallery,
                tileWidth: height,
              );
            } else {
              // Handle other types or provide a default fallback
              return Container();
            }
          },
        )
            : const Center(
          child: SpinKitRotatingPlain(color: Colors.white),
        ),
      ),
    );
  }
}