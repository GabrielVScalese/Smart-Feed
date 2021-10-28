import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageEmail extends StatelessWidget {
  String message;
  Color color;

  MessageEmail({this.message, this.color});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.15,
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Text(
        message,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
