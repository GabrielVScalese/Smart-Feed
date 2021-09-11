import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/components/rounded_button.dart';
import 'package:intl/intl.dart';

import 'dialog_helper.dart';

class ScheduleDialog extends StatefulWidget {
  @override
  _ScheduleDialogState createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  List schedules = ['07:30', '12:00', '', ''];
  var scheduleSelected;
  var time = '__:__';

  Future<Null> pickTime(BuildContext context) async {
    var selectedTime;
    var hour;
    var minute;

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        hour = selectedTime.hour.toString().padLeft(2, '0');
        minute = selectedTime.minute.toString().padLeft(2, '0');
        time = hour + ':' + minute;
        schedules[scheduleSelected] = time;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 400,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                Align(
                  child: Text(
                    'Horários',
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    DialogHelper.infoModal(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(Icons.error_outline)),
                )
              ],
            ),
            SizedBox(
              height: 23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickTime(context);
                    scheduleSelected = 0;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      schedules[0] != '' ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: schedules[0],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    pickTime(context);
                    scheduleSelected = 1;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      schedules[1] != '' ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: schedules[1],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    pickTime(context);
                    scheduleSelected = 2;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      schedules[2] != '' ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: schedules[2],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    pickTime(context);
                    scheduleSelected = 3;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      schedules[3] != '' ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: schedules[3],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            RoundedButton(height: 45, width: 220, radius: 10, text: 'APLICAR'),
          ],
        ),
      );
}
