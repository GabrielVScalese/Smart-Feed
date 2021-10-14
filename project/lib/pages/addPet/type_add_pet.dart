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
import 'package:project/utils/app_colors.dart';

class TypeAddPet extends StatefulWidget {
  @override
  _TypeAddPetState createState() => _TypeAddPetState();
}

class _TypeAddPetState extends State<TypeAddPet> {
  var appColors;

  loadTheme() async {
    this.appColors = new AppColors();
    await this.appColors.initialize();

    setState(() {});
  }

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

  decideTitle() {
    var arguments = _getArguments() as List;

    if (arguments.length == 6) return 'Editando Pet';

    return 'Novo Pet';
  }

  @override
  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});
    super.initState();
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
          color: appColors.iconButtonColor(),
        )
      },
      {
        'name': 'Gato',
        'icon': Icon(
          Icons.pets,
          color: appColors.iconButtonColor(),
          size: size.height * 0.12,
        )
      }
    ];

    CardChangerController cardChangerController = CardChangerController();
    cardChangerController.setValue({'value': optionList[0]['name']});

    return Scaffold(
      body: Container(
        color: appColors.backgroundColor(),
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
                            color: appColors.iconButtonColor(),
                            size: size.height * 0.03,
                          ),
                          color: appColors.cardColor()),
                    ),
                    Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '1/5',
                              style: GoogleFonts.inter(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: appColors.iconButtonColor()),
                            ),
                            width: size.width * 0.14,
                            height: size.width * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: appColors.cardColor(),
                            )))
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
                      PageTitle(
                        size: size,
                        title: decideTitle(),
                        color: appColors.textColor(),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Cão ou gato.',
                          style: GoogleFonts.inter(
                              fontSize: size.width * 0.045,
                              color: appColors.descriptionTextColor()))
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
                          color: appColors.descriptionTextColor())),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      var arguments = _getArguments() as List;

                      if (arguments.length > 1) {
                        arguments[0] = cardChangerController.getValue();
                      } else {
                        arguments = [];
                        arguments.add(cardChangerController.getValue());
                      }

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SizeAddPet(arguments: arguments)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: CircleCard(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: appColors.iconButtonColor(),
                        ),
                        size: size,
                        color: appColors.cardColor(),
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
