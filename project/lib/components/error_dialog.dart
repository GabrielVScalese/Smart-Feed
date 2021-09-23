import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rounded_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(
      {Key key,
      @required this.title,
      @required this.message,
      @required this.icon})
      : super(key: key);

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.width * 0.69,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.width * 0.05,
            ),
            Icon(
              icon,
              size: size.width * 0.15,
              color: Colors.redAccent,
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Text(title,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, fontSize: size.width * 0.05)),
            SizedBox(
              height: size.width * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.035,
                ),
              ),
            ),
            SizedBox(
              height: size.width * 0.075,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: RoundedButton(
                height: size.width * 0.1,
                width: size.width * 0.45,
                radius: 10,
                text: 'OK',
                backgroundColor: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
