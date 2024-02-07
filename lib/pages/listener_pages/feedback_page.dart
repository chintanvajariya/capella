import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:capella/transitions/slide_from_right_transition.dart';
import 'song_page.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<List<bool>> selections = List.generate(5, (_) => [false, false]);
  double rating = 0.0;

  final List<String> prompts = [
    'Add to Spotify?',
    'Like the genre?',
    'Like the artist?',
    'Like the lyrics?',
    'Well-produced?',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment(-1, 0.4),
            colors: darkGradient,
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'How Was That?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Let us know what you think.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              for (int index = 0; index < prompts.length; index++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 85),
                    Expanded(
                      child: Text(
                        prompts[index],
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: ToggleButtons(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25.0),
                        borderColor: Colors.white,
                        selectedBorderColor: Colors.white,
                        onPressed: (int selected) {
                          setState(() {
                            selections[index] = [false, false];
                            selections[index][selected] = true;
                          });
                        },
                        isSelected: selections[index],
                        fillColor: selections[index][0]
                            ? Colors.green
                            : selections[index][1]
                                ? Colors.red
                                : Colors.transparent,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 12),
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 20,
                                color: selections[index][0]
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 15),
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 20,
                                color: selections[index][1]
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const Spacer(),
              Center(
                child: Text(
                  'Overall Rating',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemSize: 62,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: orang,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
              ),
              const Spacer(),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CupertinoButton(
                  color: buttonFill,
                  padding: EdgeInsets.only(
                      top: 3,
                      bottom: 3,
                      left: (screenWidth / 2 - 60),
                      right: (screenWidth / 2 - 60)),
                  onPressed: () {
                    playRemoteFile();
                    Navigator.pushReplacement(
                      context,
                      SlideFromRightPageRoute(page: nextSong),
                    );
                  },
                  child: const Text('Submit',
                      style: TextStyle(
                          color: buttonText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}