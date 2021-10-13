import 'package:flutter/material.dart';
import 'package:project/controllers/theme_controller.dart';

class AppColors {
  bool darkTheme = false;

  AppColors();

  bool get instance => darkTheme;

  void initialize() async {
    var themeController = ThemeController();
    this.darkTheme = await themeController.getTheme();
  }

  void setDarkTheme(bool darkTheme) {
    this.darkTheme = darkTheme;
  }

  Color backgroundColor() {
    return this.darkTheme ? Colors.black : Colors.white;
  }

  Color textColor() {
    return this.darkTheme ? Colors.white : Colors.black;
  }

  Color descriptionTextColor() {
    return Color.fromRGBO(125, 125, 125, 1);
  }

  Color buttonColor() {
    return this.darkTheme
        ? Color.fromRGBO(0, 153, 255, 1)
        : Color.fromRGBO(0, 153, 255, 1);
  }

  Color errorColor() {
    return Colors.redAccent;
  }

  Color notSelectedColor() {
    return Colors.white;
  }

  Color inputTextColor() {
    return Color.fromRGBO(186, 184, 184, 1);
  }

  Color seeMoreColor() {
    return Colors.blueAccent;
  }

  Color iconColor() {
    return Colors.black;
  }

  Color starsColor() {
    return Colors.blue;
  }

  Color shimmerHighlightColor() {
    return Colors.grey[300];
  }

  Color shimmerBaseColor() {
    return Colors.grey[300];
  }

  Color labelColor() {
    return Color.fromRGBO(140, 138, 138, 1);
  }

  Color toLoginColor() {
    return Color.fromRGBO(0, 119, 199, 1);
  }

  Color cameraIconColor() {
    return Color.fromRGBO(144, 143, 143, 1);
  }

  Color deleteColor() {
    return Colors.red;
  }

  Color successfulColor() {
    return Colors.green;
  }

  Color starNotSelectedColor() {
    return Color(0xFFe6e6e6);
  }

  Color boxShadowColor() {
    return this.darkTheme ? Colors.grey[700] : Colors.grey;
  }

  Color schedulesDeactivatedColor() {
    return Color(0xFFC4C4C4);
  }

  Color secondaryTextColor() {
    return Color.fromRGBO(42, 48, 101, 1);
  }

  Color buttonBackgroundColor() {
    return this.darkTheme ? Color(0xFF65686B) : Colors.white;
  }

  Color configurationIconColor() {
    return this.darkTheme ? Colors.grey[700] : Colors.black;
  }

  Color cardColor() {
    return this.darkTheme ? Colors.grey[900] : Colors.white;
  }

  Color iconButtonColor() {
    return this.darkTheme ? Color(0xFF65686B) : Colors.black;
  }

  Color backgroundColorModal() {
    return this.darkTheme ? Colors.grey[900] : Colors.white;
  }

  Color modalCardColor() {
    return this.darkTheme ? Colors.grey[500] : Colors.grey[300];
  }
}
