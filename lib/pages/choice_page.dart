import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/pages/artist_pages/artist_login_page.dart';
import 'package:capella/pages/listener_pages/listener_login_page.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Welcome to Capella!',
              style: TextStyle(color: purp2, fontSize: 23)),
          content: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
                'We\'re a platform dedicated to empowering artists and listeners'
                ' by bridging the gap between them with a simple promise: artists'
                ' gain a genuine audience, and listeners get paid. Dive into a '
                'world where every note you savor supports an artist\'s journey,'
                ' and your feedback shapes the stars of tomorrow. With Capella, '
                'you\'re not just enjoying music—you\'re part of a movement that'
                ' values every beat and every listener.',
                softWrap: true,
                style: TextStyle(fontSize: 15)),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (show) {
        _showWelcomeDialog();
        show = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildGradientButton(
            start: Alignment.topCenter,
            end: Alignment.bottomCenter,
            dark: true,
            context,
            text: 'Listener',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListenerLoginPage()),
              );
            },
          ),
          _buildGradientButton(
            start: Alignment.bottomCenter,
            end: Alignment.topCenter,
            dark: false,
            context,
            text: 'Artist',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ArtistLoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context,
      {required String text,
      required VoidCallback onPressed,
      required AlignmentGeometry start,
      required AlignmentGeometry end,
      required bool dark}) {
    var darkGradient = [
      orang,
      const Color.fromARGB(255, 255, 87, 196),
      purp,
      const Color.fromARGB(255, 28, 27, 31)
    ];
    var lightGradient = [
      green,
      const Color.fromARGB(255, 87, 157, 255),
      purp,
      const Color.fromARGB(255, 28, 27, 31)
    ];
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: dark ? darkGradient : lightGradient,
              begin: start,
              end: end,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
