import 'package:intl/intl.dart';

class Statistics {
  Map _greaterConsumption;
  Map _smallerConsumption;
  int _consumptionAverage;
  int _diffDays;

  int getGreaterConsumption() {
    return this._greaterConsumption['quantity'];
  }

  int getSmallerConsumption() {
    return this._smallerConsumption['quantity'];
  }

  String getGreaterDate() {
    return this._greaterConsumption['date'];
  }

  String getSmallerDate() {
    return this._smallerConsumption['date'];
  }

  int getConsumptionAverage() {
    return this._consumptionAverage;
  }

  int getDiffDays() {
    return this._diffDays;
  }

  Statistics(this._greaterConsumption, this._smallerConsumption,
      this._consumptionAverage, this._diffDays);

  factory Statistics.fromMap(Map<String, dynamic> map) {
    Map greaterConsumption = {
      'date': convertDate(map['greaterConsumption']['date']),
      'quantity': map['greaterConsumption']['quantity']
    };
    Map smallerConsumption = {
      'date': convertDate(map['smallerConsumption']['date']),
      'quantity': map['smallerConsumption']['quantity']
    };
    int consumptionAverage = map['consumptionAverage'].round();
    int diffDays = map['diffDays'];

    return Statistics(
        greaterConsumption, smallerConsumption, consumptionAverage, diffDays);
  }
}

String convertDate(String dateString) {
  var date = DateTime.parse(dateString);
  var convertedDate = '';
  convertedDate += DateFormat.d().format(date).padLeft(2, '0');
  convertedDate += '/' + DateFormat.M().format(date).padLeft(2, '0');
  convertedDate += '/' + DateFormat.y().format(date);

  return convertedDate;
}
