import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/repositories/user_repository.dart';
import 'package:project/models/user.dart';

import 'loading_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var isObscure1 = true;
  var isObscure2 = true;
  var loaded = true;

  var emailError = false;
  var confirmPasswordError = false;

  var emailPlaceholder = 'Digite seu email';
  var confirmPasswordPlaceholder = 'Confirme sua senha';

  var name = "";
  var email = "";
  var password = "";
  var confirmPassword = "";

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 60),
                  child: Text(
                    'Cadastro',
                    style: GoogleFonts.lato(
                        fontSize: 42,
                        color: inputColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        height: 70.0,
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 70),
                        child: TextField(
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: TextStyle(color: inputColor),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: inputColor)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: inputColor),
                                ),
                                suffixIcon: Icon(
                                  Icons.account_box,
                                  color: inputColor,
                                  size: 27,
                                ),
                                labelText: 'Digite seu nome',
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 21.0, color: inputColor)))),
                    Container(
                        height: 70.0,
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 35),
                        child: TextField(
                            onTap: () {
                              setState(() {
                                emailError = false;
                                emailPlaceholder = "Digite seu email";
                              });
                            },
                            onChanged: (text) {
                              setState(() {
                                email = text;
                              });
                            },
                            style: TextStyle(color: inputColor),
                            controller: emailController,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: emailError
                                            ? Colors.red
                                            : inputColor)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: inputColor),
                                ),
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: inputColor,
                                  size: 27,
                                ),
                                labelText: emailPlaceholder,
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 21.0,
                                    color: emailError
                                        ? Colors.red
                                        : inputColor)))),
                    Container(
                        height: 70.0,
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 35),
                        child: TextField(
                            controller: passwordController,
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            obscureText: isObscure1,
                            style: TextStyle(color: inputColor),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: inputColor)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: inputColor),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure1
                                        ? Icons.visibility_sharp
                                        : Icons.visibility_off_sharp,
                                    color: inputColor,
                                    size: 27,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObscure1 = !isObscure1;
                                    });
                                  },
                                ),
                                labelText: "Digite sua senha",
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 21.0, color: inputColor)))),
                    Container(
                      height: 70.0,
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 35),
                      child: TextField(
                        controller: confirmPasswordController,
                        onTap: () {
                          setState(() {
                            confirmPasswordError = false;
                            confirmPasswordPlaceholder = "Confirme sua senha";
                          });
                        },
                        onChanged: (text) {
                          setState(() {
                            confirmPassword = text;
                          });
                        },
                        obscureText: isObscure2,
                        style: TextStyle(
                            color:
                                confirmPasswordError ? Colors.red : inputColor),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: confirmPasswordError
                                      ? Colors.red
                                      : inputColor)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: inputColor),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure2
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off_sharp,
                              color: inputColor,
                              size: 27,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure2 = !isObscure2;
                              });
                            },
                          ),
                          labelText: confirmPasswordPlaceholder,
                          labelStyle: GoogleFonts.lato(
                              fontSize: 21.0,
                              color: confirmPasswordError
                                  ? Colors.red
                                  : inputColor),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 75),
                      height: 50,
                      width: 190,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: TextButton(
                          child: Text(
                            'Criar Conta',
                            style: GoogleFonts.lato(
                                color: inputColor, fontSize: 22),
                          ),
                          onPressed: () async {
                            try {
                              if (password == confirmPassword) {
                                setState(() {
                                  loaded = false;
                                });

                                var statusCode =
                                    await UserRepository.insertUser(
                                        new User.fromRegister(
                                            name, email, password));

                                loaded = true;

                                if (statusCode == 200) {
                                  print('Inserted user!');
                                  Navigator.popUntil(context, (route) => false);
                                  Navigator.of(context).pushNamed('/');
                                } else {
                                  print('email errado');
                                  setState(() {
                                    emailError = true;
                                    emailPlaceholder = 'Digite um email válido';
                                    emailController.clear();
                                  });
                                }
                              } else {
                                setState(() {
                                  confirmPasswordError = true;
                                  confirmPasswordPlaceholder =
                                      'As senhas não são iguais';
                                  passwordController.clear();
                                  confirmPasswordController.clear();
                                });
                              }
                            } catch (error) {
                              print('Invalid user!');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return LoadingPage.Build();
    }
  }
}
