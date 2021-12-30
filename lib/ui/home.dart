import 'package:flutter/material.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/ui/components/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // animation controller for animated icon
  late AnimationController _animationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Paper News'),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: AnimatedIcon(
        //     progress: _animationController,
        //     icon: AnimatedIcons.menu_arrow,
        //   ),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/jb.jpg',
                    ),
                  ),
                ),
              ),
              customSpacerWidget(context),
              const Text(
                  'Rep. Jim Banks unloads on Pelosi, vows to get Jan. 6 answers via GOP panel - New York Post'),
              customSpacerWidget(context),
              const Text(
                  'Rep. Jim Banks is vowing not to back down from investigating the security shortcomings that led to the attack on the Capitol on Jan. 6 despite Speaker Nancy Pelosi (D-Calif.) booting him from the panel on Wednesday.'),
            ],
          ),
        ),
      ),
    );
  }
}
