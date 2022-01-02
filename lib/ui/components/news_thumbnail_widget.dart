import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsThumbnailWidget extends StatelessWidget {
  final String thumbnail;
  const NewsThumbnailWidget({Key? key, required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: thumbnail.contains('https://')
          ? thumbnail
          : 'https://nypost.com/wp-content/uploads/sites/2/2021/07/jim-banks-914.jpg?quality=80&strip=all&w=1200',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      fadeInDuration: const Duration(seconds: 1),
      fadeOutDuration: const Duration(seconds: 3),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
