import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/rectangle_card.dart';

import 'circle_card.dart';

class AddPetStructure extends StatelessWidget {
  const AddPetStructure(
      {Key key,
      @required this.size,
      @required this.title,
      @required this.subTitle,
      @required this.page,
      @required this.cardSliders})
      : super(key: key);

  final Size size;
  final List<RectangleCard> cardSliders;
  final String title;
  final String subTitle;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.06),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleCard(
                      size: size,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: size.height * 0.03,
                      )),
                  Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('$page/5',
                              style: GoogleFonts.inter(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold)),
                          width: size.width * 0.14,
                          height: size.width * 0.14,
                          decoration: BoxDecoration(shape: BoxShape.circle)))
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(size: size, title: title),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(subTitle,
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.04,
                          color: Color.fromRGBO(125, 125, 125, 1)))
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.13,
            ),
            Column(
              children: [
                Container(
                  width: size.width * 1,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      // aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      initialPage: 1,
                      autoPlay: false,
                    ),
                    items: cardSliders,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text('Deslize para trocar',
                    style: GoogleFonts.inter(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(125, 125, 125, 1)))
              ],
            ),
            SizedBox(height: size.height * 0.17),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Próximo',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.042,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: size.width * 0.02),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: CircleCard(
                        icon: Icon(Icons.arrow_forward),
                        size: size,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
