import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:capella/data/global_data.dart';
import 'package:capella/widgets/carousel_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour > 16 || hour < 4) {
        return 'Evening';
      }
      if (hour > 12) {
        return 'Afternoon';
      }
      return 'Morning';
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1, 0.4),
            colors: darkGradient,
            tileMode: TileMode.mirror,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Text(
                          'Good ${greeting()}',
                          style: GoogleFonts.redHatDisplay(
                            letterSpacing: 0.5,
                            fontSize: 48,
                            fontWeight: FontWeight.w700,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = purp3,
                          ),
                        ),
                        Text(
                          'Good ${greeting()}',
                          style: GoogleFonts.redHatDisplay(
                            letterSpacing: 0.5,
                            fontSize: 48,
                            color: buttonFill2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10, width: screenWidth),
                  ],
                ),
              ),

              SizedBox(height: 10, width: screenWidth),
              
              carousel(indie, "Indie", math.Random().nextInt(500) + 2500, 2500),
              const SizedBox(height: 20),
              
              carousel(rock, "Rock and Roll", math.Random().nextInt(500) + 2500, 2500),
              const SizedBox(height: 20),

              carousel(international, "International", math.Random().nextInt(500) + 2500, 2500),
              const SizedBox(height: 20),
              
              carousel(modern_classical, "Modern Classical", math.Random().nextInt(500) + 2500, 2500),
              const SizedBox(height: 20),


              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}