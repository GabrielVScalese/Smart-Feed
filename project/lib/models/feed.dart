import 'package:flutter/material.dart';

class Feed {
  int _petId;
  String _mode;
  int _quantity;
  List<TimeOfDay> _schedules;

  Feed(this._petId, this._mode, this._quantity, this._schedules);

  int getPetId() {
    return this._petId;
  }

  String getMode() {
    return this._mode;
  }

  int getQuantity() {
    return this._quantity;
  }

  List<TimeOfDay> getSchedules() {
    return this._schedules;
  }

  static Feed fromMap(Map<String, dynamic> map) {
    List<TimeOfDay> schedules = [];
    for (String strSchedule in map['schedules']) {
      var parts = strSchedule.split(':');

      schedules.add(
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])));
    }

    return Feed(map['pet_id'], map['mode'], map['quantity'], schedules);
  }

  static Map<String, dynamic> toMap(Feed feed) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = feed.getMode();
    data['quantity'] = feed.getQuantity();
    data['schedules'] = [];

    for (TimeOfDay time in feed.getSchedules()) {
      var hour = time.hour.toString().padLeft(2, '0');
      var minute = time.minute.toString().padLeft(2, '0');
      var stringTime = hour + ':' + minute;

      data['schedules'].add(stringTime);
    }

    return data;
  }
}
