import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/controllers/theme_controller.dart';
import 'package:project/pages/configurations/confirm_password_page.dart';
import 'package:project/pages/configurations/user_page.dart';
import 'package:project/utils/app_colors.dart';
import 'package:project/utils/app_colors_dark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  var newPasswordController = new TextEditingController();
  var reapeatPasswordController = new TextEditingController();

  var newPasswordObscure = true;
  var repeatPasswordObscure = true;

  var appColors;
  bool darkTheme;

  loadTheme() async {
    var themeController = ThemeController();
    darkTheme = await themeController.getTheme();

    if (this.darkTheme)
      appColors = AppColorsDark();
    else
      appColors = AppColors();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadTheme().then((data) {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: appColors.backgroundColor(),
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
                      color: appColors.cardColor(),
                      size: size,
                      icon: Icon(
                        Icons.arrow_back,
                        color: appColors.iconButtonColor(),
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
                          title: 'Mudar Senha',
                          color: appColors.textColor(),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Text('Digite e repita a nova senha.',
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
                      backgroundColor: appColors.cardColor(),
                      size: size,
                      textField: TextField(
                        cursorColor: appColors.textColor(),
                        controller: newPasswordController,
                        obscureText: newPasswordObscure,
                        style: GoogleFonts.inter(
                          fontSize: size.width * 0.9 * 0.045,
                          color: appColors.descriptionTextColor(),
                        ),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.inter(
                                color: Color.fromRGBO(186, 184, 184, 1)),
                            hintText: 'Nova Senha',
                            prefixIcon: Icon(
                              Icons.lock,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  newPasswordObscure = !newPasswordObscure;
                                });
                              },
                              child: Icon(
                                newPasswordObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: size.width * 0.9 * 0.06,
                                color: inputColor,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  child: Align(
                    child: TextFieldContainer(
                      backgroundColor: appColors.cardColor(),
                      size: size,
                      textField: TextField(
                        cursorColor: appColors.textColor(),
                        controller: reapeatPasswordController,
                        obscureText: repeatPasswordObscure,
                        style: GoogleFonts.inter(
                          fontSize: size.width * 0.9 * 0.045,
                          color: appColors.descriptionTextColor(),
                        ),
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.inter(
                                color: Color.fromRGBO(186, 184, 184, 1)),
                            hintText: 'Repita a Senha',
                            prefixIcon: Icon(
                              Icons.lock,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  repeatPasswordObscure =
                                      !repeatPasswordObscure;
                                });
                              },
                              child: Icon(
                                repeatPasswordObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: size.width * 0.9 * 0.06,
                                color: inputColor,
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
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
                    Text('Próximo',
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: appColors.iconButtonColor())),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      onTap: () async {
                        if (newPasswordController.text ==
                                reapeatPasswordController.text &&
                            newPasswordController.text.isNotEmpty) {
                          var instance = await SharedPreferences.getInstance();
                          Map user = jsonDecode(instance.getString('user'));

                          RequestOptions requestOptions = new RequestOptions(
                              path:
                                  'https://smart-feed-app.herokuapp.com/users/${user['id']}',
                              data: {
                                'name': user['name'],
                                'email': user['email'],
                                'password': newPasswordController.text
                              },
                              method: 'PUT');

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ConfirmPasswordPage(
                                  requestOptions,
                                  'Confirme a sua senha atual',
                                  'Salvar',
                                  'userPage')));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 0.05),
                        child: CircleCard(
                          color: appColors.cardColor(),
                          icon: Icon(
                            Icons.arrow_forward,
                            color: appColors.iconButtonColor(),
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
