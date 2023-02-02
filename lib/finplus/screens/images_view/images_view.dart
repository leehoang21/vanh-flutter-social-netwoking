import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewArgument {
  final List<String> urlImages;
  final int index;
  ImageViewArgument({
    required this.urlImages,
    required this.index,
  });
}

class ImagesView extends StatelessWidget {
  const ImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageViewArgument? argument = Get.arguments as ImageViewArgument?;
    final PageController pageController =
        PageController(initialPage: argument?.index ?? 0);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: PhotoViewGallery.builder(
          pageController: pageController,
          itemCount: argument?.urlImages.length,
          builder: (_, i) => PhotoViewGalleryPageOptions(
            imageProvider:
                CachedNetworkImageProvider(argument?.urlImages[i] ?? ''),
            heroAttributes:
                PhotoViewHeroAttributes(tag: argument?.urlImages[i] ?? ''),
          ),
        ),
      ),
    );
  }
}
