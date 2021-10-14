import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/smtp_server.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/pages/configurations/configuration_page.dart';
import 'package:project/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

var starsClicked = 1;
var avaliations = ['Muito ruim', 'Ruim', 'Regular', 'Bom', 'Muito bom'];
var textFieldController = TextEditingController();
var showSucessMessage = false;
var showErrorMessage = false;
var appColors;

class _HelpPageState extends State<HelpPage> {
  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: appColors.backgroundColor(),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.06),
                GestureDetector(
                  onTap: () {
                    starsClicked = 1;
                    textFieldController.text = "";
                    showSucessMessage = false;
                    showErrorMessage = false;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ConfigurationPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: size.width * 0.05),
                    child: CircleCard(
                      size: size,
                      color: appColors.cardColor(),
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
                  direction: AnimatedCardDirection.right,
                  child: Container(
                    margin: EdgeInsets.only(left: size.width * 0.05),
                    child: PageTitle(
                      size: size,
                      title: 'Fale Conosco',
                      color: appColors.textColor(),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.right,
                  child: Container(
                    margin: EdgeInsets.only(left: size.width * 0.05),
                    child: Text(
                      'Avalie nosso aplicativo e tire suas dúvidas!',
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.045,
                        color: appColors.descriptionTextColor(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.15,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.right,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      avaliations[starsClicked - 1],
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.045,
                        color: appColors.descriptionTextColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                AnimatedCard(
                  direction: AnimatedCardDirection.right,
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
                  direction: AnimatedCardDirection.right,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * 0.8,
                      child: Card(
                        color: appColors.cardColor(),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: textFieldController,
                          keyboardType: TextInputType.multiline,
                          minLines: 8,
                          maxLines: null,
                          style: GoogleFonts.inter(
                              color: appColors.textColor(),
                              fontSize: size.width * 0.05),
                          cursorColor: appColors.textColor(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Descreva seu problema",
                            hintStyle: GoogleFonts.inter(
                                fontSize: size.width * 0.042,
                                color: appColors.descriptionTextColor()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedCard(
              direction: AnimatedCardDirection.right,
              child: Align(
                alignment: Alignment(0.92, 0.92),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Enviar',
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: appColors.iconButtonColor())),
                    SizedBox(width: size.width * 0.02),
                    GestureDetector(
                      onTap: () async {
                        DialogBuilder(context, appColors)
                            .showLoadingIndicator();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var user = jsonDecode(prefs.getString('user'));
                        print(user);

                        String username = 'smart.feed.sender@gmail.com';
                        String password = 'SmartFeed2021';

                        // ignore: deprecated_member_use
                        final smtpServer = gmail(username, password);
                        // Create our message.
                        final message = Message()
                          ..from = Address(username)
                          ..recipients.add('smart.feed.adm@gmail.com')
                          ..subject = user["name"] +
                              ", id: " +
                              user["id"].toString() +
                              ", " +
                              user["email"]
                          ..text = "Experiência com o app: " +
                              avaliations[starsClicked - 1] +
                              "\n" +
                              textFieldController.text;

                        try {
                          final sendReport = await send(message, smtpServer);
                          print('Message sent: ' + sendReport.toString());
                          showSucessMessage = true;
                        } on MailerException catch (e) {
                          print('Message not sent.');
                          showErrorMessage = true;
                          e.toString();
                        }

                        try {
                          DialogBuilder(context, appColors).hideOpenDialog();
                          starsClicked = 1;
                          textFieldController.text = "";

                          await Future.delayed(Duration(seconds: 5));
                          showSucessMessage = false;
                          showErrorMessage = false;
                          setState(() {});
                        } catch (err) {}
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 0.05),
                        child: CircleCard(
                          icon: Icon(Icons.arrow_forward,
                              color: appColors.iconButtonColor()),
                          size: size,
                          color: appColors.cardColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: showSucessMessage,
              child: AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: SafeArea(
                  child: Align(
                      alignment: Alignment(-1, -1),
                      child: MessageEmail(
                        message: "Email enviado com sucesso!",
                        color: appColors.successfulColor(),
                      )),
                ),
              ),
            ),
            Visibility(
              visible: showErrorMessage,
              child: AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: SafeArea(
                  child: Align(
                      alignment: Alignment(-1, -1),
                      child: MessageEmail(
                        message: "Erro ao enviar a mensagem!",
                        color: appColors.deleteColor(),
                      )),
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
          ? appColors.seeMoreColor()
          : appColors.starNotSelectedColor(),
    );
  }
}

class MessageEmail extends StatelessWidget {
  String message;
  Color color;

  MessageEmail({this.message, this.color});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.15,
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Text(
        message,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
