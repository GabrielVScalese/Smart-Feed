import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/rounded_button.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/pages/account/register_page.dart';

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

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    // Labels
    var labelColor = Color.fromRGBO(140, 138, 138, 1);
    var labelSize = size.width * 0.035;

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
                          suffixIcon: Icon(
                            Icons.visibility,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
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
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
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
