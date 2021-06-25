import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key key, @required this.size, @required this.text})
      : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size.height * 0.053,
      width: size.width * 0.9,
      child: Text(
        text,
        style:
            GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 153, 255, 1),
          borderRadius: BorderRadius.all(Radius.circular(30))),
    );
  }
}
