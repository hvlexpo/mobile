import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoTab extends StatelessWidget {
  final BuiltList<String> photos;

  PhotoTab(this.photos);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          crossAxisSpacing: 25,
          childAspectRatio: 0.75),
      itemCount: photos.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        final photo = photos[index];

        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: photo,
          ),
        );
      },
    );
  }
}
