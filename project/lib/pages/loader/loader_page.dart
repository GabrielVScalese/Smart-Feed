import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoaderPage extends StatelessWidget {
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0.0, -0.1),
            child: Container(
              child: Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.15,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 0.1),
            child: JumpingDotsProgressIndicator(
              fontSize: 100,
              color: Color.fromRGBO(0, 153, 255, 1),
            ),
          ),
        ],
      ),
    ));
  }
}
