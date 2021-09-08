import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({Key key}) : super(key: key);

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
    return Container(
        height: size.height * 0.50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            Align(
              child: Text(
                "Recomendação por dia",
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  top: size.width * 0.03,
                  bottom: size.width * 0.02),
              child: Text(
                'Filhotes',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InformationCard(
                  size: size,
                  title: "Cão",
                  content: "4 vezes",
                  value: 130,
                ),
                InformationCard(
                  size: size,
                  title: "Gato",
                  content: "4 vezes",
                  value: 50,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  top: size.width * 0.03,
                  bottom: size.width * 0.02),
              child: Text(
                'Jovens ou adultos',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.04,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InformationCard(
                  size: size,
                  title: "Cão",
                  content: "2 vezes",
                  value: 200,
                ),
                InformationCard(
                  size: size,
                  title: "Gato",
                  content: "2 vezes",
                  value: 100,
                ),
              ],
            ),
          ],
        ));
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard(
      {Key key,
      @required this.size,
      @required this.title,
      @required this.content,
      @required this.value})
      : super(key: key);

  final Size size;
  final String title;
  final String content;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: size.height * 0.145,
        width: size.height * 0.13,
        padding: EdgeInsets.only(
          left: size.width * 0.03,
          top: size.width * 0.03,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: size.width * 0.043, fontWeight: FontWeight.bold)),
          SizedBox(
            height: size.height * 0.020,
          ),
          Text(content,
              style: GoogleFonts.inter(
                fontSize: size.width * 0.04,
              )),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              Text(value.toString(),
                  style: GoogleFonts.inter(
                      fontSize: size.width * 0.037,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text('gramas',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.035,
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
