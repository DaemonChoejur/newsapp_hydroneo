import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/common/theme.dart';
import 'package:news_app_hydroneo/ui/home.dart';
import 'package:provider/provider.dart';

class ENewsApp extends StatelessWidget {
  const ENewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return MaterialApp(
            theme: theme.getTheme(),
            debugShowCheckedModeBanner: false,
            home: const Home(),
          );
        },
      ),
    );
  }
}
