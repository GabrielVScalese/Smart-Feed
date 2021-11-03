import 'dart:io';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/photo_card.dart';
import 'package:project/controllers/image_controller.dart';
import 'package:project/pages/managePet/pet_ration.dart';
import 'package:project/utils/app_colors.dart';
import 'pet_name.dart';

class PetPhoto extends StatefulWidget {
  var arguments;

  PetPhoto({this.arguments});

  @override
  _PetPhotoState createState() => _PetPhotoState();
}

class _PetPhotoState extends State<PetPhoto> {
  var appColors;
  var imageController = new ImageController();

  loadTheme() async {
    this.appColors = new AppColors();
    await this.appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});
    _setImgController();
    super.initState();
  }

  File _imgFile;

  _getArguments() {
    var arguments = this.widget.arguments;

    return arguments;
  }

  _insertArgument() {
    var arguments = _getArguments() as List;

    if (arguments.length > 3) {
      arguments[3] = {'value': this.imageController.image};
    } else
      arguments.add({'value': this.imageController.image});

    return arguments;
  }

  _setImgController() {
    var arguments = _getArguments() as List;
    if (arguments.length == 6 || arguments.length == 5)
      imageController.changeImage(arguments[3]['value']);
    else {
      if (arguments[0]['value'] == 'Cão')
        imageController.changeImage('https://i.imgur.com/yh365gr.png');
      else
        imageController.changeImage('https://i.imgur.com/WYShCBk.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                        var arguments = _insertArgument();

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  PetRation(arguments: arguments)),
                        );
                      },
                      child: CircleCard(
                          color: appColors.cardColor(),
                          size: size,
                          icon: Icon(
                            Icons.arrow_back,
                            color: appColors.iconButtonColor(),
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
                            child: Text(
                              '4/5',
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
                        title: 'Foto',
                        color: appColors.textColor(),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Escolha uma foto.',
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
                child: Stack(
                  children: [
                    Align(
                      child: PhotoCard(
                          imageController: imageController,
                          scale: size.width * 0.5),
                    )
                  ],
                ),
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
                          color: appColors.iconButtonColor())),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      var arguments = _insertArgument();
                      print(arguments);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PetName(arguments: arguments)));

                      //     .pushReplacementNamed('/name', arguments: arguments);
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
