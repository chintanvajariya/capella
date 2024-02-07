import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/transitions/slide_from_right_transition.dart';
import 'package:capella/widgets/carousel_widget.dart';
import 'package:capella/pages/listener_pages/listener_root_tabbed_page.dart';
import 'package:capella/data/global_key.dart';
import 'choice_page.dart';
import 'package:capella/pages/artist_pages/artist_root_tabbed_page.dart';

class SettingsPage extends StatelessWidget {
  final bool dark;
  const SettingsPage(this.dark, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var dark = this.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(1, 0.4),
            colors: dark ? darkGradient : lightGradient,
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Stack(
                children: [
                  Text(
                    'Settings',
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
                    'Settings',
                    style: GoogleFonts.redHatDisplay(
                      letterSpacing: 0.5,
                      fontSize: 48,
                      color: buttonFill2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        
            const SizedBox(height: 20),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(
                  color: buttonFill,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    CupertinoButton(
                      color: buttonFill,
                      padding: EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                          left: (screenWidth / 2 - 139),
                          right: (screenWidth / 2 - 200)),
                      onPressed: () {
                        null;
                      },
                      child: const Text('Connect Finances',
                          style: TextStyle(
                              color: buttonText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 47),
                    Opacity(
                      opacity: 0.25,
                      child: SizedBox(
                        height: 35,
                        child: Image.asset('assets/images/paypal.png'),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Opacity(
                      opacity: 0.25,
                      child: SizedBox(
                        height: 35,
                        child: Image.asset('assets/images/cashapp.png'),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 3,
                          ),
                        ],
                      borderRadius: BorderRadius.circular(8.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Opacity(
                          opacity: 1,
                          child: SizedBox(
                            height: 35,
                            child: Image.asset('assets/images/venmo.png'),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: const BoxDecoration(
                  color: buttonFill,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    CupertinoButton(
                      color: buttonFill,
                      padding: EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                          left: (screenWidth / 2 - 162),
                          right: (screenWidth / 2 - 200)),
                      onPressed: () {
                        null;
                      },
                      child: const Text('Connect Music Platform',
                          style: TextStyle(
                              color: buttonText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 24),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 3,
                            // blurStyle: BlurStyle.solid
                          ),
                        ],
                      borderRadius: BorderRadius.circular(8.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Opacity(
                          opacity: 1,
                          child: SizedBox(
                            height: 35,
                            child: Image.asset('assets/images/spotify.png'),
                          ),
                        ),
                      )
                    ),
                    const SizedBox(width: 5),
                    Opacity(
                      opacity: 0.25,
                      child: SizedBox(
                        height: 35,
                        child: Image.asset('assets/images/applemusic.png'),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Opacity(
                      opacity: 0.25,
                      child: SizedBox(
                        height: 35,
                        child: Image.asset('assets/images/soundcloud.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            dark && listened.isNotEmpty ? const SizedBox(height: 20) : const SizedBox(),
        
            dark && listened.isNotEmpty ? carousel(listened, 'History', math.Random().nextInt(500) + 2500, 2500) : const SizedBox(),
      

            const Spacer(),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: CupertinoButton(
                  color: dark ? green: orang,
                  padding: EdgeInsets.only(
                      top: 3,
                      bottom: 3,
                      left: dark ? (screenWidth / 2 - 76.5) : (screenWidth / 2 - 87),
                      right: dark ? (screenWidth / 2 - 76.5) : (screenWidth / 2 - 87)),
                  onPressed: dark ? () {
                      GlobalKeys.appNavigatorKey.currentState?.pushReplacement(
                      SlideFromRightPageRoute(page: const ArtistRootTabbedPage()),
                    );
                  } : 
                  () {
                      GlobalKeys.appNavigatorKey.currentState?.pushReplacement(
                      SlideFromRightPageRoute(page: const ListenerRootTabbedPage()),
                    );
                  },
                  child: Text(dark ? 'Switch to Artist' : 'Switch to Listener',
                      style: const TextStyle(
                          color: buttonFill,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
        
            const SizedBox(height: 20),
        
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right:20),
              child: Center(
                child: CupertinoButton(
                  color: buttonFill,
                  padding: EdgeInsets.only(
                      top: 3,
                      bottom: 3,
                      left: (screenWidth / 2 - 49.5),
                      right: (screenWidth / 2 - 49.5)),
                  onPressed: () => _showLogoutDialog(context),
                  child: const Text('Log Out',
                      style: TextStyle(
                          color: buttonText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text('Log Out'),
              onPressed: () {
                Navigator.of(context).pop();
                status = '';
                signedIn = false;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ChoicePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}