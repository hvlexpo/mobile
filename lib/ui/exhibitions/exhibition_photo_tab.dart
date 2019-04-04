import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

        return GestureDetector(
          child: Hero(
            tag: '${photo}__hero__$index',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: photo,
              ),
            ),
          ),
          onTap: () => _open(context, photo, index),
        );
      },
    );
  }

  void _open(BuildContext context, String photoUrl, final int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
              backgroundDecoration: BoxDecoration(color: Colors.black),
              photos: photos,
              index: index,
            ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.photos,
    this.loadingChild,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.index,
  }) : pageController = PageController(initialPage: index);

  final BuiltList<String> photos;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int index;
  final PageController pageController;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery(
                scrollPhysics: const BouncingScrollPhysics(),
                pageOptions: widget.photos
                    .map((photo) => PhotoViewGalleryPageOptions(
                        imageProvider: CachedNetworkImageProvider(photo),
                        heroTag: '${photo}__hero__$currentIndex'))
                    .toList(),
                loadingChild: widget.loadingChild,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              )
            ],
          )),
    );
  }
}
