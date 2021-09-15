import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/carousel.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/controllers/card_changer_controller.dart';
import 'package:project/pages/addPet/size_add_pet.dart';
import 'package:project/pages/home_page.dart';

class TypeAddPet extends StatefulWidget {
  var pet;
  TypeAddPet({this.pet});
  @override
  _TypeAddPetState createState() => _TypeAddPetState();
}

class _TypeAddPetState extends State<TypeAddPet> {
  _getArguments() {
    var arguments = ModalRoute.of(context).settings.arguments;

    return arguments;
  }

  _findIndexOf(optionList, value) {
    for (var item in optionList)
      if (item['name'] == value) return optionList.indexOf(item);
  }

  _getInitialPage(cardList) {
    try {
      var arguments = _getArguments() as List;

      return _findIndexOf(cardList, arguments[0]['value']);
    } catch (err) {
      return 0;
    }
  }

  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var optionList = [
      {
        'name': 'Cão',
        'icon': Icon(
          Icons.pets,
          size: size.height * 0.12,
        )
      },
      {
        'name': 'Gato',
        'icon': Icon(
          Icons.pets,
          size: size.height * 0.12,
        )
      }
    ];

    CardChangerController cardChangerController = CardChangerController();
    cardChangerController.setValue({'value': optionList[0]['name']});

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: CircleCard(
                          size: size,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: size.height * 0.03,
                          )),
                    ),
                    Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text('1/5',
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
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageTitle(size: size, title: 'Novo Pet'),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Cão ou gato.',
                          style: GoogleFonts.inter(
                              fontSize: size.width * 0.045,
                              color: Color.fromRGBO(125, 125, 125, 1)))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.13,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Carousel(
                    size: size,
                    optionlist: optionList,
                    initialPage: _getInitialPage(optionList),
                    controller: cardChangerController),
              ),
            ],
          ),
          AnimatedCard(
            direction: AnimatedCardDirection.left,
            child: Align(
              alignment: Alignment(0.92, 0.92),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Próximo',
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      var arguments = _getArguments() as List;

                      if (arguments != null) {
                        arguments[0] = cardChangerController.getValue();
                      } else {
                        arguments = [];
                        arguments.add(cardChangerController.getValue());
                      }

                      Navigator.of(context)
                          .pushReplacementNamed('/size', arguments: arguments);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: CircleCard(
                        icon: Icon(Icons.arrow_forward),
                        size: size,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
