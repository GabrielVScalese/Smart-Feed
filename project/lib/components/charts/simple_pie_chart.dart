/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/models/consumption.dart';

class SimplePieChart extends StatelessWidget {
  final bool animate;
  final List<Map> consumptionPeriods;

  SimplePieChart({this.animate, this.consumptionPeriods});

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      _createSampleData(),
      animate: animate,
      behaviors: [
        new charts.DatumLegend(
          desiredMaxRows: 2,
        )
      ],
    );
  }

  List<charts.Series<Map, String>> _createSampleData() {
    return [
      new charts.Series<Map, String>(
        id: 'Consumptions',
        domainFn: (Map period, _) => period['period'],
        measureFn: (Map period, _) => period['counter'],
        data: consumptionPeriods,
      )
    ];
  }
}

String convertDate(String dateString) {
  var date = DateTime.parse(dateString);
  var convertedDate = '';
  convertedDate += DateFormat.d().format(date).padLeft(2, '0');
  convertedDate += '/' + DateFormat.M().format(date).padLeft(2, '0');

  return convertedDate;
}
