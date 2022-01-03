/*
Author: AlphaNapster
Email: choejur@hotmail.com
2022
*/
import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/constants.dart';

class TopicsNotifier extends ChangeNotifier {
  String currentTopic = TOPICS.world.name.toUpperCase();

  void changeTopic(String topic) {
    currentTopic = topic;
    notifyListeners();
  }
}
