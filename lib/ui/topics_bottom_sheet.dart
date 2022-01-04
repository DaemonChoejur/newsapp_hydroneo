/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/blocs/news_bloc/news_bloc.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/notifiers/topics_notifier.dart';
import 'package:news_app_hydroneo/ui/components/pull_widget.dart';
import 'package:provider/provider.dart';

class TopicsBottomSheet extends StatelessWidget {
  const TopicsBottomSheet({Key? key}) : super(key: key);

  _renderSnackBar(String text) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.all(20),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PullWidget(),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: kTopicsList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // notify the change notifier that selected topic for API call has changed
                  // important to make sure listen is set to false since we dont' want to listen
                  Provider.of<TopicsNotifier>(context, listen: false)
                      .changeTopic(
                    kTopicsList[index].toUpperCase(),
                  );
                  context
                      .read<NewsBloc>()
                      .add(FetchNews(topic: kTopicsList[index].toUpperCase()));
                  ScaffoldMessenger.of(context).showSnackBar(_renderSnackBar(
                      'Showing ${kTopicsList[index].toUpperCase()} news'));

                  Navigator.of(context).pop();

                  // debugPrint(kTopicsList[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5.0,
                            blurStyle: BlurStyle
                                .solid, //using this style for that glow effect
                            // color: Colors.white12,
                            color: kColorsList[index].withOpacity(0.95))
                      ],
                      color: kColorsList[index].withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          kTopicsList[index].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
