import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/pet_repository.dart';
import 'package:project/models/user.dart';
import 'package:project/models/user_repository.dart';
import 'package:project/pages/home_page.dart';

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
                  )),
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
                  labelStyle: TextStyle(fontSize: 21.0, color: Colors.white),
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
              height: 42,
              width: 190,
              margin: const EdgeInsets.only(top: 70, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: TextButton(
                child: Text(
                  'Fazer Login',
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 22),
                ),
                onPressed: () async {
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

                  try {
                    var statusCode = await UserRepository.authenticateUser(
                        new User.fromUser(email, password));

                    var pets = await PetRepository.findPetsByUserEmail(email);
                    print(pets);

                    if (statusCode == 200)
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(pets)));
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
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: TextButton(
                child: Text(
                  'Criar Conta',
                  style: GoogleFonts.lato(color: Colors.black, fontSize: 22),
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
