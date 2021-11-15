import 'package:intl/intl.dart';

class Consumption {
  DateTime _date;
  int _quantity;

  Consumption(
    this._date,
    this._quantity,
  );

  DateTime getDate() {
    return this._date;
  }

  int getQuantity() {
    return this._quantity;
  }

  Map<String, dynamic> toMap() {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");

    String convertedDate = dateFormat.format(_date);
    return {
      'date': convertedDate,
      'quantity': _quantity,
    };
  }

  factory Consumption.fromMap(Map<String, dynamic> map) {
    return Consumption(
      DateTime.parse((map['date'])),
      map['quantity'],
    );
  }
}
