import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE\nMMMM d').format(now);

    // we need to know if the current mode is darkmode or not so we can set the value of the cupertino switch accurately.
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/newsbg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              'Paper News',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    offset: Offset(0.0, 6.0),
                  )
                ],
                color: Colors.white,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            formattedDate.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Theme Mode',
            textScaleFactor: 1.07,
          ),
          // change icon based on value of _isDarkMode
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
              // change value of _isDarkMode which i used in UI
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
        // using dynamic height value + a constant height factor
        SizedBox(height: MediaQuery.of(context).size.height * 0.02 + 20),
        // const Spacer(flex: 1),
        // ListTile(
        //   // leading: const Icon(Icons.input),
        //   title: const Text(
        //     'Favourites',
        //     textScaleFactor: 1.07,
        //   ),
        //   subtitle: const Text('Your favourite news list.'),
        //   trailing: const Text(
        //     '20',
        //     textScaleFactor: 1.07,
        //   ),
        //   onTap: () => {},
        // ),
        // const Divider(),
        // const ListTile(
        //   // leading: const Icon(Icons.input),
        //   title: Text(
        //     'Api calls remaining',
        //     textScaleFactor: 1.07,
        //   ),
        //   // subtitle:  Text(''),
        //   trailing: Text(
        //     '20',
        //     textScaleFactor: 1.07,
        //   ),
        // ),
        Center(
            child: Column(
          children: [
            Text(
              'Rate Limit: 5 requests/min',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).errorColor,
              ),
            ),
            Text(
              'Hard Limit: 10 requests/day',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        )),
        const Divider(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: RichText(
                textScaleFactor: 1.1,
                text: TextSpan(
                  text: now.year.toString(),
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: ' \u00a9',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
