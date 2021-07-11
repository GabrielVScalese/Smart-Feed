import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/carousel.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/controllers/card_changer_controller.dart';

class SizeAddPet extends StatefulWidget {
  @override
  _SizeAddPetState createState() => _SizeAddPetState();
}

class _SizeAddPetState extends State<SizeAddPet> {
  _getArguments() {
    var arguments = ModalRoute.of(context).settings.arguments;

    return arguments;
  }

  _findIndexOf(cardList, value) {
    for (var item in cardList)
      if (item['name'] == value) return cardList.indexOf(item);
  }

  _getInitialPage(cardList) {
    try {
      var arguments = _getArguments() as List;

      return _findIndexOf(cardList, arguments[1]['value']);
    } catch (err) {
      return 0;
    }
  }

  setCardChangerController(cardList) {
    var arguments = _getArguments() as List;

    var cardChangerController = new CardChangerController();
    cardChangerController.setValue({'value': cardList[0]['name']});

    if (arguments.length > 1)
      cardChangerController.setValue({'value': arguments[1]['value']});

    return cardChangerController;
  }

  _insertArgument(cardChangerController) {
    var arguments = _getArguments() as List;

    if (arguments.length > 1)
      arguments[1] = cardChangerController.getValue();
    else
      arguments.add(cardChangerController.getValue());

    return arguments;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var cardList = [
      {
        'name': 'Pequeno',
        'icon': Icon(
          Icons.aspect_ratio,
          size: size.height * 0.12,
        )
      },
      {
        'name': 'Médio',
        'icon': Icon(
          Icons.aspect_ratio,
          size: size.height * 0.12,
        )
      },
      {
        'name': 'Grande',
        'icon': Icon(
          Icons.aspect_ratio,
          size: size.height * 0.12,
        )
      },
    ];

    var cardChangerController = setCardChangerController(cardList);

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
                        var arguments = _insertArgument(cardChangerController);

                        Navigator.of(context).pushReplacementNamed('/type',
                            arguments: arguments);
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
                            child: Text('2/5',
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
                margin: EdgeInsets.only(left: size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(size: size, title: 'Porte'),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text('Pequeno, médio ou grande.',
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.045,
                            color: Color.fromRGBO(125, 125, 125, 1)))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.13,
              ),
              Carousel(
                  size: size,
                  optionlist: cardList,
                  initialPage: _getInitialPage(cardList),
                  controller: cardChangerController),
            ],
          ),
          Align(
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
                    var arguments = _insertArgument(cardChangerController);

                    Navigator.of(context)
                        .pushReplacementNamed('/ration', arguments: arguments);
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
        ]),
      ),
    );
  }
}
