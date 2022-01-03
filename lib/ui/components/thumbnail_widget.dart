/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ThumbnailWidget extends StatelessWidget {
  final String thumbnail;
  const ThumbnailWidget({Key? key, required this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return thumbnail.contains('http')
        ? Center(
            child: CachedNetworkImage(
              imageUrl: thumbnail,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              fadeInDuration: const Duration(seconds: 1),
              fadeOutDuration: const Duration(seconds: 3),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              // color: Theme.of(context).dividerColor,
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/jb.jpg'),
              ),
            ),
          );
  }
}
