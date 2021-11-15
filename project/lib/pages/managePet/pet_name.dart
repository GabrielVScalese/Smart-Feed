import 'dart:convert';
import 'dart:io';
import 'package:animated_card/animated_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/models/pet.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/managePet/pet_photo.dart';
import 'package:project/repositories/pets_repository.dart';
import 'package:project/utils/app_colors.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:project/utils/image_uploader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetName extends StatefulWidget {
  var arguments;

  PetName({this.arguments});

  @override
  _PetNameState createState() => _PetNameState();
}

class _PetNameState extends State<PetName> {
  var appColors;
  var alreadyBuilt = false;

  loadTheme() async {
    this.appColors = new AppColors();
    await this.appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});

    if (this.widget.arguments.length == 6)
      this._nameController.text = this.widget.arguments[4]['value'];

    super.initState();
  }

  var _nameController = new TextEditingController();

  _insertArgument() {
    var arguments = this.widget.arguments as List;

    print("adasdafa: ${arguments}");

    if (arguments.length > 4)
      arguments[4] = {'value': _nameController.text};
    else
      arguments.add({'value': _nameController.text});

    return arguments;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: appColors.backgroundColor(),
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
                                  PetPhoto(arguments: arguments)),
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
                              '5/5',
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
                          title: 'Nome',
                          color: appColors.textColor()),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Digite o nome.',
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
              SizedBox(
                height: size.height * 0.13,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Align(
                  child: new TextFieldContainer(
                    backgroundColor: appColors.cardColor(),
                    size: size,
                    textField: TextField(
                      maxLength: 11,
                      controller: _nameController,
                      cursorColor: appColors.textColor(),
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.9 * 0.045,
                          color: appColors.iconButtonColor()),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: appColors.descriptionTextColor()),
                          hintText: 'Nome',
                          counterText: "",
                          prefixIcon: Icon(Icons.person,
                              size: size.width * 0.9 * 0.06,
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          border: InputBorder.none),
                    ),
                  ),
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
                  Text('Finalizar',
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: appColors.iconButtonColor())),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () async {
                      if (!_nameController.text.isEmpty)
                        try {
                          DialogBuilder(context, appColors)
                              .showLoadingIndicator();

                          var arguments = _insertArgument() as List;

                          var instance = await SharedPreferences.getInstance();
                          var user = jsonDecode(instance.getString('user'));

                          var imageLink = null;
                          if (arguments[3]['value'] == null) {
                            if (arguments[0]['value'] == "Cão")
                              imageLink = 'https://i.imgur.com/yh365gr.png';
                            else if (arguments[0]['value'] == "Gato")
                              imageLink = 'https://i.imgur.com/WYShCBk.png';
                          } else {
                            if (arguments[3]['value'] is File)
                              imageLink = await ImageUploader.uploadImage(
                                  arguments[3]['value']);
                            else
                              imageLink = arguments[3]['value'];
                          }

                          var pet = Pet.fromRegister(
                              user['id'],
                              arguments[4]['value'],
                              arguments[0]['value'],
                              arguments[2]['value'],
                              arguments[1]['value'],
                              "Smart Feed UHG78F",
                              imageLink);

                          if (arguments.length == 6) {
                            var options =
                                arguments[5]['value'] as RequestOptions;

                            options.data = Pet.toMap(pet);
                            Dio dio =
                                new CustomDio.withAuthentication().instance;
                            var response = await dio.request(options.path,
                                queryParameters: options.queryParameters,
                                data: options.data,
                                options: Options(method: options.method));

                            if (response.statusCode == 200) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              DialogBuilder(context, appColors)
                                  .hideOpenDialog();
                            }
                          } else {
                            var petsRepository = new PetsRepository();
                            var statusCode = await petsRepository.create(pet);

                            if (statusCode == 200)
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            else {
                              DialogBuilder(context, appColors)
                                  .hideOpenDialog();
                            }
                          }
                        } catch (err) {
                          print(err.toString());
                          DialogBuilder(context, appColors).hideOpenDialog();
                        }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: CircleCard(
                        color: appColors.cardColor(),
                        icon: Icon(Icons.arrow_forward,
                            color: appColors.iconButtonColor()),
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
