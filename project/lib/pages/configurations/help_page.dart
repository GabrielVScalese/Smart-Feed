import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/pages/configurations/configuration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

var starsClicked = 1;
var avaliations = ['Muito ruim', 'Ruim', 'Regular', 'Bom', 'Muito bom'];
var textFieldController = TextEditingController();

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.06),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ConfigurationPage()));
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
                      title: 'Fale Conosco',
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  child: Container(
                    margin: EdgeInsets.only(left: size.width * 0.05),
                    child: Text(
                      'Avalie nosso aplicativo e tire suas dúvidas!',
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.045,
                        color: Color.fromRGBO(125, 125, 125, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.15,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      avaliations[starsClicked - 1],
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.045,
                        color: Color.fromRGBO(125, 125, 125, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            starsClicked = 1;
                            setState(() {});
                          },
                          child: StarIcon(
                            starNumber: 1,
                          )),
                      GestureDetector(
                        onTap: () {
                          starsClicked = 2;
                          setState(() {});
                        },
                        child: StarIcon(
                          starNumber: 2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          starsClicked = 3;
                          setState(() {});
                        },
                        child: StarIcon(
                          starNumber: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          starsClicked = 4;
                          setState(() {});
                        },
                        child: StarIcon(
                          starNumber: 4,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          starsClicked = 5;
                          setState(() {});
                        },
                        child: StarIcon(
                          starNumber: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.width * 0.05),
                AnimatedCard(
                  direction: AnimatedCardDirection.left,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      // margin: EdgeInsets.only(left: size.width * 0.05),
                      width: size.width * 0.8,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          // side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: textFieldController,
                          keyboardType: TextInputType.multiline,
                          minLines: 8,
                          maxLines: null,
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: size.width * 0.05),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Descreva seu problema",
                            hintStyle:
                                GoogleFonts.inter(fontSize: size.width * 0.042),
                          ),
                        ),
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
                    Text('Enviar',
                        style: GoogleFonts.inter(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      onTap: () async {
                        try {
                          DialogBuilder(context).showLoadingIndicator();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var user = jsonDecode(prefs.getString('user'));
                          print(user);

                          // app.smart.feed@gmail.com
                          final Email email = Email(
                            body: textFieldController.text,
                            subject: 'Avaliação de ' + user["name"],
                            cc: [user["email"]],
                            recipients: ['app.smart.feed@gmail.com'],
                            isHTML: false,
                          );

                          await FlutterEmailSender.send(email);
                          DialogBuilder(context).hideOpenDialog();
                        } catch (err) {
                          print(err);
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
      ),
    );
  }
}

class StarIcon extends StatefulWidget {
  int starNumber;

  StarIcon({this.starNumber});

  @override
  _StarIconState createState() => _StarIconState();
}

class _StarIconState extends State<StarIcon> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Icon(
      Icons.star,
      size: size.width * 0.115,
      color: starsClicked >= this.widget.starNumber
          ? Colors.blue
          : Color(0xFFe6e6e6),
    );
  }
}
