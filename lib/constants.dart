import 'package:flutter/material.dart';

const kThemeMode = 'themeMode';
const kDark = 'dark';
const kLight = 'light';

Widget customSpacerWidget(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height * 0.03 + 10);
}

Widget customSpacerWidgetLarge(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height * 0.05 + 30);
}

enum TOPICS {
  world,
  nation,
  business,
  technology,
  entertainment,
  science,
  sports,
  health
}

List<String> kTopicsList = [
  'world',
  'nation',
  'business',
  'technology',
  'entertainment',
  'science',
  'sports',
  'health'
];

List<MaterialColor> kColorsList = [
  Colors.red,
  Colors.blue,
  Colors.cyan,
  Colors.green,
  Colors.pink,
  Colors.orange,
  Colors.purple,
  Colors.teal,
];
