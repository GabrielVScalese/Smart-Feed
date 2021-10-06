import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/controllers/theme_controller.dart';

class ThemeDialog extends StatefulWidget {
  bool darkTheme;
  ThemeDialog({this.darkTheme});

  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  var darkEnabled = false;
  Color darkCardColor = Colors.white;
  Color brightCardColor = Colors.white;
  var themeController = ThemeController();

  @override
  void initState() {
    darkEnabled = this.widget.darkTheme;
    changeColors();
    super.initState();
  }

  void changeColors() {
    setState(() {
      if (darkEnabled) {
        darkCardColor = Color.fromRGBO(237, 237, 237, 1);
      } else {
        darkCardColor = Colors.white;
      }

      if (!darkEnabled) {
        brightCardColor = Color.fromRGBO(237, 237, 237, 1);
      } else {
        brightCardColor = Colors.white;
      }
    });
  }

  _buildChild(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.width * 0.55,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.03),
          Align(
            child: Text(
              "Selecione o tema",
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: size.width * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  darkEnabled = false;
                  changeColors();
                  await themeController.setTheme(darkEnabled);

                  setState(() {});
                },
                child: RectangleCard(
                  size: size,
                  scale: 100,
                  icon: Icon(
                    Icons.brightness_low,
                    size: size.width * 0.09,
                  ),
                  content: "Claro",
                  backgroundColor: brightCardColor,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  darkEnabled = true;
                  changeColors();
                  await themeController.setTheme(darkEnabled);

                  setState(() {});
                },
                child: RectangleCard(
                  size: size,
                  scale: 100,
                  icon: Icon(
                    Icons.brightness_2,
                    size: size.width * 0.09,
                  ),
                  content: "Escuro",
                  backgroundColor: darkCardColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
