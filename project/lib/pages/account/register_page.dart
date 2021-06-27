import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/rounded_button.dart';
import 'package:project/components/text_field_container.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    // Labels
    var labelSize = size.width * 0.035;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: size.height * 0.06),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.09,
                ),
                Text('Criar Conta',
                    style: GoogleFonts.inter(
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: size.height * 0.05),
                TextFieldContainer(
                  size: size,
                  textField: TextField(
                    style:
                        GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.inter(
                            color: Color.fromRGBO(186, 184, 184, 1)),
                        hintText: 'Nome',
                        prefixIcon: Icon(
                          Icons.person,
                          size: size.width * 0.9 * 0.06,
                          color: inputColor,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                TextFieldContainer(
                  size: size,
                  textField: TextField(
                    style:
                        GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.inter(
                            color: Color.fromRGBO(186, 184, 184, 1)),
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          size: size.width * 0.9 * 0.06,
                          color: inputColor,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
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
                SizedBox(height: size.height * 0.03),
                TextFieldContainer(
                  size: size,
                  textField: TextField(
                    style:
                        GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.inter(
                            color: Color.fromRGBO(186, 184, 184, 1)),
                        hintText: 'Confirmar senha',
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
                SizedBox(height: size.height * 0.09),
                RoundedButton(size: size, text: 'CRIAR CONTA'),
                SizedBox(height: size.height * 0.06),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'Já possui conta? ',
                        style: GoogleFonts.inter(
                            color: Color.fromRGBO(140, 138, 138, 1),
                            fontSize: labelSize),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Container(
                          child: Text('Fazer login',
                              style: GoogleFonts.inter(
                                color: Color.fromRGBO(0, 119, 199, 1),
                                fontSize: labelSize,
                              ))),
                    )
                  ],
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
