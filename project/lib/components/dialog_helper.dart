import 'package:flutter/material.dart';
import 'package:project/components/mode_dialog.dart';
import 'package:project/components/quantity_dialog.dart';
import 'package:project/components/schedule_dialog.dart';
import 'info_dialog.dart';

class DialogHelper {
  static chooseMode(context) =>
      showDialog(context: context, builder: (context) => ModeDialog());

  static setQuantity(context) =>
      showDialog(context: context, builder: (context) => QuantityDialog());

  static setSchedule(context) =>
      showDialog(context: context, builder: (context) => ScheduleDialog());

  static infoModal(context) =>
      showDialog(context: context, builder: (context) => InfoDialog());
}
