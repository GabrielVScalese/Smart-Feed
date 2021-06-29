import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key key, @required this.size, @required this.title})
      : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
          fontSize: size.width * 0.07, fontWeight: FontWeight.bold),
    );
  }
}
