import 'package:cached_network_image/cached_network_image.dart';
import 'package:finplus/finplus/screens/images_view/images_view.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageBox extends StatelessWidget {
  final List<String> images;
  const ImageBox({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (images.isEmpty) {
      return const SizedBox();
    }

    if (images.length == 1) {
      return Center(child: _buildImage(0, null, size.width, fit: BoxFit.cover));
    }

    if (images.length == 2) {
      return SizedBox(
        height: 150,
        width: size.width,
        child: Row(
          children: [
            Expanded(
              child: _buildImage(0, 150, size.width / 2),
            ),
            Spaces.boxW5,
            Expanded(
              child: _buildImage(1, 150, size.width / 2),
            ),
          ],
        ),
      );
    }

    if (images.length == 3) {
      return AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(builder: (context, box) {
          return Row(
            children: [
              Expanded(
                child: _buildImage(0, box.maxHeight, size.width),
              ),
              Spaces.boxW5,
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      child: _buildImage(1, box.maxHeight / 2, size.width / 2)),
                  Spaces.boxW5,
                  Expanded(
                      child: _buildImage(2, box.maxHeight / 2, size.width / 2)),
                ],
              ))
            ],
          );
        }),
      );
    }

    if (images.length == 4) {
      return AspectRatio(
        aspectRatio: 1,
        child: LayoutBuilder(builder: (context, box) {
          return Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      child: _buildImage(0, box.maxHeight / 2, size.width / 2)),
                  Spaces.boxW5,
                  Expanded(
                      child: _buildImage(1, box.maxHeight / 2, size.width / 2)),
                ],
              )),
              Spaces.boxW5,
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                      child: _buildImage(2, box.maxHeight / 2, size.width / 2)),
                  Spaces.boxW5,
                  Expanded(
                      child: _buildImage(3, box.maxHeight / 2, size.width / 2)),
                ],
              )),
            ],
          );
        }),
      );
    }

    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, box) {
        return Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(
                    child: _buildImage(0, box.maxHeight / 2, size.width / 2)),
                Spaces.boxW5,
                Expanded(
                    child: _buildImage(1, box.maxHeight / 2, size.width / 2)),
              ],
            )),
            Spaces.boxW5,
            Expanded(
                child: Column(
              children: [
                Expanded(
                    child: _buildImage(2, box.maxHeight / 2, size.width / 2)),
                Spaces.boxH5,
                Expanded(
                    child: Stack(
                  children: [
                    _buildImage(3, box.maxHeight / 2, size.width / 2),
                    GestureDetector(
                      onTap: () => _gotoImagesView(index: 3),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.black38),
                        alignment: Alignment.center,
                        child: Text(
                          '+${(images.length - 4).toString()}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: context.t.background,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            )),
          ],
        );
      }),
    );
  }

  Widget _buildImage(int index, double? height, double? width,
      {BoxFit fit = BoxFit.cover}) {
    return GestureDetector(
      onTap: () {
        _gotoImagesView(index: index);
      },
      child: Hero(
        tag: images[index],
        child: CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: images[index],
          fit: fit,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                    AlwaysStoppedAnimation<Color>(context.t.primaryChat),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            padding: Spaces.a10,
            color: context.t.backgroundFailLoad,
            width: width,
            height: height ?? 250,
            child: const Center(
              child: Icon(CupertinoIcons.exclamationmark_circle),
            ),
          ),
        ),
      ),
    );
  }

  void _gotoImagesView({int index = 0}) {
    Get.toNamed(
      Routes.images_view,
      arguments: ImageViewArgument(
        listImages: images,
        index: index,
        imageType: IMAGE_TYPE.URL,
      ),
    );
  }
}
