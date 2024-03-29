import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RectangleCard extends StatelessWidget {
  const RectangleCard(
      {Key key,
      @required this.size,
      @required this.scale,
      @required this.icon,
      @required this.content,
      @required this.backgroundColor,
      @required this.contentColor})
      : super(key: key);

  final Size size;
  final double scale;
  final Icon icon;
  final String content;
  final Color backgroundColor;
  final Color contentColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.backgroundColor,
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: backgroundColor, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: scale,
        width: scale,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Visibility(
              visible: content != '' ? true : false,
              child: SizedBox(
                height: scale * 0.1,
              ),
            ),
            Visibility(
              visible: content != '' ? true : false,
              child: Text(content,
                  style: GoogleFonts.inter(
                      fontSize: scale * 0.14,
                      fontWeight: FontWeight.bold,
                      color: contentColor)),
            ),
          ],
        ),
      ),
    );
  }
}
