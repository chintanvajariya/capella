import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/transitions/fade_scale_page_transition.dart';
import 'listener_root_tabbed_page.dart'; 


class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});

  @override
  _CongratsPageState createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  @override
  Widget build(BuildContext context) {
    balance = balance + perSong;
    // var bal = balance.toStringAsFixed(2);
    // var ps = perSong.toStringAsFixed(2);
    // var max = (perSong * 16).toStringAsFixed(2);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: darkGradient,
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              IconButton(
                iconSize: 30,
                icon: const Icon(CupertinoIcons.xmark),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    FadeScalePageRoute(page: const ListenerRootTabbedPage()),
                  );
                },
              ),
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  'Congrats!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 110),
              Center(
                child: Text(
                  'You\'ve listened to all ${listened.length} of\nour curated songs for now',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'You earned \$${(perSong*listened.length).toStringAsFixed(2)}!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'Find these songs in your History tab!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  'Look out for a notification from us to earn more!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}