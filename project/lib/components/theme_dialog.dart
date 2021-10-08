import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/controllers/theme_controller.dart';
import 'package:project/pages/configurations/configuration_page.dart';
import 'package:project/utils/app_colors.dart';

class ThemeDialog extends StatefulWidget {
  ThemeDialog();

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

  Color darkCardColor;
  Color brightCardColor;
  var themeController = ThemeController();

  var appColors;

  loadTheme() async {
    this.appColors = new AppColors();
    await this.appColors.initialize();

    changeColors();
    setState(() {});
  }

  @override
  void initState() {
    loadTheme().then((data) {});

    super.initState();
  }

  void changeColors() {
    setState(() {
      try {
        if (appColors.instance) {
          darkCardColor = appColors.modalCardColor();
          brightCardColor = appColors.notSelectedColor();
        } else {
          darkCardColor = appColors.notSelectedColor();
          brightCardColor = appColors.modalCardColor();
        }
      } catch (e) {}
    });
  }

  _buildChild(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ConfigurationPage()));
      },
      child: Container(
        height: size.width * 0.55,
        decoration: BoxDecoration(
            color: appColors.backgroundColorModal(),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            Align(
              child: Text(
                "Selecione o tema",
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: appColors.textColor()),
              ),
            ),
            SizedBox(height: size.width * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    appColors.setDarkTheme(false);
                    changeColors();
                    await themeController.setTheme(appColors.instance);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ConfigurationPage()));

                    setState(() {});
                  },
                  child: RectangleCard(
                    size: size,
                    scale: 100,
                    icon: Icon(
                      Icons.brightness_low,
                      size: size.width * 0.09,
                      color: appColors.iconButtonColor(),
                    ),
                    content: "Claro",
                    backgroundColor: brightCardColor,
                    contentColor: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    appColors.setDarkTheme(true);
                    changeColors();
                    await themeController.setTheme(appColors.instance);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ConfigurationPage()));

                    setState(() {});
                  },
                  child: RectangleCard(
                      size: size,
                      scale: 100,
                      icon: Icon(
                        Icons.brightness_2,
                        size: size.width * 0.09,
                        color: appColors.iconButtonColor(),
                      ),
                      content: "Escuro",
                      backgroundColor: darkCardColor,
                      contentColor: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
