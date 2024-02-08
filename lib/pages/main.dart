// ignore_for_file: must_be_immutable, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables
import 'dart:math';
// import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:capella/data/global_key.dart';
import 'package:capella/data/global_data.dart';

import 'package:capella/pages/artist_pages/artist_root_tabbed_page.dart';
import 'package:capella/pages/choice_page.dart';
import 'package:capella/pages/listener_pages/like_page.dart';
import 'package:capella/pages/listener_pages/listener_root_tabbed_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var seed = DateTime.now().millisecondsSinceEpoch;
  var random1 = Random(seed);
  var random2 = Random(seed);
  var random3 = Random(seed);

  genres.shuffle(random1);
  artists.shuffle(random2);
  artistImages.shuffle(random3);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    ColorScheme myDarkColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 115, 34, 255),
      brightness: Brightness.dark,
    );

    ThemeData myDarkTheme = ThemeData.dark().copyWith(
      colorScheme: myDarkColorScheme,
      splashColor: Colors.transparent,
    );

    if (status == 'listener' && signedIn == true) {
      return MaterialApp(
        theme: myDarkTheme,
        navigatorKey: GlobalKeys.appNavigatorKey,
        home: const ListenerRootTabbedPage(),
      );
    } else if (status == 'artist' && signedIn == true) {
      return MaterialApp(
        theme: myDarkTheme,
        navigatorKey: GlobalKeys.appNavigatorKey,
        home: const ArtistRootTabbedPage(),
      );
    } else {
      return MaterialApp(
        theme: myDarkTheme,
        navigatorKey: GlobalKeys.appNavigatorKey,
        home: const ChoicePage(),
      );
    }
  }
}


// class FileUploader {

//   final PlatformFile file;
//   final String fileName;


//     FileUploader(this.file, this.fileName);

  // Future<String> uploadFile(File file, String fileName) async {
  //   try {
  //     await AwsS3.uploadFile(
  //       accessKey: accessKey,
  //       secretKey: secretKey,
  //       bucket: bucket,
  //       region: region,
  //       file: file,
  //     );
  //     return "https://${bucket}.s3.${region}.amazonaws.com/uploads/$fileName";
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     throw Exception("File upload failed");
  //   }
  // }
// }
