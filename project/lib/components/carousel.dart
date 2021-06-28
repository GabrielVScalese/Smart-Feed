import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/controllers/card_changer_controller.dart';

class Carousel extends StatelessWidget {
  Carousel({Key key, this.size, this.cardList, this.controller});

  final Size size;
  final List<Map> cardList;
  CardChangerController controller;

  @override
  Widget build(BuildContext context) {
    var cardSliders = cardList
        .map((item) => RectangleCard(
            size: size,
            scale: size.height * 0.25,
            icon: item['icon'],
            content: item['name']))
        .toList();

    return Column(
      children: [
        Container(
          width: size.width * 1,
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (int index, CarouselPageChangedReason c) {
                controller.setValue(cardList[index]);
              },
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
    );
  }
}
