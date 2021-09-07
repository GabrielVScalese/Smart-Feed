import 'package:flutter/material.dart';
import 'package:project/components/mode_dialog.dart';

class DialogHelper {
  static chooseMode(context) =>
      showDialog(context: context, builder: (context) => ModeDialog());
}
