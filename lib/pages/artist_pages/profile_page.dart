import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:capella/data/global_data.dart';
import 'package:google_fonts/google_fonts.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, double> dataMap = {
    "Spent": spent,
    "Remaining": remaining,
  };

  TextEditingController inputController = TextEditingController();
  
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
                  const SizedBox(height: 40),
                  Stack(
                    children: [
                      Text(
                        'Profile',
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
                        'Profile',
                        style: GoogleFonts.redHatDisplay(
                          letterSpacing: 0.5,
                          fontSize: 48,
                          color: buttonFill2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                    width: screenWidth,
                  ),

                  const SizedBox(height: 10),
                  
                  Row(
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(3), // Border width
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary, // Border color
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 15),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Text(
                                'chintu',
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: purp2,
                                  decorationThickness: 0.65,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 4
                                    ..color = purp2,
                                ),
                              ),
                              Text(
                                'chintu',
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Theme.of(context).colorScheme.primary,
                                  decorationThickness: 0.65,
                                  color: Colors.white,
                                ),
                              ),
                            ]
                          ),
                          Text(
                            ' • Bossa Nova',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            ' • Lo-fi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            ' • Bedroom Pop',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 350,
                          width: 350,
                          child:  PieChart(
                            PieChartData(
                              startDegreeOffset: -90,
                              sectionsSpace: 7.5,
                              centerSpaceRadius: 120,
                              sections: [
                                PieChartSectionData(
                                borderSide: const BorderSide(width: 3, color: purp2),
                                value: dataMap["Spent"],
                                showTitle: false,
                                color: green,
                                ),
                                PieChartSectionData(
                                borderSide: const BorderSide(width: 3, color: purp2),
                                showTitle: false,
                                value: dataMap["Remaining"],
                                color: purp,
                                ),
                              ]
                            ),
                            swapAnimationDuration: const Duration(milliseconds: 3000),
                            swapAnimationCurve: Curves.ease,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Text(
                                "\$${total.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 4
                                    ..color = Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                "\$${total.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: purp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                              "\$${spent.toStringAsFixed(2)} | ${percent.toInt()}% spent",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: green,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(height: 8),
                          Text("$users Unique\nUsers Reached",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: SizedBox(
                      width: 110,
                      child: CupertinoTextField(
                        padding: const EdgeInsets.only(right: 7, top: 7, bottom: 7,),
                        controller: inputController,
                        prefix: const Icon(CupertinoIcons.money_dollar, size: 30, color: purp2,),
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 25),
                        placeholder: '0.00',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Spacer(),
                      CupertinoButton(
                        color: green,
                        padding: EdgeInsets.only(
                            top: 3,
                            bottom: 3,
                            left: (screenWidth / 4 - 44),
                            right: (screenWidth / 4 - 44)),
                        onPressed: () {
                          String inputText = inputController.text;
                          if (!_isValidInput(inputText, true)) {
                            _showErrorDialog(context, 'Invalid input. Please enter a valid amount.');
                            return;
                          }
                          
                          double inputAmount = double.parse(inputText.replaceAll('\$', ''));
                          setState(() {
                            inputController.text = "";
                            updateDataMap(inputAmount, true);
                          });
                        },
                        child: Text('Deposit',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(width: 25),
                      CupertinoButton(
                        color: purp,
                        padding: EdgeInsets.only(
                            top: 3,
                            bottom: 3,
                            left: (screenWidth / 4 - 52.02),
                            right: (screenWidth / 4 - 52.02)),
                        onPressed: () {
                          String inputText = inputController.text;
                          if (!_isValidInput(inputText, false)) {
                            _showErrorDialog(context, 'Invalid input. Please enter a valid amount.');
                            return;
                          }
      
                          double inputAmount = double.parse(inputText.replaceAll('\$', ''));
                          if (!false && inputAmount > remaining) {
                            _showErrorDialog(context, 'Insufficient funds. Please enter a smaller amount.');
                            return;
                          }
                          setState(() {
                            inputController.text = "";
                            updateDataMap(inputAmount, false);
                          });
                        },
                        child: Text('Withdraw',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateDataMap(double change, bool deposit) {
    total = deposit ? total + change : total - change;
    remaining = total - spent;
    percent = (spent / total) * 100.ceil();
    users = (spent * 8.2).ceil();

    setState(() {
      dataMap = {"Spent": spent, "Remaining": remaining};
    });
  }

  bool _isValidInput(String input, bool deposit) {
    String pattern = r'^\$?\d+(\.\d{1,2})?$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(input);
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}