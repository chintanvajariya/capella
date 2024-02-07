import 'package:capella/pages/artist_pages/artist_root_tabbed_page.dart';
import 'package:capella/transitions/slide_from_left_transition.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'package:just_audio/just_audio.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import 'package:capella/widgets/song_widget.dart';

class AddSongPage extends StatefulWidget {

  const AddSongPage({super.key});

  @override
  _AddSongPageState createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {

  PlatformFile? songFile;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  PlatformFile? imageFile;
  String? title;
  bool isSongUploaded = false;
  bool isImageUploaded = false;
  String userInput = '';
  TextEditingController inputController = TextEditingController();
  late MultiSelectController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MultiSelectController();
    inputController.addListener(() {
      setState(() {
        userInput = inputController.text;
      });
    });
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  Future<void> _initializeAndPlay() async {
    try {
      // Ensure the file is selected
      if (songFile != null && songFile!.path != null) {
        await _audioPlayer.setFilePath(songFile!.path!);
        _audioPlayer.play();
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      // Handle error, such as file not found
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

  Future<void> pickSongFile() async {
    FilePickerResult? song = await FilePicker.platform.pickFiles();
    if (song != null && song.files.isNotEmpty && isAudioFile(song.files.first)) {
      setState(() {
        songFile = song.files.first;
        isSongUploaded = true;
      });
      _initializeAndPlay();
      _audioPlayer.pause();
    }
  }

  Future<void> pickImageFile() async {
    FilePickerResult? image = await FilePicker.platform.pickFiles();
    if (image != null && image.files.isNotEmpty && isImageFile(image.files.first)) {
      setState(() {
        imageFile = image.files.first;
        isImageUploaded = true;
      });
    }
  }

  bool isAudioFile(PlatformFile file) {
    var extension = file.name.split('.').last.toLowerCase();
    return ['mp3', 'wav', 'm4a', 'flac'].contains(extension);
  }

  bool isImageFile(PlatformFile file) {
    var extension = file.name.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'tiff'].contains(extension);
  }

  // String uploadFile(PlatformFile file, String fileName) {
  //   try {
  //       AwsS3.uploadFile(
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  green,
                  blue,
                  Color.fromARGB(255, 115, 34, 255),
                  Color.fromARGB(255, 28, 27, 31),
                  Color.fromARGB(255, 28, 27, 31),
                ],
                tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  TextButton.icon(
                    icon: const Icon(Icons.arrow_back_ios),
                    style: const ButtonStyle(
                        iconColor: MaterialStatePropertyAll<Color>(Colors.white)),
                    label: const Text('Upload Your Song',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        SlideFromLeftPageRoute(page: const ArtistRootTabbedPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: CupertinoButton(
                      color: const Color.fromARGB(255, 26, 225, 192),
                      padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: (screenWidth / 2 - 82),
                          right: (screenWidth / 2 - 82)),
                      onPressed: isSongUploaded ? null : () {
                        pickSongFile();
                      },
                      child: const Text('Upload Song File',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),

                  if (!isSongUploaded)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.xmark_circle_fill, color: purp2),
                            SizedBox(width: 4),
                            Text('Upload Incomplete', style: TextStyle(color: purp2)),
                          ],
                        ),
                      ),
                    ),

                  if (isSongUploaded)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_box, color: purp2),
                            SizedBox(width: 4),
                            Text('Upload Successful', style: TextStyle(color: purp2)),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: 25),
                  
                  Center(
                    child: CupertinoButton(
                      color: blue,
                      padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: (screenWidth / 2 - 84.5),
                          right: (screenWidth / 2 - 84.5)),
                      onPressed: isImageUploaded ? null : () {
                        pickImageFile();
                      },
                      child: const Text('Upload Cover File',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),

                                    if (!isImageUploaded)
                    const Center(
                      child:  Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(CupertinoIcons.xmark_circle_fill, color: purp2),
                            SizedBox(width: 4),
                            Text('Upload Incomplete', style: TextStyle(color: purp2)),
                          ],
                        ),
                      ),
                    ),

                  if (isImageUploaded)
                    const Center(
                      child:  Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_box, color: purp2),
                            SizedBox(width: 4),
                            Text('Upload Successful', style: TextStyle(color: purp2)),
                          ],
                        ),
                      ),
                    ),

            
                  const SizedBox(height: 25),
            
                  Center(
                    child: SizedBox(
                      width: screenWidth - 40,
                      child: CupertinoTextField(
                        decoration: BoxDecoration(
                            color: purp,
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: (screenWidth / 2 - 200),
                          right: (screenWidth / 2 - 200)),
                        onChanged: (text) {
                          setState(() {
                            userInput = text;
                          });
                        },
                        controller: inputController,
                        style: const TextStyle(color: purp2, fontSize: 16, fontWeight: FontWeight.w500),
                        placeholder: 'Input Song Title',
                        placeholderStyle: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.3), fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  MultiSelectDropDown(
                    controller: _controller,
                    padding: const EdgeInsets.only(left: 8, right: 6),
                    searchBackgroundColor: buttonFill,
                    selectedOptionTextColor: Colors.white,
                    inputDecoration: BoxDecoration(
                      color: buttonFill,
                      borderRadius: BorderRadius.circular(8.0)),
                    hintStyle: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 103, 103, 103), fontWeight: FontWeight.w500),
                    hint: 'Genres',
                    fieldBackgroundColor: purp2,
                    dropdownMargin: 20,
                    searchLabel: 'Search',
                    showClearIcon: false,
                    onOptionSelected: (options) {
                      for(var option in options){
                        setState(() {
                         _controller.selectedOptions.add(option);
                        });
                      }
                    },
                    options: const <ValueItem>[
                      ValueItem(label: 'Classic Rock', value: '1'),
                      ValueItem(label: 'Jazz', value: '2'),
                      ValueItem(label: 'Hip-Hop', value: '3'),
                      ValueItem(label: 'International', value: '4'),
                      ValueItem(label: 'Gospel', value: '5'),
                      ValueItem(label: 'Bollywood', value: '6'),
                      ValueItem(label: 'Pop', value: '7'),
                      ValueItem(label: 'Folk', value: '8'),
                      ValueItem(label: 'Reggae', value: '9'),
                      ValueItem(label: 'Bossa Nova', value: '10'),
                      ValueItem(label: 'Blues', value: '11'),
                      ValueItem(label: 'Country', value: '12'),
                      ValueItem(label: 'Heavy Metal', value: '13'),
                      ValueItem(label: 'R&B', value: '14'),
                      ValueItem(label: 'EDM', value: '15'),
                      ValueItem(label: 'Fusion', value: '16'),
                      ValueItem(label: 'Indie', value: '17'),
                      ValueItem(label: 'Punk Rock', value: '18'),
                      ValueItem(label: 'K-Pop', value: '19'),
                      ValueItem(label: 'Tollywood', value: '20'),
                      ValueItem(label: 'Bluegrass', value: '21'),
                      ValueItem(label: 'Experimental', value: '22'),
                      ValueItem(label: 'Kollywood', value: '23'),
                      ValueItem(label: 'Modern Classical', value: '24'),
                      ValueItem(label: 'Oldies', value: '25'),
                      ValueItem(label: 'Dubstep', value: '26'),
                      ValueItem(label: 'House', value: '27'),
                      ValueItem(label: 'Bedroom Pop', value: '28'),
                      ValueItem(label: 'Progressive Rock', value: '29'),
                      ValueItem(label: 'Ska', value: '30'),
                      ValueItem(label: 'Afrobeat', value: '31'),
                      ValueItem(label: 'Rock and Roll', value: '32'),
                      ValueItem(label: 'Lo-fi', value: '33'),
                      ValueItem(label: 'Psychedelic', value: '34'),
                      ValueItem(label: 'Synthwave', value: '35'),
                    ],
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(
                      wrapType: WrapType.scroll,
                      spacing: 5,
                    ),
                    selectedOptionBackgroundColor: Colors.transparent,
                    optionsBackgroundColor: Colors.transparent,
                    searchEnabled: true,
                    dropdownHeight: 225,
                    dropdownBorderRadius: 8,
                    borderRadius: 8,
                    dropdownBackgroundColor: purp,
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  ),

                  const SizedBox(height: 60),


                  if(!isSongUploaded && !isImageUploaded && userInput == '')
                    const Center(child: Song('assets/images/error.jpg', 'Title', 'chintu', 'assets/audio/error.mp3', '', false, false)),

                  if(!isSongUploaded && isImageUploaded && userInput == '')
                    Center(child: Song(imageFile!.path.toString(), 'Title', 'chintu', 'assets/audio/error.mp3', '', false, false)),
                    
                  if(isSongUploaded && !isImageUploaded && userInput == '')
                    Center(child: Song('assets/images/error.jpg', 'Title', 'chintu', songFile!.path.toString(), '', false, false)),
                    
                  if(!isSongUploaded && !isImageUploaded && userInput != '')
                    Center(child: Song('assets/images/error.jpg', userInput, 'chintu', 'assets/audio/error.mp3', '', false, false)),

                  if(isSongUploaded && isImageUploaded && userInput == '')
                    Center(child: Song(imageFile!.path.toString(), 'Title', 'chintu', songFile!.path.toString(), '', false, false)),

                  if(!isSongUploaded && isImageUploaded && userInput != '')
                    Center(child: Song(imageFile!.path.toString(), userInput, 'chintu', 'assets/audio/error.mp3', '', false, false)),

                  if(isSongUploaded && !isImageUploaded && userInput != '')
                    Center(child: Song('assets/images/error.jpg', userInput, 'chintu', 'assets/audio/error.mp3', '', false, false)),

                  if(isSongUploaded && isImageUploaded && userInput != '')
                    Center(child: Song(imageFile!.path.toString(), userInput, "chintu", songFile!.path.toString(), '', false, false)),


                  const SizedBox(height: 30),

                  StreamBuilder<Duration>(
                    stream: _audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;
                      final duration = _audioPlayer.duration ?? Duration.zero;
                      return Column(
                        children: [
                          Row(
                            children: [
                              _buildCustomIconButton(
                                icon: _isPlaying
                                    ? CupertinoIcons.pause_fill
                                    : CupertinoIcons.play_arrow_solid,
                                iconSize: 30,
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
                              Expanded( // Wrap the Slider with an Expanded widget
                                child: Slider(
                                  value: position.inSeconds.toDouble(),
                                  max: duration.inSeconds.toDouble(),
                                  onChanged: (value) async {
                                    final newPosition = Duration(seconds: value.toInt());
                                    await _audioPlayer.seek(newPosition);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDuration(position)),
                              Text(_formatDuration(duration - position)),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      );
                    },
                  ),
                  
                  const SizedBox(height: 55),
                  
                  Center(
                    child: CupertinoButton(
                      color: buttonFill,
                      padding: EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                          left: (screenWidth / 2 - 42),
                          right: (screenWidth / 2 - 42)),
                      onPressed: () {
                        String genre = _controller.selectedOptions.first.label;
                        genresMap[genre]!.add(Song(imageFile!.path.toString(), userInput, "chintu", songFile!.path.toString(), genre, false, true),);

                        yourSongs.add(Song(imageFile!.path.toString(), userInput, "chintu", songFile!.path.toString(), '', true, true),);

                        Navigator.pushReplacement(
                          context,
                          SlideFromLeftPageRoute(page: const ArtistRootTabbedPage()),
                        );
                      },
                      child: const Text('Done',
                          style: TextStyle(
                              color: buttonText,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
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
        highlightColor: Colors.grey.withOpacity(0.5),
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