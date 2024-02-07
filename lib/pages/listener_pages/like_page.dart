import 'package:flutter/material.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:capella/data/global_data.dart';
import 'package:capella/transitions/slide_from_right_transition.dart';
import 'listener_root_tabbed_page.dart';

List<String> genres = [
  "Classic Rock",
  "Jazz",
  "Hip-Hop",
  "International",
  "Gospel",
  "Bollywood",
  "Pop",
  "Folk",
  "Reggae",
  "Bossa Nova",
  "Blues",
  "Country",
  "Heavy Metal",
  "R&B",
  "EDM",
  "Fusion",
  "Indie",
  "Punk Rock",
  "K-Pop",
  "Tollywood",
  "Bluegrass",
  "Experimental",
  "Kollywood",
  "Modern Classical",
  "Oldies",
  "Dubstep",
  "House",
  "Bedroom Pop",
  "Progressive Rock",
  "Ska",
  "Afrobeat",
  "Rock and Roll",
  "Lo-fi",
  "Psychedelic",
  "Synthwave",
];

List<bool> isSelectedListener = List.generate(35, (_) => false);


List<String> artists = [
  "Drake", 
  "Taylor Swift", 
  "Atif Aslam", 
  "Oscar Anton", 
  "Nujabes", 
  "Bob Marley", 
  "beabadoobee", 
  "Pink Floyd", 
  "Hans Zimmer",
  "Miles Davis",
  "Michael Buble",
  "BTS",
  "Lo-fi Girl",
  "Jay-Z",
  "Skrillex",
  "Morgan Wallen",
  "Metallica",
  "Frank Sinatra",
  "Rihanna",
  "Bob Dylan",
  "mxmtoon",
];

List<String> artistImages = [
  "https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/371287_v9_bc.jpg", 
  "https://pyxis.nymag.com/v1/imgs/71b/3a9/8a5bd8c650c1620c22126eb167b47e1026-taylorswift.1x.rsquare.w1400.jpg", 
  "https://i.pinimg.com/736x/f3/81/21/f3812158f42dc4ff7299f75336a4777d.jpg", 
  "https://pbs.twimg.com/profile_images/1456231557811802134/NWo62SdH_400x400.jpg", 
  "https://assets-global.website-files.com/62158cc7e1cd8f0ec3729390/63ed33a3ae590080bf42a352_nujabes-z6eOl.jpeg", 
  "https://primarywave.com/wp-content/uploads/2018/04/A-41441-1444396064-7860.jpeg.jpg", 
  "https://i.scdn.co/image/ab676161000051749d6d0ba276987f19641c27de", 
  "https://cdn.britannica.com/64/23164-050-A7D2E9D9/Pink-Floyd.jpg", 
  "https://i.scdn.co/image/ab6761610000e5eb371632043a8c12bb7eeeaf9d", 
  "https://hips.hearstapps.com/hmg-prod/images/gettyimages-73909081.jpg", 
  "https://ew.com/thmb/S1YcQL0-TGSdkaTuVPXPEhLnB3Y=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/michael-buble-122223-923e3a72df7a4d998aeb51c746bf2b4a.jpg",
  "https://assets.puzzlefactory.com/puzzle/429/969/original.webp", 
  "https://wordpress.wbur.org/wp-content/uploads/2023/09/lofigirl-1-1000x563.jpeg", 
  "https://imageio.forbes.com/specials-images/imageserve/5ed554fab14861000600baf1/0x0.jpg?format=jpg&crop=686,686,x53,y114,safe&height=416&width=416&fit=bounds", 
  "https://static.wikia.nocookie.net/galantis9298/images/1/18/IMG_0102.jpg/revision/latest/scale-to-width-down/1200?cb=20170722145354", 
  "https://i.guim.co.uk/img/media/c267f72e023c5454338e43f68b9ee45c1ef4e710/0_116_1828_1096/master/1828.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=2ba1fc731c70ce37b0f8d197c6f225ad", 
  "https://www.udiscovermusic.com/wp-content/uploads/2020/11/Metallica-GettyImages-531257207-1000x600.jpg", 
  "https://hips.hearstapps.com/hmg-prod/images/gettyimages-119684687.jpg", 
  "https://r.lvmh-static.com/uploads/2018/03/regard-944x1270-1-944x1270.jpg", 
  "https://hips.hearstapps.com/hmg-prod/images/gettyimages-944125264-1621630232.jpg?crop=0.724xw:0.765xh;0.160xw,0.157xh&resize=640:*", 
  "https://static.standard.co.uk/s3fs-public/thumbnails/image/2020/09/15/14/mxmtoon-1509.jpg?width=1200&height=1200&fit=crop", 
];

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  

  List<bool> isSelected = List.generate(21, (_) => false);

  TextEditingController locationController = TextEditingController();
  int selectedGenderIndex = 0;
  List<String> genderOptions = ['Gender', 'Male', 'Female', 'Nonbinary', 'Unsure', 'Other'];

  @override
  void initState() {
    super.initState();
  }


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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: screenWidth,
                ),
                Stack(
                  children: [
                    Text(
                      'Preferences',
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
                      'Preferences',
                      style: GoogleFonts.redHatDisplay(
                        letterSpacing: 0.5,
                        fontSize: 48,
                        color: buttonFill2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                      width: 109,
                      child: GestureDetector(
                        onTap: () => showCupertinoModalPopup(
                          context: context, 
                          builder: (BuildContext context) => buildGenderPicker(context)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: buttonFill,
                            border: Border.all(color: purp2, width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              genderOptions[selectedGenderIndex],
                              style: TextStyle(
                                    color: genderOptions[selectedGenderIndex] == "Gender" ? Theme.of(context).colorScheme.secondary.withOpacity(0.4) : Theme.of(context).colorScheme.secondary,
                                    fontSize: 17,
                                    fontWeight: genderOptions[selectedGenderIndex] == "Gender" ? FontWeight.lerp(FontWeight.w300, FontWeight.w400, 0.5) : FontWeight.w500,),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    SizedBox(
                      width: 272,
                      child: CupertinoTextField(
                        controller: locationController,
                        autofillHints: const [AutofillHints.location],
                        placeholder: 'Location (optional)',
                        style:
                            TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500),
                        decoration: BoxDecoration(
                          color: buttonFill,
                          border: Border.all(
                            color: purp2,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffix: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.location,
                              size: 28.0,
                              color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),                

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: screenWidth / 2 - 70,
                      decoration: const BoxDecoration(
                          color: purp2),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('GENRES',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: purp2,
                              letterSpacing: 0.2)),
                    ),
                    Container(
                      height: 1,
                      width: screenWidth / 2 - 70,
                      decoration: const BoxDecoration(
                          color: purp2),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                Wrap(
                  spacing: 7.0, // Gap between each button
                  runSpacing: 1.0, // Gap between rows
                  children: List.generate(genres.length, (index) {
                    return FilterChip(
                      label: Text(
                        genres[index],
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      selected: isSelectedListener[index],
                      onSelected: (bool selected) {
                        setState(() {
                          isSelectedListener[index] = selected;
                        });
                      },
                      pressElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: isSelectedListener[index]
                                ? Colors.transparent
                                : Theme.of(context).colorScheme.primary,
                            width: 1.0),
                      ),
                    );
                  }),
                ),


                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: screenWidth / 2 - 71,
                      decoration: const BoxDecoration(
                          color: purp2),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('ARTISTS',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: purp2,
                              letterSpacing: 0.2)),
                    ),
                    Container(
                      height: 1,
                      width: screenWidth / 2 - 71,
                      decoration: const BoxDecoration(
                          color: purp2),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                Wrap(
                  spacing: 7.0, // Gap between each button
                  runSpacing: 7.0, // Gap between rows
                  children: List.generate(artists.length, (index) {
                    return FilterChip(
                      padding: const EdgeInsets.all(0),
                      label: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                fit: BoxFit.cover,
                                artistImages[index],
                                width: artists[index].length*9 < 64 ? 70 : artists[index].length*9,
                                height: 80,
                              ),
                            ),
                          ), 
                          Text(
                            artists[index],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 1),
                        ],
                      ),
                      selected: isSelected[index],
                      onSelected: (bool selected) {
                        setState(() {
                          isSelected[index] = selected;
                        });
                      },
                      showCheckmark: false,
                      pressElevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: isSelected[index]
                                ? Colors.transparent
                                : Theme.of(context).colorScheme.primary,
                            width: 1.0),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CupertinoButton(
                    padding: EdgeInsets.only(
                      top: 3,
                      bottom: 3,
                      left: (screenWidth / 2 - 41),
                      right: (screenWidth / 2 - 41)),
                    color: buttonFill,
                    child: const Text(
                      'Done',
                      style: TextStyle(color: buttonText, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        SlideFromRightPageRoute(page: const ListenerRootTabbedPage()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildGenderPicker(BuildContext context) {
    return Container(
      height: 200,
      color: buttonFill,
      child: CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedGenderIndex = index;
          });
        },
        children: genderOptions.map((option) => Text(option)).toList(),
      ),
    );
  }
}