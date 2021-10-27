import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/pages/configurations/confirm_password_page.dart';
import 'package:project/pages/configurations/user_page.dart';
import 'package:project/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  var emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: size.width * 0.05),
                    child: CircleCard(
                      color: Colors.white,
                      size: size,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: size.height * 0.03,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
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
                          title: 'Recuperar Conta',
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Text('Acesse o link que será enviado por email',
                            style: GoogleFonts.inter(
                                fontSize: size.width * 0.045,
                                color: Color.fromRGBO(125, 125, 125, 1)))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.21),
                AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  child: Align(
                    child: TextFieldContainer(
                      backgroundColor: Colors.white,
                      size: size,
                      textField: TextField(
                        cursorColor: Colors.black,
                        controller: emailController,
                        style: GoogleFonts.inter(
                          fontSize: size.width * 0.9 * 0.045,
                          color: Color.fromRGBO(125, 125, 125, 1),
                        ),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.inter(
                                color: Color.fromRGBO(186, 184, 184, 1)),
                            hintText: 'Email da conta',
                            prefixIcon: Icon(
                              Icons.email,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
            AnimatedCard(
              direction: AnimatedCardDirection.left,
              child: Align(
                alignment: Alignment(0.92, 0.95),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Enviar',
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.042,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      // onTap: () async {
                      //   if (newPasswordController.text ==
                      //           reapeatPasswordController.text &&
                      //       newPasswordController.text.isNotEmpty) {
                      //     var instance = await SharedPreferences.getInstance();
                      //     Map user = jsonDecode(instance.getString('user'));

                      //     RequestOptions requestOptions = new RequestOptions(
                      //         path:
                      //             'https://smart-feed-api.herokuapp.com/users/${user['id']}',
                      //         data: {
                      //           'name': user['name'],
                      //           'email': user['email'],
                      //           'password': newPasswordController.text
                      //         },
                      //         method: 'PUT');

                      //     Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => ConfirmPasswordPage(
                      //             requestOptions,
                      //             'Confirme a sua senha atual',
                      //             'Salvar',
                      //             'userPage')));
                      //   }
                      // },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 0.05),
                        child: CircleCard(
                          color: Colors.white,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                          size: size,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
