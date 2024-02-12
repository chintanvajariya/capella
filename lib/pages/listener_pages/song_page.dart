import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capella/pages/listener_pages/feedback_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:capella/widgets/song_widget.dart';
import 'package:capella/transitions/slide_from_right_transition.dart';
import 'package:capella/transitions/fade_scale_page_transition.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:capella/data/global_data.dart';
import 'congrats_page.dart';
import 'listener_root_tabbed_page.dart';

// ignore: must_be_immutable
class SongPage extends StatefulWidget {
  String cover;
  String title;
  String artist;
  String song;
  String genre;

  SongPage(this.cover, this.title, this.artist, this.song, this.genre,
      {super.key});

  @override
  _SongPageState createState() => _SongPageState();
}

double percentFeedback = 0.4;
List<bool> isFeedback = [false, true, false, false, true];
int index = 0;

bool isNext = true;
SongPage nextSong = SongPage(
    'assets/images/error.jpg', 'Title', 'chintu', 'assets/audio/error.mp3', '');

void playRemoteFile() {
  AudioPlayer player = AudioPlayer();
  player.setVolume(0.4);
  player.setAsset('assets/audio/money.mp3');
  player.play();
}

class _SongPageState extends State<SongPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  String nextSongName = '';
  var randGenre;
  var randSong;
  Song? songToRemove;
  List<Song> songsInGenre = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAndPlay();

    listened.add(Song(widget.cover, widget.title, widget.artist, widget.song,
        widget.genre, false, false));
    songsInGenre = genresMap[widget.genre]!;
    songToRemove = songsInGenre.firstWhere(
      (song) => song.title == widget.title && song.artist == widget.artist,
    );
    songsInGenre.remove(songToRemove);

    List<String> genreKeys = genresMap.keys.toList();

    bool isNextSong = true;

    if (isNext) {
      randGenre = genreKeys[Random().nextInt(genreKeys.length)];
      if (genresMap[randGenre]!.isEmpty) {
        for (var i = 0; i < genresMap.length; i++) {
          randGenre = genreKeys[i];
          if (genresMap[randGenre]!.isEmpty) {
            isNextSong = false;
          } else {
            isNextSong = true;
            break;
          }
        }
      }

      if (isNextSong) {
        randSong = Random().nextInt(genresMap[randGenre]!.length);
        nextSong = SongPage(
            genresMap[randGenre]![randSong].cover,
            genresMap[randGenre]![randSong].title,
            genresMap[randGenre]![randSong].artist,
            genresMap[randGenre]![randSong].song,
            genresMap[randGenre]![randSong].genre);
      }
    }

    for (var entry in genresMap.entries) {
      List<Song> songsList = entry.value;

      if (songsList.isEmpty) {
        isNext = false;
        nextSongName = 'You\'ve listened to our curated list!';
      } else {
        isNext = true;
        nextSongName =
            'Next Song: ${genresMap[randGenre]![randSong].title} by ${genresMap[randGenre]![randSong].artist}';
        break;
      }
    }

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // var random = Random();
        // var tester = random.nextDouble();
        if (index == isFeedback.length) {}
        if (isNext) {
          if (isFeedback[index]) {
            index == isFeedback.length - 1 ? index = 0 : index++;
            Navigator.pushReplacement(
              context,
              SlideFromRightPageRoute(page: const FeedbackPage()),
            );
          } else {
            playRemoteFile();
            index == isFeedback.length - 1 ? index = 0 : index++;
            Navigator.pushReplacement(
              context,
              SlideFromRightPageRoute(page: nextSong),
            );
          }
        } else if (!isNext) {
          Navigator.pushReplacement(
            context,
            SlideFromRightPageRoute(page: const CongratsPage()),
          );
        }
      }
    });
  }

  Future<void> _initializeAndPlay() async {
    try {
      if (widget.song.contains('assets/')) {
        // This is a locally included file in assets
        await _audioPlayer.setAsset(widget.song);
      } else {
        // This is an uploaded file with a file path
        await _audioPlayer.setFilePath(widget.song);
      }
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _isPlaying = true;
        });
      });

      await _audioPlayer.play();
    } catch (e) {
      if (kDebugMode) {
        print("Error playing audio: $e");
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String cover = widget.cover;
    String title = widget.title;
    String artist = widget.artist;
    String genre = widget.genre;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(255, 255, 179, 0),
              Color.fromARGB(255, 255, 87, 196),
              Color.fromARGB(255, 115, 34, 255),
              Color.fromARGB(255, 28, 27, 31),
              Color.fromARGB(255, 28, 27, 31),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    iconSize: 30,
                    icon: const Icon(CupertinoIcons.xmark),
                    color: Colors.white,
                    onPressed: () {
                      Song newSongToRemove = listened.firstWhere(
                        (song) =>
                            song.title == widget.title &&
                            song.artist == widget.artist,
                      );
                      listened.remove(newSongToRemove);
                      songsInGenre.add(songToRemove!);
                      balance -= perSong;
                      Navigator.pushReplacement(
                        context,
                        FadeScalePageRoute(
                            page: const ListenerRootTabbedPage()),
                      );
                    },
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const SizedBox(height: 75),
                      SizedBox(
                        width: 290,
                        child: Center(
                          child: TextScroll(
                            pauseBetween: const Duration(milliseconds: 2500),
                            pauseOnBounce: const Duration(milliseconds: 2500),
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(50, 0)),
                            mode: TextScrollMode.endless,
                            fadedBorder: true,
                            fadedBorderWidth: 0.1,
                            fadeBorderSide: FadeBorderSide.right,
                            ' $title ',
                            style: const TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 50),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                      color: purp3,
                      blurRadius: 8,
                    ),
                  ], color: purp2, borderRadius: BorderRadius.circular(6.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      cover,
                      width: 325,
                      height: 325,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Text(
                  artist,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Text(
                  genre,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<Duration>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  final duration = _audioPlayer.duration ?? Duration.zero;
                  return Column(
                    children: [
                      Slider(
                          value: position.inSeconds.toDouble(),
                          max: duration.inSeconds.toDouble(),
                          onChanged: null),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(position)),
                          Text(_formatDuration(duration - position)),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildCustomIconButton(
                              icon: CupertinoIcons.share,
                              iconSize: 40,
                              onTap: () {
                                Share.share(
                                    'Check out this song: $title by $artist');
                              },
                            ),
                          ),
                          _buildCustomIconButton(
                            icon: _isPlaying
                                ? CupertinoIcons.pause_fill
                                : CupertinoIcons.play_arrow_solid,
                            iconSize: 85,
                            onTap: () {
                              if (_isPlaying) {
                                _audioPlayer.pause();
                              } else {
                                _audioPlayer.play();
                              }
                              setState(() {
                                _isPlaying = !_isPlaying;
                              });
                            },
                          ),
                          Expanded(
                            child: _buildCustomIconButton(
                              icon: CupertinoIcons.forward_end,
                              iconSize: 45,
                              onTap: () {
                                _audioPlayer.seek(duration);
                                setState(() {
                                  _isPlaying = false;
                                });
                                _audioPlayer.play();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
              const Spacer(),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: screenWidth - 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: buttonFill,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      ' $nextSongName ',
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomIconButton(
      {required IconData icon,
      required double iconSize,
      required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashFactory: NoSplash.splashFactory,
        // highlightColor: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(iconSize),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
