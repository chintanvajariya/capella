import 'package:capella/pages/artist_pages/profile_page.dart';
import 'package:capella/pages/artist_pages/statistics_page.dart';
import 'package:capella/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';

class ArtistRootTabbedPage extends StatefulWidget {
  const ArtistRootTabbedPage({super.key});

  @override
  _ArtistRootTabbedPageState createState() => _ArtistRootTabbedPageState();
}

class _ArtistRootTabbedPageState extends State<ArtistRootTabbedPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: buttonFill,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note_2),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.slider_horizontal_3),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const StatisticsPage());
          case 1:
            return CupertinoTabView(builder: (context) => const ProfilePage());
          case 2:
            return CupertinoTabView(
                builder: (context) => const SettingsPage(false));
          default:
            return Container();
        }
      },
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}