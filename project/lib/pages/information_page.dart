import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/circle_image.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/dialog_helper.dart';
import 'package:project/components/panel_widget.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/models/feed.dart';
import 'package:project/pages/addPet/type_add_pet.dart';
import 'package:project/repositories/pets_repository.dart';

import 'home_page.dart';

class InformationPage extends StatefulWidget {
  var pet;
  Feed feed;
  InformationPage({this.pet, this.feed});

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  var _devices = ['Smart Feed UHG78F'];
  // Fazer tamanho máximo e tamanho mínimo; colocar arrow back card
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var labelStyle = GoogleFonts.inter(
        fontSize: size.width * 0.05,
        color: Colors.black,
        fontWeight: FontWeight.w500);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.top,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(this.widget.pet.getName(),
                              style: GoogleFonts.inter(
                                  fontSize: size.width * 0.08,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text('Informações',
                              style: GoogleFonts.inter(
                                  fontSize: size.width * 0.05,
                                  color: Color.fromRGBO(125, 125, 125, 1)))
                        ],
                      ),
                    ),
                    CircleImage(
                      scale: size.height * 0.1,
                      srcImage: this.widget.pet.getImage(),
                      margin: EdgeInsets.only(right: size.width * 0.07),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.036,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.06),
                  child: Text(
                    'Dispositivo',
                    style: labelStyle,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: size.width * 0.03, right: size.width * 0.02),
                      width: size.width * 0.9,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            iconDisabledColor: Colors.black,
                            value: 'Smart Feed UHG78F',
                            items: _devices
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                        fontSize: size.width * 0.04,
                                        color:
                                            Color.fromRGBO(125, 125, 125, 1)),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String value) {
                              setState(() {});
                            }),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => TypeAddPet(),
                      ),
                    );
                  },
                  child: LabelRow(
                    size: size,
                    labelStyle: labelStyle,
                    principalText: 'Características',
                    secondaryText: 'Editar',
                    icon: Icons.edit,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RectangleCard(
                          size: size,
                          icon: Icon(
                            Icons.pets,
                            size: size.height * 0.053,
                          ),
                          scale: size.height * 0.13,
                          content: this.widget.pet.getAnimal()),
                      RectangleCard(
                        size: size,
                        icon: Icon(Icons.restaurant_menu,
                            size: size.height * 0.053),
                        scale: size.height * 0.13,
                        content: this.widget.pet.getRation(),
                      ),
                      RectangleCard(
                          size: size,
                          icon: Icon(Icons.aspect_ratio,
                              size: size.height * 0.053),
                          scale: size.height * 0.13,
                          content: this.widget.pet.getSize()),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.06),
                  child: Text(
                    'Alimentação',
                    style: labelStyle,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          DialogHelper.chooseMode(context);
                        },
                        child: RectangleCard(
                          size: size,
                          icon: Icon(
                            Icons.dehaze,
                            size: size.height * 0.053,
                          ),
                          scale: size.height * 0.13,
                          content: 'Modo',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          DialogHelper.setQuantity(context);
                        },
                        child: RectangleCard(
                          size: size,
                          icon: Icon(Icons.local_restaurant,
                              size: size.height * 0.053),
                          scale: size.height * 0.13,
                          content: 'Quantidade',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          DialogHelper.setSchedule(
                              context, this.widget.feed.getSchedules());
                        },
                        child: RectangleCard(
                          size: size,
                          icon: Icon(Icons.schedule, size: size.height * 0.053),
                          scale: size.height * 0.13,
                          content: 'Horários',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: LabelRow(
                  size: size,
                  labelStyle: labelStyle,
                  principalText: 'Consumo',
                  secondaryText: 'Ver gráfico',
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InformationCard(
                        size: size,
                        title: 'Média',
                        content: 'Após 15 dias',
                        value: 206,
                      ),
                      InformationCard(
                        size: size,
                        title: 'Máximo',
                        content: '24/02/201',
                        value: 300,
                      ),
                      InformationCard(
                        size: size,
                        title: 'Mínimo',
                        content: '14/06/2021',
                        value: 150,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Align(
                alignment: Alignment(0.92, 0.95),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Excluir',
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.042,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      onTap: () async {
                        try {
                          DialogBuilder(context).showLoadingIndicator();

                          var petsRepository = new PetsRepository();
                          var statusCode = await petsRepository
                              .destroy(this.widget.pet.getId());

                          if (statusCode == 200)
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          else {
                            print('Error');
                            DialogBuilder(context).hideOpenDialog();
                          }
                        } catch (err) {
                          print(err.toString());
                          DialogBuilder(context).hideOpenDialog();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 0.05),
                        child: CircleCard(
                          icon: Icon(Icons.delete, color: Colors.red),
                          size: size,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.016)),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  const LabelRow(
      {Key key,
      @required this.size,
      @required this.labelStyle,
      @required this.principalText,
      this.icon,
      @required this.secondaryText})
      : super(key: key);

  final Size size;
  final TextStyle labelStyle;
  final String principalText;
  final String secondaryText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            principalText,
            style: labelStyle,
          ),
          Row(
            children: [
              Text(
                secondaryText,
                style: GoogleFonts.inter(color: Color.fromRGBO(42, 48, 101, 1)),
              ),
              SizedBox(width: size.width * 0.02),
              Visibility(
                visible: icon != null ? true : false,
                child: Icon(icon,
                    size: size.width * 0.05,
                    color: Color.fromRGBO(42, 48, 101, 1)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Para dados de consumo
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
        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
      ),
      child: Container(
        height: size.height * 0.16,
        width: size.height * 0.13,
        padding: EdgeInsets.only(
          left: size.width * 0.03,
          top: size.width * 0.04,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: size.width * 0.043, fontWeight: FontWeight.bold)),
          SizedBox(
            height: size.height * 0.027,
          ),
          Text(content,
              style: GoogleFonts.inter(
                fontSize: size.width * 0.03,
              )),
          SizedBox(
            height: size.height * 0.024,
          ),
          Row(
            children: [
              Text(value.toString(),
                  style: GoogleFonts.inter(
                      fontSize: size.width * 0.043,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text('kcal',
                  style: GoogleFonts.inter(
                    fontSize: size.width * 0.037,
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
