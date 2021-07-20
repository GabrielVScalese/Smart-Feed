import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/models/pet.dart';
import 'package:project/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameAddPet extends StatefulWidget {
  @override
  _NameAddPetState createState() => _NameAddPetState();
}

class _NameAddPetState extends State<NameAddPet> {
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
    var jsonData = json.encode({'image': image64});

    var response = await http.post(
        Uri.parse(
          'https://api.imgur.com/3/image',
        ),
        body: jsonData,
        headers: {
          "Authorization": 'Client-ID $clientID',
          "Content-Type": "application/json"
        });

    var map = json.decode(response.body);
    return map['data']['link'];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                        var arguments = _insertArgument();

                        Navigator.of(context).pushReplacementNamed('/photo',
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
                            child: Text('5/5',
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
                    PageTitle(size: size, title: 'Nome'),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text('Digite o nome.',
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.045,
                            color: Color.fromRGBO(125, 125, 125, 1)))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.13,
              ),
              SizedBox(
                height: size.height * 0.13,
              ),
              Align(
                child: new TextFieldContainer(
                  size: size,
                  textField: TextField(
                    controller: _nameController,
                    style:
                        GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.inter(
                            color: Color.fromRGBO(186, 184, 184, 1)),
                        hintText: 'Nome',
                        prefixIcon: Icon(Icons.person,
                            size: size.width * 0.9 * 0.06,
                            color: Color.fromRGBO(186, 184, 184, 1)),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0.92, 0.92),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Finalizar',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: size.width * 0.02),
                GestureDetector(
                  onTap: () async {
                    if (!_nameController.text.isEmpty)
                      try {
                        DialogBuilder(context).showLoadingIndicator();

                        var arguments = _insertArgument();

                        // var instance = await SharedPreferences.getInstance();
                        // var user = await jsonDecode(instance.get('user'));
                        // var authorization =
                        //     await jsonDecode(instance.get('authorization'));

                        // var image64 = base64Encode(
                        //     await arguments[3]['value'].readAsBytes());

                        // var imageLink = await _uploadImage(image64);
                        // var pet = Pet.fromRegister(
                        //     user['id'],
                        //     arguments[4]['value'],
                        //     arguments[0]['value'],
                        //     arguments[2]['value'],
                        //     arguments[1]['value'],
                        //     "Smart Feed UHG78F",
                        //     imageLink);

                        // var statusCode = await PetRepository.create(pet);

                        // if (statusCode == 200)
                        //   Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //           builder: (context) => HomePage()));
                        // else {
                        //   DialogBuilder(context).hideOpenDialog();
                        //   print('Error');
                        // }
                      } catch (err) {
                        print(err.toString());
                        DialogBuilder(context).hideOpenDialog();
                      }
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
