import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/user.dart';
import 'package:project/models/user_repository.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var isObscure1 = true;
  var isObscure2 = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(177, 219, 235, 1),
              Color.fromRGBO(5, 76, 252, 1),
            ],
          )),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      'Cadastro',
                      style: GoogleFonts.lato(
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 70,
                    margin: const EdgeInsets.only(left: 10, top: 60),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ],
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              suffixIcon: Icon(
                                Icons.account_box,
                                color: Colors.white,
                                size: 27,
                              ),
                              labelText: 'Digite seu nome',
                              labelStyle: GoogleFonts.lato(
                                  fontSize: 21.0, color: Colors.white)))),
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
                          style: TextStyle(color: Colors.white),
                          controller: emailController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: emailError
                                          ? Colors.red
                                          : Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 27,
                              ),
                              labelText: emailPlaceholder,
                              labelStyle: GoogleFonts.lato(
                                  fontSize: 21.0,
                                  color: emailError
                                      ? Colors.red
                                      : Colors.white)))),
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure1
                                      ? Icons.visibility_sharp
                                      : Icons.visibility_off_sharp,
                                  color: Colors.white,
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
                                  fontSize: 21.0, color: Colors.white)))),
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
                              color: confirmPasswordError
                                  ? Colors.red
                                  : Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: confirmPasswordError
                                          ? Colors.red
                                          : Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure2
                                      ? Icons.visibility_sharp
                                      : Icons.visibility_off_sharp,
                                  color: Colors.white,
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
                                      : Colors.white)))),
                  Container(
                    height: 40,
                    width: 190,
                    margin: const EdgeInsets.only(top: 75),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 1],
                        colors: [
                          Color.fromRGBO(2, 221, 253, 1),
                          Color.fromRGBO(2, 197, 253, 1),
                        ],
                      ),
                    ),
                    child: TextButton(
                      child: Text(
                        'Criar Conta',
                        style:
                            GoogleFonts.lato(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () async {
                        try {
                          if (password == confirmPassword) {
                            var statusCode = await UserRepository.insertUser(
                                new User(name, email, password));

                            if (statusCode == 200) {
                              print('Inserted user!');
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
