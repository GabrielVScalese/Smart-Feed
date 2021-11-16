import 'package:animated_card/animated_card.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/charts/simple_bar_chart.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/models/consumption.dart';
import 'package:project/utils/app_colors.dart';
import 'package:pie_chart/pie_chart.dart' as pc;

class ChartsPage extends StatefulWidget {
  List<Consumption> consumptions;
  ChartsPage({this.consumptions});

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  var appColors;

  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadTheme().then((data) {});
  }

  List<Consumption> handleWeekConsumptions() {
    var now = DateTime.now();
    var min = now.subtract(Duration(days: 7));
    List<Consumption> weekConsumption = [];

    for (var consumption in this.widget.consumptions)
      if (consumption.getDate().isAfter(min) &&
          consumption.getDate().isBefore(now)) weekConsumption.add(consumption);

    return weekConsumption;
  }

  Map<String, double> handlePeriodConsumptions() {
    // Madrugada -  0:00 - 4:59
    // Manhã -  5:00 - 11:59
    // Tarde -  12:00 - 18:59
    // Noite -  19:00 - 23:59
    Map periodConsumption = {};
    double dawnCount = 0;
    double morningCount = 0;
    double afternoonCount = 0;
    double nightCount = 0;

    for (var consumption in this.widget.consumptions) {
      if (consumption.getDate().hour >= 0 && consumption.getDate().hour < 5)
        dawnCount++;
      else if (consumption.getDate().hour >= 5 &&
          consumption.getDate().hour < 12)
        morningCount++;
      else if (consumption.getDate().hour >= 12 &&
          consumption.getDate().hour < 19)
        afternoonCount++;
      else if (consumption.getDate().hour >= 19 &&
          consumption.getDate().hour < 24) nightCount++;
    }

    periodConsumption = {
      'Madrugada': dawnCount,
      'Manhã': morningCount,
      'Tarde': afternoonCount,
      'Noite': nightCount
    };
    return periodConsumption;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var labelStyle = GoogleFonts.inter(
        fontSize: size.width * 0.05,
        color: appColors.textColor(),
        fontWeight: FontWeight.w500);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: appColors.backgroundColor(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleCard(
                        size: size,
                        icon: Icon(
                          Icons.arrow_back,
                          color: appColors.iconButtonColor(),
                          size: size.height * 0.03,
                        ),
                        color: appColors.cardColor(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.06),
                        child: PageTitle(
                          size: size,
                          title: 'Dados de consumo',
                          color: appColors.textColor(),
                        ),
                      ),
                      SizedBox(height: size.width * 0.06),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.06),
                        child: Text(
                          'Dias de consumo',
                          style: labelStyle,
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      Center(
                        child: Card(
                          color: appColors.cardColor(),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.025),
                            height: size.width * 0.6,
                            width: size.width * 0.9,
                            child: SimpleBarChart(
                                animate: true,
                                consumptions: handleWeekConsumptions()),
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.06),
                        child: Text(
                          'Períodos de consumo',
                          style: labelStyle,
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              color: appColors.cardColor(),
                              elevation: 10,
                              child: Container(
                                  height: size.width * 0.54,
                                  width: size.width * 0.54,
                                  child: pc.PieChart(
                                    dataMap: handlePeriodConsumptions(),
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: [
                                      Colors.blue,
                                      Colors.green,
                                      Colors.yellow,
                                      Colors.red
                                    ],
                                    initialAngleInDegree: 0,
                                    chartType: pc.ChartType.ring,
                                    ringStrokeWidth: 32,
                                    centerText: "HYBRID",
                                    legendOptions: pc.LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: pc.LegendPosition.right,
                                      showLegends: true,
                                      legendShape: BoxShape.circle,
                                    ),
                                    chartValuesOptions: pc.ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                    // gradientList: ---To add gradient colors---
                                    // emptyColorGradient: ---Empty Color gradient---
                                  )),
                            ),
                            Column(
                              children: [
                                Card(
                                  color: appColors.cardColor(),
                                  elevation: 10,
                                  child: Container(
                                    height: size.width * 0.26,
                                    width: size.width * 0.26,
                                  ),
                                ),
                                Card(
                                  color: appColors.cardColor(),
                                  elevation: 10,
                                  child: Container(
                                    height: size.width * 0.26,
                                    width: size.width * 0.26,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
