import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/user.dart';
import 'package:project/models/user_repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isObscure = true;

  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(177, 219, 235, 1),
            Color.fromRGBO(5, 76, 252, 1),
          ],
        )),
        child: Column(
          children: [
            Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                child: Image.asset('assets/images/logo.png')),
            Container(
                height: 70.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 50),
                child: TextField(
                    onChanged: (text) {
                      setState(() {
                        email = text;
                      });
                    },
                    style: GoogleFonts.lato(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 27,
                        ),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(fontSize: 21.0, color: Colors.white)))),
            Container(
                height: 70.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: TextField(
                    onChanged: (text) {
                      setState(() {
                        password = text;
                      });
                    },
                    obscureText: isObscure,
                    style: GoogleFonts.lato(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_sharp
                                : Icons.visibility_off_sharp,
                            color: Colors.white,
                            size: 27,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        labelText: 'Senha',
                        labelStyle:
                            TextStyle(fontSize: 21.0, color: Colors.white)))),
            Container(
              height: 40,
              width: 190,
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                // BoxDecoration para poder fazer a decoração normal e a decoração das bordas
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                gradient: LinearGradient(
                  // LinearGradient para fazer o degrade
                  begin: Alignment.topLeft, //degrade começa no top left
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(2, 221, 253, 1), // cores
                    Color.fromRGBO(2, 197, 253, 1), // do degrade
                  ],
                ),
              ),
              child: TextButton(
                child: Text(
                  'Fazer Login',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 22),
                ),
                onPressed: () async {
                  try {
                    var statusCode = await UserRepository.authenticateUser(
                        new User.fromUser(email, password));

                    if (statusCode == 200)
                      print('Valid user!');
                    else
                      print('Invalid user!');
                  } catch (error) {
                    print('Invalid user!');
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 45,
                right: 45,
                top: 45,
              ),
              child: Divider(
                thickness: 0.9,
                color: Colors.white,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 45,
              ),
              child: Text(
                'Crie uma conta',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
              ),
            ),
            Container(
              height: 40,
              width: 190,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                // BoxDecoration para poder fazer a decoração normal e a decoração das bordas
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                gradient: LinearGradient(
                  // LinearGradient para fazer o degrade
                  begin: Alignment.topLeft, //degrade começa no top left
                  end: Alignment.bottomRight, // e termina no bottom right
                  stops: [
                    0.3,
                    1
                  ], // Define quando o degrade começa, numero de parametros é o mesmo numero de cores
                  colors: [
                    Color.fromRGBO(2, 221, 253, 1), // cores
                    Color.fromRGBO(2, 197, 253, 1), // do degrade
                  ],
                ),
              ),
              child: TextButton(
                child: Text(
                  'Criar Conta',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
