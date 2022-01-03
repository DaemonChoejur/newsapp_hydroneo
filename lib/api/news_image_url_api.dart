/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022

This is just a unwanted step
The current basic plan of Google News API does not return a thumbnail image for the article
Therefore, this call will fetch the url provided from the Google News API and get the <img> tag so that the link to the image can be obtained
Article thumbnail is a big part of the App UI, so this will suffice as a demo
In reality, the the API would provide the thumbnail and this class is basically useless.
*/
import 'package:http/http.dart' as http;
import 'package:news_app_hydroneo/models/article.dart';

class NewsImageUrlApiClient {
  NewsImageUrlApiClient();

  // I have used this neat function to scrape an image from a website
  // https://stackoverflow.com/questions/62092032/how-do-you-scrape-an-image-from-a-website-using-flutter
  // Credit to https://stackoverflow.com/users/9439899/josxha
  //

  Future<List<String?>> getAllImageUrls(List<Article> articleLinks) async {
    var client = http.Client();

    List<http.Response> list = await Future.wait(
      articleLinks.map((endpoint) => client.get(
            Uri.parse(endpoint.link),
          )),
    );

    List<String?> urls = [];

    for (var response in list) {
      var url = getProfileImageUrl(response.body);
      urls.add(url);
    }

    return urls;
  }

  String? getProfileImageUrl(String html) {
    // Download the content of the site

    // calling multiple endpoints simultaneously
    // var endpointsCall = [];
    // for (var link in articleLinks) {
    //   endpointsCall.add(await http.get(Uri.parse(lni)));
    // }
    // Future.wait(endpointsCall);

    // http.Response response = await http.get(Uri.parse(url));
    // String html = response.body;

    // The html contains the following string exactly one time.
    // After this specific string the url of the profile picture starts.
    String needle = '<meta property="og:image" content="';
    int index = html.indexOf(needle);

    // The result of indexOf() equals -1 if the needle didn't occurred in the html.
    // In that case the received username may be invalid.
    if (index == -1) return null;

    // Remove all characters up to the start of the text snippet that we want.
    html = html.substring(html.indexOf(needle) + needle.length);

    // return all chars until the first occurrence of '"'
    var result = html.substring(0, html.indexOf('"'));
    print(result);
    return result;
  }
}
