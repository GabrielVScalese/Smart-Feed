import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/repositories/pet_repository.dart';
import 'package:project/models/repositories/user_repository.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/loading_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isObscure = true;

  var loginError = false;
  var email = "";
  var password = "";
  var errorMessage = " * Email ou senha incorretos";
  var loaded = true;

  var inputColor = Color.fromRGBO(42, 48, 101, 1);

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                  margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                  child: Image.asset('assets/images/logo.png')),
              Visibility(
                visible: loginError,
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 40),
                  child: Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Container(
                height: 70.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextField(
                  onTap: () {
                    setState(() {
                      loginError = false;
                    });
                  },
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                  style: GoogleFonts.lato(color: inputColor),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: inputColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: inputColor),
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: inputColor,
                      size: 27,
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 21.0, color: inputColor),
                  ),
                ),
              ),
              Container(
                height: 70.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: TextField(
                  onTap: () {
                    setState(() {
                      loginError = false;
                    });
                  },
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  obscureText: isObscure,
                  style: GoogleFonts.lato(color: inputColor),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: inputColor)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: inputColor),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure
                            ? Icons.visibility_sharp
                            : Icons.visibility_off_sharp,
                        color: inputColor,
                        size: 27,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(fontSize: 21.0, color: inputColor),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 70, bottom: 10),
                height: 50,
                width: 190,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: Text(
                      'Fazer Login',
                      style: GoogleFonts.lato(color: inputColor, fontSize: 22),
                    ),
                    onPressed: () async {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();

                      try {
                        setState(() {
                          loaded = false;
                        });

                        var statusCode = await UserRepository.authenticateUser(
                            new User.fromUser(email, password));

                        loaded = true;

                        var pets = null;
                        User user = new User(1, "saas", email);
                        user.setPassword(password);

                        if (statusCode == 200)
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomePage(pets, user)));
                        else {
                          print('Invalid user!');
                          setState(() {
                            loginError = true;
                          });
                        }
                      } catch (error) {
                        print('Invalid user!');
                        setState(() {
                          loginError = true;
                          errorMessage =
                              "Não foi possível conectar, tente novamente mais tarde.";
                        });
                      }
                    },
                  ),
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
                  color: inputColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 45,
                ),
                child: Text(
                  'Crie uma conta',
                  style: GoogleFonts.lato(fontSize: 20, color: inputColor),
                ),
              ),
              Container(
                height: 50,
                width: 190,
                margin: const EdgeInsets.only(top: 15),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: Text(
                      'Criar Conta',
                      style: GoogleFonts.lato(color: inputColor, fontSize: 22),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    } else {
      return LoadingPage.Build();
    }
  }
}
