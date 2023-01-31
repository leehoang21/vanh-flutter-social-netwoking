import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagesView extends StatelessWidget {
  final List<String> urlImages;
  final int index;
  const ImagesView({Key? key, this.index = 0, required this.urlImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: index);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: PhotoViewGallery.builder(
          pageController: pageController,
          itemCount: urlImages.length,
          builder: (_, i) => PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(urlImages[i]),
            heroAttributes: PhotoViewHeroAttributes(tag: urlImages[i]),
          ),
        ),
      ),
    );
  }
}
