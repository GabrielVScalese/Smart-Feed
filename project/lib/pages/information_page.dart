import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/circle_image.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/dialog_helper.dart';
import 'package:project/components/rectangle_card.dart';
import 'package:project/controllers/feed_controller.dart';
import 'package:project/models/feed.dart';
import 'package:project/pages/addPet/type_add_pet.dart';
import 'package:project/repositories/feeds_repository.dart';
import 'package:project/repositories/pets_repository.dart';
import 'package:project/utils/app_colors.dart';

import 'home_page.dart';

class InformationPage extends StatefulWidget {
  var pet;
  Feed feed;
  InformationPage({this.pet, this.feed});

  @override
  _InformationPageState createState() => _InformationPageState();
}

var appColors;

class _InformationPageState extends State<InformationPage> {
  var _devices = ['Smart Feed UHG78F'];

  var feedController;

  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    loadTheme().then((data) {});
    feedController = FeedController(this.widget.feed.getMode(),
        this.widget.feed.getQuantity(), this.widget.feed.getSchedules());

    setState(() {
      if (feedController.getMode() == "Horário")
        cardColor = Colors.white;
      else
        cardColor = Color(0xFFC4C4C4);
    });

    super.initState();
  }

  var cardColor;

  void getCardColor() {
    feedController.addListener(() {
      setState(() {
        if (feedController.getMode() == "Horário")
          cardColor = Colors.white;
        else
          cardColor = Color(0xFFC4C4C4);
      });
    });
  }

  // Fazer tamanho máximo e tamanho mínimo; colocar arrow back card
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    getCardColor();

    var labelStyle = GoogleFonts.inter(
        fontSize: size.width * 0.05,
        color: appColors.textColor(),
        fontWeight: FontWeight.w500);

    return WillPopScope(
      onWillPop: () async {
        var feedsRepository = new FeedsRepository();
        var feed = new Feed(this.widget.pet.getId(), feedController.getMode(),
            feedController.getQuantity(), feedController.getSchedules());

        DialogBuilder(context, appColors).showLoadingIndicator();

        var statusCode =
            await feedsRepository.updateByPetId(feed.getPetId(), feed);

        print(statusCode);
        if (statusCode == 200) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          DialogBuilder(context, appColors).hideOpenDialog();
        }
      },
      child: Scaffold(
        body: Container(
          color: appColors.backgroundColor(),
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
                                    fontWeight: FontWeight.bold,
                                    color: appColors.textColor())),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text('Informações',
                                style: GoogleFonts.inter(
                                    fontSize: size.width * 0.05,
                                    color: appColors.descriptionTextColor()))
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
                        side:
                            BorderSide(color: appColors.cardColor(), width: 1),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: appColors.cardColor(),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: EdgeInsets.only(
                            left: size.width * 0.03, right: size.width * 0.02),
                        width: size.width * 0.9,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              iconDisabledColor: Colors.black,
                              dropdownColor: appColors.cardColor(),
                              value: 'Smart Feed UHG78F',
                              items: _devices.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: GoogleFonts.inter(
                                          fontSize: size.width * 0.04,
                                          color:
                                              appColors.descriptionTextColor()),
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
                            color: appColors.iconButtonColor(),
                          ),
                          scale: size.height * 0.13,
                          content: this.widget.pet.getAnimal(),
                          backgroundColor: appColors.cardColor(),
                          contentColor: appColors.textColor(),
                        ),
                        RectangleCard(
                          size: size,
                          icon: Icon(
                            Icons.restaurant_menu,
                            size: size.height * 0.053,
                            color: appColors.iconButtonColor(),
                          ),
                          scale: size.height * 0.13,
                          content: this.widget.pet.getRation(),
                          backgroundColor: appColors.cardColor(),
                          contentColor: appColors.textColor(),
                        ),
                        RectangleCard(
                          size: size,
                          icon: Icon(
                            Icons.aspect_ratio,
                            size: size.height * 0.053,
                            color: appColors.iconButtonColor(),
                          ),
                          scale: size.height * 0.13,
                          content: this.widget.pet.getSize(),
                          backgroundColor: appColors.cardColor(),
                          contentColor: appColors.textColor(),
                        ),
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
                            DialogHelper.chooseMode(context, feedController);
                          },
                          child: RectangleCard(
                            size: size,
                            icon: Icon(
                              Icons.dehaze,
                              size: size.height * 0.053,
                              color: appColors.iconButtonColor(),
                            ),
                            scale: size.height * 0.13,
                            content: 'Modo',
                            backgroundColor: appColors.cardColor(),
                            contentColor: appColors.textColor(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            DialogHelper.setQuantity(context, feedController);
                          },
                          child: RectangleCard(
                            size: size,
                            icon: Icon(
                              Icons.local_restaurant,
                              size: size.height * 0.053,
                              color: appColors.iconButtonColor(),
                            ),
                            scale: size.height * 0.13,
                            content: 'Quantidade',
                            backgroundColor: appColors.cardColor(),
                            contentColor: appColors.textColor(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (feedController.getMode() == "Horário")
                                DialogHelper.setSchedule(
                                    context, feedController);
                            });
                          },
                          child: RectangleCard(
                            size: size,
                            icon: Icon(
                              Icons.schedule,
                              size: size.height * 0.053,
                              color: appColors.iconButtonColor(),
                            ),
                            scale: size.height * 0.13,
                            content: 'Horários',
                            backgroundColor: appColors.cardColor(),
                            contentColor: appColors.textColor(),
                          ),
                        ),
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
                              color: appColors.deleteColor())),
                      SizedBox(width: size.width * 0.02),
                      GestureDetector(
                        onTap: () async {
                          try {
                            DialogBuilder(context, appColors)
                                .showLoadingIndicator();

                            var petsRepository = new PetsRepository();
                            var statusCode = await petsRepository
                                .destroy(this.widget.pet.getId());

                            if (statusCode == 200)
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            else {
                              print('Error');
                              DialogBuilder(context, appColors)
                                  .hideOpenDialog();
                            }
                          } catch (err) {
                            print(err.toString());
                            DialogBuilder(context, appColors).hideOpenDialog();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: size.width * 0.05),
                          child: CircleCard(
                            icon: Icon(Icons.delete,
                                color: appColors.deleteColor()),
                            size: size,
                            color: appColors.cardColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size.height * 0.016)),
              ],
            ),
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
                style: GoogleFonts.inter(color: appColors.seeMoreColor()),
              ),
              SizedBox(width: size.width * 0.02),
              Visibility(
                visible: icon != null ? true : false,
                child: Icon(icon,
                    size: size.width * 0.05, color: appColors.seeMoreColor()),
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
        side: BorderSide(color: appColors.cardColor(), width: 1),
        borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
      ),
      child: Container(
        height: size.height * 0.16,
        width: size.height * 0.13,
        decoration: BoxDecoration(
          color: appColors.cardColor(),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          left: size.width * 0.03,
          top: size.width * 0.04,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: size.width * 0.043,
                  fontWeight: FontWeight.bold,
                  color: appColors.textColor())),
          SizedBox(
            height: size.height * 0.027,
          ),
          Text(content,
              style: GoogleFonts.inter(
                  fontSize: size.width * 0.03,
                  color: appColors.descriptionTextColor())),
          SizedBox(
            height: size.height * 0.024,
          ),
          Row(
            children: [
              Text(value.toString(),
                  style: GoogleFonts.inter(
                      fontSize: size.width * 0.043,
                      fontWeight: FontWeight.bold,
                      color: appColors.textColor())),
              SizedBox(
                width: size.width * 0.02,
              ),
              Text('kcal',
                  style: GoogleFonts.inter(
                      fontSize: size.width * 0.037,
                      color: appColors.textColor())),
            ],
          ),
        ]),
      ),
    );
  }
}
