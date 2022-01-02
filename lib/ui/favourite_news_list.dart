import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouriteNewsList extends StatelessWidget {
  const FavouriteNewsList({Key? key}) : super(key: key);

  String _convertTime(String date) {
    DateTime dt = DateTime.parse(date);
    String _formattedDate =
        DateFormat("EEEE, d MMMM yyyy, HH:mm:ss").format(dt);
    return _formattedDate;
  }

  // url launcher to launch url
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourties',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // TODO: open url
                // _launchURL();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/jb.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text(
                                  'Rep. Jim Banks unloads on Pelosi, vows to get Jan. 6 answers via GOP panel - New York Post',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: true,
                                  maxLines: 5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Flexible(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.blue,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _convertTime(
                                            '2021-07-22T01:15:00+00:00'),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}
