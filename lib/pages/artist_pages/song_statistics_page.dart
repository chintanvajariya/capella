import 'dart:math';
import 'artist_root_tabbed_page.dart';
import 'package:capella/transitions/fade_scale_page_transition.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/widgets/song_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class SongStatisticsPage extends StatefulWidget {
  
  final Song input;

  const SongStatisticsPage(this.input, {super.key});

  @override
  _SongStatisticsPageState createState() => _SongStatisticsPageState();
}

class _SongStatisticsPageState extends State<SongStatisticsPage> {
  var grad = const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [green, blue, purp]);
  double wid = 22;
  var rad = const BorderRadius.all(Radius.circular(10));
  var back = BackgroundBarChartRodData(toY: 1, show: true, color: Colors.grey.withOpacity(0.2));

  TextEditingController inputController = TextEditingController();
  
  late AudioPlayer _audioPlayer;

  Future<void> _initializeAndPlay() async {
    try {
      if (widget.input.song.contains('assets/')) {
        // This is a locally included file in assets
        await _audioPlayer.setAsset(widget.input.song);
      } else {
        // This is an uploaded file with a file path
        await _audioPlayer.setFilePath(widget.input.song);
      }

      await _audioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print("Error playing audio: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    super.initState();
    _initializeAndPlay();
  }
  
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


  int startIndex = 0;


  final int numberOfBarsToShow = 7;

  // Dummy data for demonstration
  final List<double> allData = List.generate(30, (index) => (index + 1) * 0.12 * (index % 5 + 20));

  List<BarChartGroupData> getVisibleBarGroups() {
  return allData
      .skip(startIndex)
      .take(numberOfBarsToShow)
      .toList()
      .asMap()
      .entries
      .map((entry) {
        int index = entry.key;
        double value = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              gradient: const LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var rating = Random().nextDouble()*1.5 + 2.4;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1, 0.4),
            colors: lightGradient,
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40, width: 400),

              Stack(
                children: [
                  Text(
                    'Song Statistics',
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
                    'Song Statistics',
                    style: GoogleFonts.redHatDisplay(
                      letterSpacing: 0.5,
                      fontSize: 48,
                      color: buttonFill2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              
              Center(child: AbsorbPointer(child: widget.input)),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Percentage of Users That Answered Yes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: purp2
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: SizedBox(
                  height: 200,
                  width: 400,
                  child: BarChart(
                    swapAnimationDuration: const Duration(milliseconds: 150000), // Optional
                    swapAnimationCurve: Curves.easeInOutCubic,
                    BarChartData(
                      barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                        tooltipMargin: -10,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String suffix;
                          switch (groupIndex) {
                            case 0:
                              suffix = '% added to playlist';
                              break;
                            case 1:
                              suffix = '% liked the genre';
                              break;
                            case 2:
                              suffix = '% liked the artist';
                              break;
                            case 3:
                              suffix = '% liked the lyrics';
                              break;
                            case 4:
                              suffix = '% liked the production';
                              break;
                            default:
                              throw Error();
                          }
                          return BarTooltipItem(
                            children: <TextSpan>[
                              TextSpan(
                                text: (rod.toY*100).toStringAsFixed(0) + suffix,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            '',
                            const TextStyle(
                              color: purp2,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        },),
                      ),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 1,
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              String text;
                              switch (value.toInt()) {
                                case 0:
                                  text = 'Added?';
                                  break;
                                case 1:
                                  text = 'Genre';
                                  break;
                                case 2:
                                  text = 'Artist';
                                  break;
                                case 3:
                                  text = 'Lyrics';
                                  break;
                                case 4:
                                  text = 'Quality';
                                  break;
                                default:
                                  throw Error();
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 23,
                                child: Text(text, style: const TextStyle(color: purp2, fontSize: 14)),
                              );
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: Random().nextDouble()*0.4 + 0.05, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: Random().nextDouble()*0.75 + 0.25, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: Random().nextDouble()*0.75 + 0.25, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                        BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: Random().nextDouble()*0.75 + 0.25, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                        BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: Random().nextDouble()*0.75 + 0.25, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 45),

              const Center(
                child: Text(
                  'Song Rating',
                  style: TextStyle(
                    color: purp2,
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
                    color: green,
                  ),
                  ignoreGestures: true,
                  onRatingUpdate: (newRating) {
                    
                  },
                ),
              ),

              

              const Spacer(),

              Center(
                child: CupertinoButton(
                  color: purp,
                  padding: EdgeInsets.only(
                    top: 3,
                    bottom: 3,
                    left: (screenWidth / 2 - 75),
                    right: (screenWidth / 2 - 75)),
                  onPressed: () {
                    null;
                  },
                  child: const Text('Remove Song?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: CupertinoButton(
                  color: blue,
                  padding: EdgeInsets.only(
                    top: 3,
                    bottom: 3,
                    left: (screenWidth / 2 - 41),
                    right: (screenWidth / 2 - 41)),
                  onPressed: () {
                    _audioPlayer.pause();
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      FadeScalePageRoute(page: const ArtistRootTabbedPage()),
                    );
                  },
                  child: const Text('Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}