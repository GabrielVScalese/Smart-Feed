import 'package:flutter/material.dart';

class FeedController with ChangeNotifier {
  String _mode;
  int _quantity;
  List<TimeOfDay> _schedules;

  FeedController(this._mode, this._quantity, this._schedules);

  getMode() {
    return this._mode;
  }

  getQuantity() {
    return this._quantity;
  }

  getSchedules() {
    return this._schedules;
  }

  changeMode(mode) {
    this._mode = mode;

    if (mode == 'Aproximação') this._schedules = [];

    notifyListeners();
  }

  changeQuantity(quantity) {
    this._quantity = quantity;
    notifyListeners();
  }

  changeSchedules(schedules) {
    this._schedules = schedules;
    notifyListeners();
  }
}
