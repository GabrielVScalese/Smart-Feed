import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/models/user_repository.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var is_obscure1 = true;
  var is_obscure2 = true;

  var name = "";
  var email = "";
  var password = "";
  var confirm_password = "";

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
                    margin: const EdgeInsets.only(top: 40),
                    child: Text(
                      'Cadastro',
                      style: TextStyle(fontSize: 38, color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 70,
                    margin: const EdgeInsets.only(left: 20, top: 40),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      height: 70.0,
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 50),
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
                                color: Colors.white70,
                                size: 27,
                              ),
                              labelText: 'Digite seu nome',
                              labelStyle: TextStyle(
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
                                color: Colors.white70,
                                size: 27,
                              ),
                              labelText: 'Digite seu email',
                              labelStyle: TextStyle(
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
                          obscureText: is_obscure1,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  is_obscure1
                                      ? Icons.visibility_sharp
                                      : Icons.visibility_off_sharp,
                                  color: Colors.white,
                                  size: 27,
                                ),
                                onPressed: () {
                                  setState(() {
                                    is_obscure1 = !is_obscure1;
                                  });
                                },
                              ),
                              labelText: 'Digite sua senha',
                              labelStyle: TextStyle(
                                  fontSize: 21.0, color: Colors.white)))),
                  Container(
                      height: 70.0,
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 35),
                      child: TextField(
                          onChanged: (text) {
                            setState(() {
                              confirm_password = text;
                            });
                          },
                          obscureText: is_obscure2,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  is_obscure2
                                      ? Icons.visibility_sharp
                                      : Icons.visibility_off_sharp,
                                  color: Colors.white,
                                  size: 27,
                                ),
                                onPressed: () {
                                  setState(() {
                                    is_obscure2 = !is_obscure2;
                                  });
                                },
                              ),
                              labelText: 'Confirme sua senha',
                              labelStyle: TextStyle(
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
                    child: FlatButton(
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      onPressed: () async {
                        try {
                          if (password == confirm_password) {
                            var status_code = await UserRepository.insertUser(
                                new User(name, email, password));

                            if (status_code == 200)
                              print('Inserted user!');
                            else
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
