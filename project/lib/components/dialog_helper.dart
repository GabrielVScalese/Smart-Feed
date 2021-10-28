import 'package:flutter/material.dart';
import 'package:project/components/error_dialog.dart';
import 'package:project/components/mode_dialog.dart';
import 'package:project/components/password_dialog.dart';
import 'package:project/components/quantity_dialog.dart';
import 'package:project/components/schedule_dialog.dart';
import 'package:project/components/theme_dialog.dart';
import 'info_dialog.dart';

class DialogHelper {
  static chooseMode(context, feedController) => showDialog(
      context: context,
      builder: (context) => ModeDialog(feedController: feedController));

  static setQuantity(context, feedController) => showDialog(
      context: context,
      builder: (context) => QuantityDialog(feedController: feedController));

  static setSchedule(context, feedController) => showDialog(
      context: context,
      builder: (context) => ScheduleDialog(feedController: feedController));

  static infoModal(context) =>
      showDialog(context: context, builder: (context) => InfoDialog());

  static confirmPassword(context) => showDialog(
      context: context,
      builder: (context) => PasswordDialog(),
      barrierColor: null);

  static errorModal(context, title, message, icon, iconColor, buttonColor) =>
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                title: title,
                message: message,
                icon: icon,
                iconColor: iconColor,
                buttonColor: buttonColor,
              ));

  static themeModal(context) => showDialog(
        context: context,
        builder: (context) => ThemeDialog(),
      );
}
