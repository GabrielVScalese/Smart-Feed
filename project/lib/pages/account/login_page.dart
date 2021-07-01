import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rounded_button.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/controllers/auth_controller.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/account/register_page.dart';
import 'package:project/service/user_repository.dart';

import '../home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool visible = true;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    // Labels
    var labelColor = Color.fromRGBO(140, 138, 138, 1);
    var labelSize = size.width * 0.035;

    //controllers
    // var emailController = TextEditingController();
    // var passwordController = TextEditingController();
    var authController = AuthController();

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.25,
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 400),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: size.height * 0.15,
                        width: size.width * 0.75,
                      )),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFieldContainer(
                    size: size,
                    textField: TextField(
                      // controller: emailController,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email,
                              size: size.width * 0.9 * 0.06, color: inputColor),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextFieldContainer(
                    size: size,
                    textField: TextField(
                      obscureText: visible,
                      // controller: passwordController,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Senha',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                if (visible == true)
                                  visible = false;
                                else
                                  visible = true;
                                print(visible);
                              });
                            },
                            child: Icon(
                              visible ? Icons.visibility : Icons.visibility_off,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.54),
                    child: Text('Esqueceu a senha?',
                        style: GoogleFonts.inter(
                            color: labelColor, fontSize: labelSize)),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      DialogBuilder(context).showLoadingIndicator();
                      User user =
                          User.fromUser("gabriel.scalese@hotmail.com", "1234");
                      var statusCode =
                          await UserRepository.authenticateUser(user);
                      if (statusCode == 200) {
                        authController.setUser(context, user);
                        DialogBuilder(context).hideOpenDialog();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      } else {
                        print('Invalid user!');
                        DialogBuilder(context).hideOpenDialog();
                      }
                    },
                    child: RoundedButton(size: size, text: 'LOGIN'),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Não possui conta? ',
                      style: GoogleFonts.inter(
                          color: labelColor, fontSize: labelSize),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RegisterPage()));
                    },
                    child: Container(
                      child: Text('Criar conta',
                          style: GoogleFonts.inter(
                              color: Color.fromRGBO(0, 119, 199, 1),
                              fontSize: labelSize)),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.white,
              content: LoadingIndicator(),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          'Por favor, espere ...',
          style: GoogleFonts.inter(
              color: Color.fromRGBO(0, 153, 255, 1), fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4, top: 10));
  }
}
