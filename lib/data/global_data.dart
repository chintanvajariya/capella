
import 'package:flutter/material.dart';

import 'package:capella/widgets/song_widget.dart';

List<Song> indie = [
  const Song('assets/audio/indie/glue.png', 'Glue Song', 'beabadoobee', 'assets/audio/indie/glue.mp3', 'Indie', false, true),
  const Song('assets/audio/indie/always.png', 'Always', 'Daniel Caesar', 'assets/audio/indie/always.mp3', 'Indie', false, true),
  const Song('assets/audio/indie/loretta.png', 'Loretta', 'Ginger Root', 'assets/audio/indie/loretta.mp3', 'Indie', false, true),
];

List<Song> rock = [
  const Song('assets/audio/rock/lovecomes.jpg', 'Love Comes', 'chintu', 'assets/audio/rock/lovecomes.mp3', 'Rock and Roll', false, true),
  const Song('assets/audio/rock/breathe.png', 'Breathe', 'Pink Floyd', 'assets/audio/rock/breathe.mp3', 'Rock and Roll', false, true),
  const Song('assets/audio/rock/bird.png', 'Blackbird', 'The Beatles', 'assets/audio/rock/bird.mp3', 'Rock and Roll', false, true),
  const Song('assets/audio/rock/happy.png', 'Happy Together', 'The Turtles', 'assets/audio/rock/happy.mp3', 'Rock and Roll', false, true),
];

List<Song> international = [
  const Song('assets/audio/international/histoire.png', "Une autre histoire d'amour", "chintu", 'assets/audio/international/histoire.mp3', 'International', false, true),
  const Song('assets/audio/international/nuits.png', 'nuits d\'ete', 'Oscar Anton', 'assets/audio/international/nuits.mp3', 'International', false, true),
  const Song('assets/audio/international/naive.png', 'Naïve', 'Therapie Taxi', 'assets/audio/international/naive.mp3', 'International', false, true),
  const Song('assets/audio/international/fessee.png', 'La fessée', 'Claire Laffut', 'assets/audio/international/fessee.mp3', 'International', false, true),
];

// ignore: non_constant_identifier_names
List<Song> modern_classical = [
  const Song('assets/audio/modern_classical/reflections.jpg', 'Reflections', 'chintu', 'assets/audio/modern_classical/reflections.mp3', 'Modern Classical', false, true),
  const Song('assets/audio/modern_classical/interstellar.png', 'Interstellar', 'Hans Zimmer', 'assets/audio/modern_classical/interstellar.mp3', 'Modern Classical', false, true),
  const Song('assets/audio/modern_classical/planetarium.png', 'Planetarium', 'Justin Hurwitz', 'assets/audio/modern_classical/planetarium.mp3', 'Modern Classical', false, true),
  const Song('assets/audio/modern_classical/married.png', 'Married Life', 'Michael Giancchino', 'assets/audio/modern_classical/married.mp3', 'Modern Classical', false, true),
];

List<Song> yourSongs = [
  const Song('assets/audio/international/histoire.png', "Une autre histoire d'amour", "chintu", 'assets/audio/international/histoire.mp3', '', true, true),
  const Song('assets/audio/modern_classical/reflections.jpg', 'Reflections', 'chintu', 'assets/audio/modern_classical/reflections.mp3', '', true, true),
  const Song('assets/audio/rock/lovecomes.jpg', 'Love Comes', 'chintu', 'assets/audio/rock/lovecomes.mp3', '', true, true),
];

List<Song> listened = [

];

Map<String, List<Song>> genresMap = {
  "Indie": indie,
  "Rock and Roll": rock,
  "International": international,
  "Modern Classical": modern_classical,
};

String status = ''; //'listener' or 'artist'
bool signedIn = false;

var preferenceList = [];
var balance = 102.32 + listened.length * perSong;
var perSong = 0.12;

var total = 10.00;
var spent = 2.88;
var remaining = total - spent;
var percent = (spent / total) * 100.ceil();
var users = (spent * 8.2).ceil();
bool show = true;

const Color orang = Color.fromARGB(255, 255, 173, 0);
const Color purp = Color.fromARGB(255, 115, 34, 255);
const Color pink = Color.fromARGB(255, 255, 87, 196);
const Color green = Color.fromARGB(255, 0, 255, 153);
const Color blue = Color.fromARGB(255, 87, 157, 255);
const Color purp2 = Color.fromARGB(255, 212, 186, 255);
const Color purp3 = Color.fromARGB(255, 219, 198, 255);
const Color buttonText = Color.fromRGBO(204, 190, 250, 1);
const Color buttonFill = Color.fromRGBO(37, 35, 40, 1);
const Color buttonFill2 = Color.fromRGBO(50, 47, 55, 1);

const List<Color> darkGradient = <Color>[
  Color.fromARGB(255, 255, 179, 0),
  Color.fromARGB(255, 255, 179, 0),
  Color.fromARGB(255, 255, 87, 196),
  Color.fromARGB(255, 115, 34, 255),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
];

const List<Color> lightGradient = <Color>[
  Color.fromARGB(255, 0, 255, 153),
  Color.fromARGB(255, 0, 255, 153),
  Color.fromARGB(255, 87, 157, 255),
  Color.fromARGB(255, 115, 34, 255),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
  Color.fromARGB(255, 28, 27, 31),
];