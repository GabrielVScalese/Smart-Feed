import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controllers/feed_controller.dart';

class ModeDialog extends StatefulWidget {
  FeedController feedController;

  ModeDialog({this.feedController});
  @override
  _ModeDialogState createState() => _ModeDialogState();
}

// Ainda nao esta responsivo
class _ModeDialogState extends State<ModeDialog> {
  bool schedulesEnabled;
  bool aproximationEnabled;

  Color schedulesColor = Color.fromRGBO(237, 237, 237, 1);
  Color aproximationColor;

  List explanations = [
    'Despeja a ração utilizando os horários determinados.',
    'Despeja a ração quando seu pet se aproxima do dispositivo.'
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      schedulesEnabled =
          this.widget.feedController.getMode() == 'Horário' ? true : false;
      aproximationEnabled =
          this.widget.feedController.getMode() == 'Aproximação' ? true : false;
      changeColors();
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  void changeColors() {
    setState(() {
      if (schedulesEnabled) {
        schedulesColor = Color.fromRGBO(237, 237, 237, 1);
      } else {
        schedulesColor = Colors.white;
      }

      if (aproximationEnabled) {
        aproximationColor = Color.fromRGBO(237, 237, 237, 1);
      } else {
        aproximationColor = Colors.white;
      }
    });
  }

  String changeText() {
    if (schedulesEnabled)
      return explanations[0];
    else if (aproximationEnabled) return explanations[1];

    return explanations[0];
  }

  _buildChild(BuildContext context) => Container(
        height: 293,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Align(
              child: Text(
                'Modo de Alimentação',
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 23,
            ),
            GestureDetector(
                onTap: () {
                  if (schedulesEnabled == true) aproximationEnabled = true;

                  this.widget.feedController.changeMode('Horário');
                  schedulesEnabled = !schedulesEnabled;
                  aproximationEnabled = !schedulesEnabled;
                  changeColors();
                },
                child: Align(
                  child: OptionCard(Icon(Icons.schedule, size: 30), 'Horário',
                      schedulesColor),
                )),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  if (aproximationEnabled == true) schedulesEnabled = true;

                  this.widget.feedController.changeMode('Aproximação');
                  aproximationEnabled = !aproximationEnabled;
                  schedulesEnabled = !aproximationEnabled;
                  changeColors();
                },
                child: Align(
                  child: OptionCard(
                      Icon(Icons.center_focus_strong_outlined, size: 30),
                      'Aproximação',
                      aproximationColor),
                )),
            SizedBox(
              height: 22,
            ),
            Visibility(
                visible:
                    schedulesEnabled == true || aproximationEnabled == true,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 33),
                  alignment: Alignment.topLeft,
                  child: Text(
                    changeText(),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ))
          ],
        ),
      );
}

class OptionCard extends StatefulWidget {
  Icon icon;
  String title;
  Color backgroundColor;

  OptionCard(this.icon, this.title, this.backgroundColor);

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.widget.backgroundColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 5),
        height: 50,
        width: 250,
        child: Row(
          children: [
            this.widget.icon,
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(this.widget.title,
                    style: GoogleFonts.inter(
                        fontSize: 19, fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
