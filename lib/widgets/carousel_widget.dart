import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:auto_size_text/auto_size_text.dart'; 
import 'song_widget.dart';
import 'package:capella/data/global_data.dart';

Column carousel(List<Song> item, String name, int interval, int duration) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            decoration: const BoxDecoration(color: buttonFill, borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text(
              name,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: purp2),
            ),
          ),
        ),
        const SizedBox(height: 6),
        item.isNotEmpty ? 
        CarouselSlider(
        items: item,
        options: CarouselOptions(
          height: 123,
          autoPlay: true,
          autoPlayInterval: Duration(milliseconds: interval),
          autoPlayAnimationDuration: Duration(milliseconds: duration),
          enlargeCenterPage: true,
          viewportFraction: 0.69,
        )
      ) : 
      Center(
        child: Container(
          width: 290,
          decoration: const BoxDecoration(color: buttonFill, borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: AutoSizeText(
            'You\'ve listened to all \n of our curated\n $name Songs',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: purp2),
          ),
        ),
      ),
    ],
  );
}