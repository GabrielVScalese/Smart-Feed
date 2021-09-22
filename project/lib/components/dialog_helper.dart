import 'package:flutter/material.dart';
import 'package:project/components/mode_dialog.dart';
import 'package:project/components/password_dialog.dart';
import 'package:project/components/quantity_dialog.dart';
import 'package:project/components/schedule_dialog.dart';
import 'package:project/pages/configurations/confirm_password_page.dart';
import 'info_dialog.dart';

class DialogHelper {
  static chooseMode(context) =>
      showDialog(context: context, builder: (context) => ModeDialog());

  static setQuantity(context) =>
      showDialog(context: context, builder: (context) => QuantityDialog());

  static setSchedule(context, schedules) => showDialog(
      context: context,
      builder: (context) => ScheduleDialog(schedules: schedules));

  static infoModal(context) =>
      showDialog(context: context, builder: (context) => InfoDialog());

  static confirmPassword(context) =>
      showDialog(context: context, builder: (context) => PasswordDialog());
}
