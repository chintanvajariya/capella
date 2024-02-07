import 'package:flutter/material.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart'; // For bar charts
import 'package:capella/data/global_data.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({super.key});

  @override
  _FinancesPageState createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  var grad = const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [orang, pink, purp]);
  double wid = 22;
  var rad = const BorderRadius.all(Radius.circular(10));
  var back = BackgroundBarChartRodData(toY: 8.16, show: true, color: Colors.grey.withOpacity(0.2));

  TextEditingController inputController = TextEditingController();


int startIndex = 0;
  final int numberOfBarsToShow = 7;

  // Dummy data for demonstration
  final List<double> allData = List.generate(30, (index) => (index + 1) * 0.12 * (index % 5 + 20));

  // Method to get the bar groups to display
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

  // Dynamic bottom titles based on visible data
  AxisTitles getBottomTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (double value, TitleMeta meta) {
          // Assuming you have a method to format the label for each index
          String label = formatDateLabel(startIndex + value.toInt());
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 23,
            child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
          );
        },
      ),
    );
  }

  // Helper method to format the bottom title labels
  String formatDateLabel(int index) {
    // Replace with your actual date formatting logic
    DateTime date = DateTime.now().subtract(Duration(days: index));
    return "${date.month}/${date.day}";
  }

  
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
                colors: darkGradient,
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
                        'Finances',
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
                        'Finances',
                        style: GoogleFonts.redHatDisplay(
                          letterSpacing: 0.5,
                          fontSize: 48,
                          color: buttonFill2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40, width: 400),
                  Center(
                    child: SizedBox(
                      height: 376,
                      width: 400,
                      child: BarChart(
                        swapAnimationDuration: const Duration(milliseconds: 150000), // Optional
                        swapAnimationCurve: Curves.easeInOutCubic,
                        BarChartData(
                          barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey.withOpacity(0.75),
                            tooltipHorizontalAlignment: FLHorizontalAlignment.left,
                            tooltipMargin: -10,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '\$',
                                const TextStyle(
                                  color: purp2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: (rod.toY).toStringAsFixed(2),
                                    style: const TextStyle(
                                      color: purp2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            },),
                          ),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 8,
                          titlesData: FlTitlesData(
                            show: true,
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                DateTime date = DateTime.now().subtract(Duration(days: 6 - value.toInt()));
                                String text = '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 23,
                                    child: Text(text, style: const TextStyle(color: purp2, fontSize: 14)),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 20,
                                    child: Text('\$${value.toInt()}', style: const TextStyle(color: purp2, fontSize: 14)),
                                  );
                                },
                              ),
                            ),
                          ),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 0.12 * 25, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 0.12 * 42, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 0.12 * 51, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 0.12 * 68, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 0.12 * 28, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                            BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 0.12 * 41, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                            BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: listened.length * perSong, gradient: grad, width: wid, borderRadius: rad, backDrawRodData: back)]),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            orang,
                            Color.fromARGB(255, 255, 87, 196),
                            purp,
                            Color.fromARGB(255, 28, 27, 31)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '\$${((balance*100).floor()/100.0).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: purp2,
                            ),
                          ),
                          const Text(
                            'Total Balance',
                            style: TextStyle(
                              fontSize: 20,
                              color: purp2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  
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
                  const SizedBox(height: 28),
                  
                  Center(
                    child: CupertinoButton(
                      color: purp,
                      padding: EdgeInsets.only(
                          top: 3,
                          bottom: 3,
                          left: (screenWidth / 2 - 55.5),
                          right: (screenWidth / 2 - 55.5)),
                      onPressed: () {
                        String inputText = inputController.text;
                        if (!_isValidInput(inputText)) {
                          _showErrorDialog(context, 'Invalid input. Please enter a valid amount.');
                          return;
                        }
                          
                        double inputAmount = double.parse(inputText.replaceAll('\$', ''));
                        if (!false && inputAmount > balance) {
                          _showErrorDialog(context, 'Insufficient funds. Please enter a smaller amount.');
                          return;
                        }
                        setState(() {
                          inputController.text = "";
                          updateDataMap(inputAmount);
                        });
                      },
                      child: Text('Withdraw',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateDataMap(double change) {
    setState(() {
      balance = balance - change;
    });
  }

  bool _isValidInput(String input) {
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