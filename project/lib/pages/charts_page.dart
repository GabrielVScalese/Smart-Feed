import 'package:animated_card/animated_card.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/charts/simple_bar_chart.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/models/consumption.dart';
import 'package:project/pages/information_page.dart';
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

  Map<String, double> periodConsumption = {};
  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    handlePeriodConsumptions();
    print(periodConsumption);
    super.initState();
    loadTheme().then((data) {});
  }

  List<Consumption> handleDaysAgo(int daysAgo) {
    var now = DateTime.now();
    var min = now.subtract(Duration(days: daysAgo));
    List<Consumption> weekConsumption = [];

    for (var consumption in this.widget.consumptions)
      if (consumption.getDate().isAfter(min) &&
          consumption.getDate().isBefore(now)) weekConsumption.add(consumption);

    return weekConsumption;
  }

  void handlePeriodConsumptions() {
    // Madrugada -  0:00 - 4:59
    // Manhã -  5:00 - 11:59
    // Tarde -  12:00 - 18:59
    // Noite -  19:00 - 23:59
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
  }

  handleConsumptionTotal(int daysAgo) {
    var total = 0;
    for (var consumption in handleDaysAgo(daysAgo))
      total += consumption.getQuantity();

    return total;
  }

  handleVariation() {
    var twoWeeksAgo = handleConsumptionTotal(14);
    var actualWeek = handleConsumptionTotal(7);

    twoWeeksAgo -= actualWeek;

    return (((actualWeek / twoWeeksAgo) * 100) - 100).round();
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
                          'Últimos 7 dias',
                          style: labelStyle,
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: appColors.cardColor(), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          color: appColors.cardColor(),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.025),
                            height: size.width * 0.6,
                            width: size.width * 0.9,
                            child: SimpleBarChart(
                              animate: true,
                              consumptions: handleDaysAgo(7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.width * 0.05),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ConsumptionCard(
                              size: size,
                              title: 'Consumo',
                              content: "Nos últimos 7 dias",
                              value: handleConsumptionTotal(7),
                            ),
                            ConsumptionCard(
                              size: size,
                              title: 'Variação',
                              content: "2 últimas semanas",
                              value: handleVariation(),
                            ),
                          ],
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
                      Center(
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appColors.cardColor(), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            color: appColors.cardColor(),
                            elevation: 10,
                            child: Container(
                              height: size.width * 0.5,
                              width: size.width * 0.9,
                              child: pc.PieChart(
                                dataMap: periodConsumption,
                                animationDuration: Duration(seconds: 1),
                                chartLegendSpacing: size.width * 0.07,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 2.8,
                                colorList: [
                                  Colors.blue,
                                  Colors.green,
                                  Colors.yellow,
                                  Colors.red
                                ],
                                initialAngleInDegree: 0,
                                chartType: pc.ChartType.disc,
                                ringStrokeWidth: 32,
                                legendOptions: pc.LegendOptions(
                                  legendTextStyle:
                                      appColors.pieChartTextStyle(),
                                  showLegendsInRow: false,
                                  legendPosition: pc.LegendPosition.right,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                ),
                                chartValuesOptions: pc.ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: true,
                                  showChartValuesInPercentage: true,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsumptionCard extends StatelessWidget {
  const ConsumptionCard(
      {Key key,
      @required this.size,
      @required this.title,
      @required this.content,
      @required this.value})
      : super(key: key);

  final Size size;
  final String title;
  final String content;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: appColors.cardColor(), width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: size.height * 0.16,
        width: size.height * 0.215,
        decoration: BoxDecoration(
          color: appColors.cardColor(),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          left: size.width * 0.05,
          top: size.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: appColors.textColor(),
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value.toString(),
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.bold,
                    color: appColors.textColor(),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  title == "Variação" ? '%' : 'g',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.05,
                    color: appColors.textColor(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.width * 0.02,
            ),
            Text(
              content,
              style: GoogleFonts.inter(
                fontSize: size.width * 0.035,
                color: appColors.descriptionTextColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
