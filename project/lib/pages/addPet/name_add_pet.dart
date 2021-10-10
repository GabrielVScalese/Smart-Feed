import 'dart:convert';
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
import 'package:project/repositories/pets_repository.dart';
import 'package:project/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameAddPet extends StatefulWidget {
  @override
  _NameAddPetState createState() => _NameAddPetState();
}

class _NameAddPetState extends State<NameAddPet> {
  var appColors;

  loadTheme() async {
    this.appColors = new AppColors();
    await this.appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});
    super.initState();
  }

  var _nameController = new TextEditingController();

  _getArguments() {
    var arguments = ModalRoute.of(context).settings.arguments;

    return arguments;
  }

  _insertArgument() {
    var arguments = _getArguments() as List;

    if (arguments.length > 4)
      arguments[4] = {'value': _nameController.text};
    else
      arguments.add({'value': _nameController.text});

    return arguments;
  }

  _uploadImage(image64) async {
    var clientID = '2f7307ddc860abf';

    var dio = Dio();
    var response = await dio.post('https://api.imgur.com/3/image',
        data: {'image': image64},
        options: Options(headers: {
          'Authorization': 'Client-ID $clientID',
          'Content-Type': "application/json"
        }));

    return response.data['data']['link'];
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

                        Navigator.of(context).pushReplacementNamed('/photo',
                            arguments: arguments);
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
                      controller: _nameController,
                      cursorColor: appColors.textColor(),
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.9 * 0.045,
                          color: appColors.iconButtonColor()),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: appColors.descriptionTextColor()),
                          hintText: 'Nome',
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

                          var arguments = _insertArgument();

                          var instance = await SharedPreferences.getInstance();
                          var user = jsonDecode(instance.getString('user'));

                          var image64 = null;
                          if (arguments[3]['value'] != null)
                            image64 = base64Encode(
                                await arguments[3]['value'].readAsBytes());

                          var imageLink = null;
                          if (image64 != null)
                            imageLink = await _uploadImage(image64);
                          else if (arguments[0]['value'] == 'Cão')
                            imageLink = 'https://i.imgur.com/yh365gr.png';
                          else
                            imageLink = 'https://i.imgur.com/WYShCBk.png';

                          var pet = Pet.fromRegister(
                              user['id'],
                              arguments[4]['value'],
                              arguments[0]['value'],
                              arguments[2]['value'],
                              arguments[1]['value'],
                              "Smart Feed UHG78F",
                              imageLink);

                          var petsRepository = new PetsRepository();
                          var statusCode = await petsRepository.create(pet);

                          if (statusCode == 200)
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          else {
                            DialogBuilder(context, appColors).hideOpenDialog();
                            print('Error');
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
