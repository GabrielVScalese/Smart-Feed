/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/models/consumption.dart';

class SimpleBarChart extends StatefulWidget {
  final bool animate;
  final List<Consumption> consumptions;

  SimpleBarChart({this.animate, this.consumptions});

  @override
  _SimpleBarChartState createState() => _SimpleBarChartState();
}

class _SimpleBarChartState extends State<SimpleBarChart> {
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      _createSampleData(),
      animate: widget.animate,
      barRendererDecorator: new charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.outside),
      domainAxis: new charts.OrdinalAxisSpec(),
    );
  }

  List<charts.Series<Consumption, String>> _createSampleData() {
    return [
      new charts.Series<Consumption, String>(
          id: 'Consumptions',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Consumption consumption, _) =>
              convertDate(consumption.getDate().toString()),
          measureFn: (Consumption consumption, _) => consumption.getQuantity(),
          data: widget.consumptions,
          labelAccessorFn: (Consumption consumption, _) =>
              '${consumption.getQuantity()}g'),
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
