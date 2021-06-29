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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Center(
            child: Text(
              "A melhor e mais fácil maneira de cuidar do seu pet",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: size.width * 0.065, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
