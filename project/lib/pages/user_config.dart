import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserConfigPage extends StatefulWidget {
  var _user;

  UserConfigPage(this._user);

  @override
  _UserConfigPageState createState() => _UserConfigPageState();
}

class _UserConfigPageState extends State<UserConfigPage> {
  var isObscure1 = true;
  var isObscure2 = true;
  var editing = false;

  var emailError = false;
  var confirmPasswordError = false;

  var emailPlaceholder = 'Digite seu email';
  var confirmPasswordPlaceholder = 'Confirme sua senha';

  var name = "";
  var email = "";
  var password = "";
  var confirmPassword = "";

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print(this.widget._user.getName());
    emailController.text = this.widget._user.getEmail();
    nameController.text = this.widget._user.getName();
    passwordController.text = this.widget._user.getPassword();
  }

  var inputColor = Color.fromRGBO(42, 48, 101, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Configurações',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 430,
                width: double.infinity,
                margin: EdgeInsets.all(15),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 70.0,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: TextField(
                              readOnly: editing == false ? true : false,
                              onChanged: (text) {
                                setState(() {
                                  name = text;
                                });
                              },
                              style: TextStyle(color: inputColor),
                              controller: nameController,
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
                                hintText: 'Digite seu nome',
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 21.0, color: inputColor),
                              ),
                            ),
                          ),
                          Container(
                            height: 70.0,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: TextField(
                              readOnly: editing == false ? true : false,
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
                                hintText: emailPlaceholder,
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 21.0,
                                    color:
                                        emailError ? Colors.red : inputColor),
                              ),
                            ),
                          ),
                          Container(
                            height: 70.0,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: TextField(
                              readOnly: editing == false ? true : false,
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
                                    editing
                                        ? isObscure1
                                            ? Icons.visibility_sharp
                                            : Icons.visibility_off_sharp
                                        : Icons.lock,
                                    color: inputColor,
                                    size: 27,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (editing) isObscure1 = !isObscure1;
                                    });
                                  },
                                ),
                                hintText: "Digite sua senha",
                                labelStyle: GoogleFonts.lato(
                                    fontSize: 21.0, color: inputColor),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: editing,
                            child: Container(
                              height: 70.0,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                              child: TextField(
                                controller: confirmPasswordController,
                                onTap: () {
                                  setState(() {
                                    confirmPasswordError = false;
                                    confirmPasswordPlaceholder =
                                        "Confirme sua senha";
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
                                        : inputColor),
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
                                  hintText: confirmPasswordPlaceholder,
                                  labelStyle: GoogleFonts.lato(
                                      fontSize: 21.0,
                                      color: confirmPasswordError
                                          ? Colors.red
                                          : inputColor),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: editing,
                            child: Container(
                              height: 50,
                              width: 190,
                              child: Card(
                                color: inputColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: TextButton(
                                  child: Text(
                                    'Salvar',
                                    style: GoogleFonts.lato(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 15, right: 15, bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              editing = !editing;
                              if (editing) {
                                emailController.text = "";
                                nameController.text = "";
                                passwordController.text = "";
                              } else {
                                emailController.text =
                                    this.widget._user.getEmail();
                                nameController.text =
                                    this.widget._user.getName();
                                passwordController.text =
                                    this.widget._user.getPassword();
                              }
                            });
                          },
                          child: Text(
                            editing ? 'Cancelar' : 'Editar',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 55,
                width: 190,
                child: Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: TextButton(
                    child: Text(
                      'Sair',
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 22),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 45,
                  right: 45,
                  top: 15,
                ),
                child: Divider(
                  thickness: 0.9,
                  color: inputColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 55,
                width: 190,
                child: Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: TextButton(
                    child: Text(
                      'Excluir Conta',
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 22),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
