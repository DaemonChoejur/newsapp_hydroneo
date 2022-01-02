import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/models/article.dart';
import 'package:news_app_hydroneo/ui/components/news_thumbnail_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sensors_plus/sensors_plus.dart';

class NewsWidget extends StatefulWidget {
  final Article article;
  const NewsWidget({Key? key, required this.article}) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget>
    with SingleTickerProviderStateMixin {
  List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  late final AnimationController _controller;
  double _scale = 0.0;

  int bgMotionSensitivity = 2;

  @override
  void initState() {
    super.initState();
    // initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    // listen to stream
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    _controller.dispose();
  }

  // url launcher to launch url
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // 1 - _ctonroller.value since the initial value of controller = 0.0
    // Transform uses the scale so setting _scale = _controller.value initially will be _scale = 0.0 rather we want the scale to be 1 at initial
    _scale = 1 - _controller.value;

    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1));
    // if (accelerometer != null) {
    //   debugPrint(accelerometer.toString());
    // }
    DateTime dt = DateTime.parse(widget.article.publishedDate);
    String _formattedDate =
        DateFormat("EEEE, d MMMM yyyy\nHH:mm:ss").format(dt);
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: NewsThumbnailWidget(
                thumbnail: widget.article.thumbnail ?? '',
              )),
        ),
        Positioned(
          // top: MediaQuery.of(context).size.height * 0.55,
          left: 30,
          right: 30,
          bottom: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.article.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  height: 1.3,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              widget.article.description != null
                  ? Container(
                      child: Text(
                        widget.article.description!,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Text(
                    _formattedDate,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      BlocProvider.of<NewsBloc>(context)
                          .add(FetchCachedPreviousNewsArticle());
                      HapticFeedback.lightImpact();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(widget.article.link),
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0.0, 5.0),
                                blurRadius: 30,
                              )
                            ],
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Text(
                              'Read full article',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
                  ),
                  IconButton(
                    // color: Colors.red,
                    iconSize: 30,
                    onPressed: () {
                      BlocProvider.of<NewsBloc>(context)
                          .add(FetchCachedNextNewsArticle());
                      // debugPrint('front');
                      HapticFeedback.lightImpact();
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
