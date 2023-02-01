import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String url;
  const Avatar({
    super.key,
    this.size = 40,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(size / 2),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorWidget: (context, url, error) => Icon(
          CupertinoIcons.person_alt_circle,
          size: size,
        ),
      ),
    );
  }
}
