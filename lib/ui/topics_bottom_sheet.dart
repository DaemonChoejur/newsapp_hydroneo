import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/ui/components/pull_widget.dart';

class TopicsBottomSheet extends StatelessWidget {
  const TopicsBottomSheet({Key? key}) : super(key: key);

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
                  // TODO:- notify the change notifier that selected topic for API call has changed
                  debugPrint(kTopicsList[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kColorsList[index].withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        kTopicsList[index].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
