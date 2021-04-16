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

  var name = "";
  var email = "";
  var password = "";
  var confirmPassword = "";

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
                    margin: const EdgeInsets.only(left: 20, top: 60),
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
                          onChanged: (text) {
                            setState(() {
                              email = text;
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
                                Icons.email,
                                color: Colors.white,
                                size: 27,
                              ),
                              labelText: 'Digite seu email',
                              labelStyle: GoogleFonts.lato(
                                  fontSize: 21.0, color: Colors.white)))),
                  Container(
                      height: 70.0,
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 35),
                      child: TextField(
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
                              labelText: 'Digite sua senha',
                              labelStyle: GoogleFonts.lato(
                                  fontSize: 21.0, color: Colors.white)))),
                  Container(
                      height: 70.0,
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 35),
                      child: TextField(
                          onChanged: (text) {
                            setState(() {
                              confirmPassword = text;
                            });
                          },
                          obscureText: isObscure2,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
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
                              labelText: 'Confirme sua senha',
                              labelStyle: GoogleFonts.lato(
                                  fontSize: 21.0, color: Colors.white)))),
                  Container(
                    height: 40,
                    width: 190,
                    margin: const EdgeInsets.only(top: 75),
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
                            } else
                              print('Error for insert user!');
                          } else {
                            print('Diferrent passwords!');
                            return;
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
