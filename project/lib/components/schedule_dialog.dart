import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/components/rounded_button.dart';

import 'dialog_helper.dart';

class ScheduleDialog extends StatefulWidget {
  List<TimeOfDay> schedules;

  ScheduleDialog({this.schedules});

  @override
  _ScheduleDialogState createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  var scheduleSelected;
  var time = '__:__';

  TimeOfDay getTime(int index) {
    try {
      return this.widget.schedules[index];
    } catch (err) {
      return null;
    }
  }

  String timeToString(TimeOfDay time) {
    if (time == null) return '';

    var hour = time.hour.toString().padLeft(2, '0');
    var minute = time.minute.toString().padLeft(2, '0');
    var stringTime = hour + ':' + minute;

    return stringTime;
  }

  Future<Null> pickTime(BuildContext context, int index) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );

    if (picked != null)
      setState(() {
        time = timeToString(picked);
        try {
          this.widget.schedules[index] = picked;
        } catch (err) {
          this.widget.schedules.add(picked);
        }
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
        height: 390,
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
                    pickTime(context, 0);
                    scheduleSelected = 0;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      getTime(0) != null ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: getTime(0) == null ? '' : timeToString(getTime(0)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    pickTime(context, 1);
                    scheduleSelected = 1;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      getTime(1) != null ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: getTime(1) == null ? '' : timeToString(getTime(1)),
                  ),
                ),
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
                    pickTime(context, 2);
                    scheduleSelected = 2;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      getTime(2) != null ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: getTime(1) == null ? '' : timeToString(getTime(2)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    pickTime(context, 3);
                    scheduleSelected = 3;
                  },
                  child: RectangleCard(
                    icon: Icon(
                      getTime(3) != null ? Icons.alarm_outlined : Icons.add,
                      size: 35,
                    ),
                    scale: 90,
                    content: getTime(3) == null ? '' : timeToString(getTime(3)),
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
