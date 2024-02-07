import 'package:capella/pages/settings_page.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'home_page.dart';
import 'finances_page.dart';


class ListenerRootTabbedPage extends StatefulWidget {
  const ListenerRootTabbedPage({super.key});

  @override
  _ListenerRootTabbedPageState createState() => _ListenerRootTabbedPageState();
}

class _ListenerRootTabbedPageState extends State<ListenerRootTabbedPage> {
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
            icon: Icon(Icons.auto_graph),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.slider_horizontal_3),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const HomePage());
          case 1:
            return CupertinoTabView(builder: (context) => const FinancesPage());
          case 2:
            return CupertinoTabView(
                builder: (context) => const SettingsPage(true));
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