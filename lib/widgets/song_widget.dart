import 'package:capella/pages/artist_pages/song_statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capella/transitions/fade_scale_page_transition.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/pages/listener_pages/song_page.dart';

class Song extends StatelessWidget {
  final String cover;
  final String title;
  final String artist;
  final String song;
  final String genre;
  final bool insight;
  final bool scroll;

  const Song(this.cover, this.title, this.artist, this.song, this.genre, this.insight, this.scroll, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          if (scroll) {
            if (!insight) {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                FadeScalePageRoute(page: SongPage(cover, title, artist, song, genre)),
              );
            } else {
              Navigator.of(context, rootNavigator: true).pushReplacement(
                FadeScalePageRoute(page: SongStatisticsPage(Song(cover, title, artist, song, genre, true, true))),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: purp3,
                      blurRadius: 6,
                    ),
                  ],
                  color: purp2,
                  borderRadius: BorderRadius.circular(8.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.asset(
                    cover,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      title,
                      maxLines: 2,
                      minFontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 26.5, fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      artist,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
