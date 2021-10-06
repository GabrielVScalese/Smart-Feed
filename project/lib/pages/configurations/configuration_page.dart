import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_helper.dart';
import 'package:project/components/page_title.dart';
import 'package:project/controllers/theme_controller.dart';
import 'package:project/pages/configurations/confirm_password_page.dart';
import 'package:project/pages/configurations/help_page.dart';
import 'package:project/pages/configurations/user_page.dart';
import 'package:project/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: size.width * 0.05),
                  child: CircleCard(
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
                  margin: EdgeInsets.only(left: size.width * 0.05),
                  child: PageTitle(
                    size: size,
                    title: 'Configurações',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                initDelay: Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => UserPage()));
                  },
                  child: ConfigurationCard(
                    size: size,
                    icon: Icon(
                      Icons.person,
                      size: size.height * 0.04,
                    ),
                    title: 'Minha Conta',
                    content: 'Informações e editar conta',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                initDelay: Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: () async {
                    var themeController = ThemeController();

                    bool darkTheme = await themeController.getTheme();
                    print(darkTheme);
                    DialogHelper.themeModal(context, darkTheme);
                  },
                  child: ConfigurationCard(
                    size: size,
                    icon: Icon(
                      Icons.color_lens,
                      size: size.height * 0.035,
                    ),
                    title: 'Tema',
                    content: 'Troque entre o tema escuro ou claro',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HelpPage()));
                },
                child: AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  initDelay: Duration(milliseconds: 500),
                  child: ConfigurationCard(
                    size: size,
                    icon: Icon(
                      Icons.help,
                      size: size.height * 0.035,
                    ),
                    title: 'Ajuda',
                    content: 'Fale conosco ou envie um feedback',
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                initDelay: Duration(milliseconds: 500),
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    var user = jsonDecode(prefs.getString('user'));
                    RequestOptions requestOptions = new RequestOptions(
                        path:
                            'https://smart-feed-app.herokuapp.com/users/${user["id"]}',
                        method: 'DELETE');

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConfirmPasswordPage(
                            requestOptions,
                            "Você está excluindo sua conta!",
                            "Excluir",
                            "login")));
                  },
                  child: ConfigurationCard(
                    size: size,
                    icon: Icon(
                      Icons.delete,
                      size: size.height * 0.035,
                      color: Colors.red,
                    ),
                    title: 'Excluir Conta',
                    content: 'Remover permanentemente a conta',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConfigurationCard extends StatelessWidget {
  const ConfigurationCard(
      {Key key,
      @required this.size,
      @required this.icon,
      @required this.title,
      @required this.content})
      : super(key: key);

  final Size size;
  final Icon icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.05),
              height: size.height * 0.09,
              width: size.width * 0.9,
              child: Row(
                children: [
                  icon,
                  SizedBox(width: size.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(title,
                          style: GoogleFonts.inter(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.007,
                      ),
                      Text(
                        content,
                        style: GoogleFonts.inter(
                          fontSize: size.width * 0.035,
                          color: Color.fromRGBO(125, 125, 125, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
