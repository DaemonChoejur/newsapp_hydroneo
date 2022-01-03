/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/ui/components/thumbnail_widget.dart';

class NewsThumbnailWidget extends StatelessWidget {
  final String thumbnail;
  const NewsThumbnailWidget({Key? key, required this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThumbnailWidget(
          thumbnail: thumbnail,
        ),
        thumbnail.contains('https://')
            ? const SizedBox()
            : Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                      child: Text(
                        'Default image from assets.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
