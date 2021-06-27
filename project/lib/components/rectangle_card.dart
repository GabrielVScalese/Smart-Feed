import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RectangleCard extends StatelessWidget {
  const RectangleCard({
    Key key,
    @required this.size,
    @required this.icon,
    @required this.content,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: size.height * 0.13,
        width: size.height * 0.13,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: size.height * 0.05,
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            Text(content,
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.04, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
