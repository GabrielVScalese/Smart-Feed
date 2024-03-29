import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.radius,
      @required this.backgroundColor,
      @required this.text})
      : super(key: key);

  final double height;
  final double width;
  final double radius;
  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: this.height,
      width: this.width,
      child: Text(
        text,
        style:
            GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(this.radius))),
    );
  }
}
