import 'package:flutter/material.dart';

const kThemeMode = 'themeMode';
const kDark = 'dark';
const kLight = 'light';

Widget customSpacerWidget(BuildContext context) {
  return SizedBox(height: MediaQuery.of(context).size.height * 0.03 + 10);
}
