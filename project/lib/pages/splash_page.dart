import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controllers/auth_controller.dart';
import 'package:animated_card/animated_card.dart';
import 'package:project/controllers/theme_controller.dart';
import 'package:project/utils/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

var appColors;

class _SplashPageState extends State<SplashPage> {
  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    var authController = AuthController();
    authController.currentUser(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadTheme().then((data) {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: appColors.backgroundColor(),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedCard(
              direction: AnimatedCardDirection.bottom,
              duration: Duration(seconds: 1, milliseconds: 500),
              child: Container(
                margin: EdgeInsets.only(bottom: size.width * 0.1),
                child: Center(
                    child: Image.asset(
                  'assets/images/logo.png',
                  height: size.height * 0.15,
                  width: size.width * 0.75,
                )),
              ),
            ),
            AnimatedCard(
              duration: Duration(seconds: 1),
              direction: AnimatedCardDirection.bottom,
              child: Align(
                alignment: Alignment(0.0, 0.827),
                child: Text(
                  "from",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: size.width * 0.04,
                      color: appColors.descriptionTextColor(),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            AnimatedCard(
              duration: Duration(seconds: 1),
              direction: AnimatedCardDirection.bottom,
              child: Align(
                alignment: Alignment(0.0, 0.89),
                child: Text(
                  "SMART FEED",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: size.width * 0.05,
                      color: appColors.descriptionTextColor(),
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
