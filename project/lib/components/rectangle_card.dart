import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RectangleCard extends StatelessWidget {
  const RectangleCard({
    Key key,
    @required this.size,
    @required this.scale,
    @required this.icon,
    @required this.content,
  }) : super(key: key);

  final Size size;
  final double scale;
  final Icon icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: scale,
        width: scale,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(
              height: scale * 0.1,
            ),
            Text(content,
                style: GoogleFonts.inter(
                    fontSize: scale * 0.14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
