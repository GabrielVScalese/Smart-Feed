import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/controllers/card_changer_controller.dart';
import 'package:project/utils/app_colors.dart';

class Carousel extends StatefulWidget {
  Carousel(
      {Key key, this.size, this.optionlist, this.initialPage, this.controller});

  final Size size;
  final List<Map> optionlist;
  final int initialPage;
  CardChangerController controller;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  var appColors;
  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cardSliders = widget.optionlist
        .map(
          (item) => RectangleCard(
            size: widget.size,
            scale: widget.size.height * 0.25,
            icon: item['icon'],
            content: item['name'],
            contentColor: appColors.textColor(),
            backgroundColor: appColors.cardColor(),
          ),
        )
        .toList();

    return Column(
      children: [
        Container(
          width: widget.size.width * 1,
          child: CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (int index, CarouselPageChangedReason c) {
                widget.controller
                    .setValue({'value': widget.optionlist[index]['name']});
              },
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              initialPage: widget.initialPage,
              autoPlay: false,
            ),
            items: cardSliders,
          ),
        ),
        SizedBox(
          height: widget.size.height * 0.03,
        ),
        Text('Deslize para trocar',
            style: GoogleFonts.inter(
                fontSize: widget.size.width * 0.04,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(125, 125, 125, 1)))
      ],
    );
  }
}
