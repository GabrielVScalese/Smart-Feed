import 'package:animated_card/animated_card.dart';
import 'package:dio/dio.dart';
import 'package:mailer/mailer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/components/toast_message.dart';
import 'package:project/pages/configurations/help_page.dart';
import 'package:project/repositories/users_repository.dart';
import 'package:project/utils/app_colors.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  var emailController = new TextEditingController();
  var showSuccessfulMessage = false;
  var showEmailErrorMessage = false;
  var appColors;

  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    return Scaffold(
      body: Stack(children: [
        Container(
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
                        onTap: () async {
                          DialogBuilder(context, appColors)
                              .showLoadingIndicator();
                          var userRepository = new UsersRepository();

                          var statusCode = await userRepository
                              .resetPassword(emailController.text);

                          if (statusCode == 200) {
                            showSuccessfulMessage = true;
                          } else {
                            showEmailErrorMessage = true;
                            emailController.clear();
                          }

                          DialogBuilder(context, appColors).hideOpenDialog();
                          setState(() {});
                          try {
                            await Future.delayed(Duration(seconds: 5));
                            showSuccessfulMessage = false;
                            showEmailErrorMessage = false;
                            setState(() {});
                          } catch (err) {}
                        },
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
        Visibility(
          visible: showSuccessfulMessage,
          child: AnimatedCard(
            direction: AnimatedCardDirection.right,
            child: SafeArea(
              child: Align(
                alignment: Alignment(-1, -1),
                child: MessageEmail(
                  message: "Um link foi enviado para o email",
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: showEmailErrorMessage,
          child: AnimatedCard(
            direction: AnimatedCardDirection.right,
            child: SafeArea(
              child: Align(
                alignment: Alignment(-1, -1),
                child: MessageEmail(
                  message: "Email não cadastrado",
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
