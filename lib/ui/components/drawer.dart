import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/common/theme.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  // we need _isDarkMode so we can set the state of the switch after reading from shared preferences.
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context).isDarkMode;

    if (theme) {
      setState(() {
        _isDarkMode = true;
      });
    } else {
      setState(() {
        _isDarkMode = false;
      });
    }
    return Drawer(
        child: Column(
      children: [
        const DrawerHeader(
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Hi Stranger,',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          // decoration: BoxDecoration(
          //     color: Colors.green,
          //     image: DecorationImage(
          //         fit: BoxFit.fill,
          //         image: AssetImage('assets/images/cover.jpg'))),
        ),
        ListTile(
          // leading: const Icon(Icons.input),
          title: const Text('API calls remaining'),
          trailing: const Text('20'),
          onTap: () => {},
        ),
        const Divider(),
        ListTile(
          // leading: const Icon(Icons.input),
          title: const Text('Theme Mode'),
          trailing: _isDarkMode
              ? const Icon(Icons.dark_mode_rounded)
              : const Icon(Icons.light_mode_rounded),
          onTap: () => {},
        ),
        CupertinoSwitch(
            activeColor: Colors.green,
            value: _isDarkMode,
            trackColor: Theme.of(context).iconTheme.color,
            // thumbColor: Colors.red,
            onChanged: (val) {
              setState(() {
                _isDarkMode = val;
              });
              if (_isDarkMode == false) {
                // just set the thememode in ThemeNotifier once, which is why listen = false
                Provider.of<ThemeNotifier>(context, listen: false)
                    .setLightMode();
              } else {
                Provider.of<ThemeNotifier>(context, listen: false)
                    .setDarkMode();
              }
            }),
        const Divider(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: RichText(
                textScaleFactor: 1.1,
                text: TextSpan(
                  text: '2021 ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                        text: '\u00a9',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' AlphaNapster.',
                      style: TextStyle(
                          fontFamily: "Shoguns Clan",
                          fontSize: 24,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

// custom linear gradient for my custom TAG
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffFC466B), Color(0xff3F5EFB)],
).createShader(const Rect.fromLTWH(70.0, 0.0, 300.0, 70.0));
