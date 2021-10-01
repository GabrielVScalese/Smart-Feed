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
import 'package:project/pages/configurations/confirm_password_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/repositories/pets_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  var emailController = new TextEditingController();

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
                        Navigator.pop(context);
                      },
                      child: CircleCard(
                          size: size,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: size.height * 0.03,
                          )),
                    ),
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
                      PageTitle(size: size, title: 'Trocar email'),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text('Digite seu novo email.',
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
              SizedBox(
                height: size.height * 0.13,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Align(
                  child: new TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: emailController,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Novo email',
                          prefixIcon: Icon(Icons.mail,
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
                  Text('Próximo',
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () async {
                      if (!emailController.text.isEmpty)
                        try {
                          var instance = await SharedPreferences.getInstance();
                          Map user = jsonDecode(instance.getString('user'));

                          RequestOptions requestOptions = new RequestOptions(
                              path:
                                  'https://smart-feed-app.herokuapp.com/users/${user['id']}',
                              data: {
                                'name': user['name'],
                                'email': emailController.text,
                                'password': ""
                              },
                              method: 'PUT');

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ConfirmPasswordPage(
                                  requestOptions,
                                  'Confirme a sua senha atual',
                                  'Salvar',
                                  'userPage')));
                        } catch (err) {
                          print(err.toString());
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
          ),
        ]),
      ),
    );
  }
}
