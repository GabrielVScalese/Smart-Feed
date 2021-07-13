import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/configurations/user_page.dart';
import 'package:project/service/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'configuration_page.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // Cor dos textos do input
  var inputColor = Color.fromRGBO(186, 184, 184, 1);

  var newPasswordController = new TextEditingController();
  var currentPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => UserPage()));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: size.width * 0.05),
                        child: CircleCard(
                            size: size,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: size.height * 0.03,
                            )))),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  margin: EdgeInsets.only(left: size.width * 0.05),
                  child: PageTitle(
                    size: size,
                    title: 'Mudar Senha',
                  ),
                ),
                SizedBox(height: size.height * 0.25),
                Align(
                  child: TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: newPasswordController,
                      obscureText: true,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Nova Senha',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.visibility,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Align(
                  child: TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: currentPasswordController,
                      obscureText: true,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Senha Atual',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.visibility,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(0.92, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Salvar',
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.042,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  SizedBox(width: size.width * 0.02),
                  GestureDetector(
                    onTap: () async {
                      try {
                        DialogBuilder(context).showLoadingIndicator();
                        var instance = await SharedPreferences.getInstance();
                        var userFromInstance =
                            await jsonDecode(instance.get('user'));

                        var authenticationResponse =
                            await UserRepository.authenticateUser(
                                User.fromLogin(userFromInstance['email'],
                                    currentPasswordController.text));

                        if (authenticationResponse['statusCode'] == 200) {
                          var user = User(
                              userFromInstance['id'],
                              userFromInstance['name'],
                              userFromInstance['email'],
                              newPasswordController.text);

                          var authorization =
                              await jsonDecode(instance.get('authorization'));

                          var updateStatusCode = await UserRepository.update(
                              user, authorization['token']);

                          if (updateStatusCode == 200)
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => UserPage()));
                          else {
                            DialogBuilder(context).hideOpenDialog();
                          }
                          print('Error');
                        }
                      } catch (err) {
                        print(err.toString());
                        DialogBuilder(context).hideOpenDialog();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: CircleCard(
                        icon: Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                        size: size,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
