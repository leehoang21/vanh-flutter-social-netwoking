import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
enum VALUE_TYPE {
  URL,
  PATH,
}

class Avatar extends StatelessWidget {
  ///path or url
  final String value;
  final double size;
  final int borderWidth;
  final Widget? icon;
  final VALUE_TYPE valueType;
  const Avatar({
    super.key,
    this.size = 40,
    required this.value,
    this.borderWidth = 0,
    this.icon,
    this.valueType = VALUE_TYPE.URL,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CircleAvatar(
      backgroundColor: theme.primary_03,
      radius: (size + borderWidth) / 2,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(size / 2),
        child: valueType == VALUE_TYPE.URL
            ? CachedNetworkImage(
                imageUrl: value,
                fit: BoxFit.cover,
                width: size,
                height: size,
                errorWidget: (context, url, error) =>
                    icon ??
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      color: theme.textContent,
                      size: size,
                    ),
              )
            : value.isEmpty
                ? SizedBox(
                    width: size,
                    height: size,
                    child: icon ??
                        Icon(
                          CupertinoIcons.person_alt_circle,
                          color: theme.textContent,
                          size: size,
                        ),
                  )
                : Image.file(
                    File(value),
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                  ),
      ),
    );
  }
}
