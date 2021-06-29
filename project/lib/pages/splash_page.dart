import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/controllers/auth_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    var size = MediaQuery.of(context).size;
    authController.currentUser(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: size.width * 0.1),
              child: Center(
                  child: Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.15,
                width: size.width * 0.75,
              )),
            ),
            Align(
              alignment: Alignment(0.0, 0.827),
              child: Text(
                "from",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.04,
                    color: Color.fromRGBO(125, 125, 125, 1),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.89),
              child: Text(
                "SMART FEED",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.05,
                    color: Color.fromRGBO(125, 125, 125, 1),
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
