import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var is_obscure = true;

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
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        suffixIcon: Icon(
                          Icons.email,
                          color: Colors.white70,
                          size: 27,
                        ),
                        labelText: 'Email',
                        labelStyle:
                            TextStyle(fontSize: 21.0, color: Colors.white)))),
            Container(
                height: 70.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: TextField(
                    obscureText: is_obscure,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            is_obscure
                                ? Icons.visibility_sharp
                                : Icons.visibility_off_sharp,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              is_obscure = !is_obscure;
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
              child: FlatButton(
                child: Text(
                  'Fazer Login',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {},
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
                style: TextStyle(fontSize: 20, color: Colors.white),
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
              child: FlatButton(
                child: Text(
                  'Criar Conta',
                  style: TextStyle(color: Colors.white, fontSize: 22),
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