import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/rounded_button.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/repositories/login_repository.dart';
import 'package:project/repositories/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PasswordDialog extends StatefulWidget {
  const PasswordDialog({Key key}) : super(key: key);

  @override
  _PasswordDialogState createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<PasswordDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  var user;

  _loadData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      user = jsonDecode(prefs.getString('user'));
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();

    _loadData().then((data) {});
  }

  _buildChild(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var _passwordController = TextEditingController();
    var _visible = true;
    var inputColor = Color.fromRGBO(186, 184, 184, 1);
    return Container(
        height: size.height * 0.40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.03),
              Align(
                child: Text(
                  "Confirme sua senha",
                  style: GoogleFonts.inter(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(height: size.width * 0.1),
              Center(
                child: TextFieldContainer(
                  size: size * 0.9,
                  textField: TextField(
                    obscureText: _visible,
                    controller: _passwordController,
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
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _visible = !_visible;
                            });
                          },
                          child: Icon(
                            _visible ? Icons.visibility : Icons.visibility_off,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: size.width * 0.1),
              Align(
                child: Text(
                  "Atenção!! Você está excluindo permanentemente sua conta",
                  style:
                      GoogleFonts.inter(fontSize: 15, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.width * 0.05),
              GestureDetector(
                onTap: () async {
                  try {
                    var loginRepository = LoginRepository();
                    var statusCode = await loginRepository.login(User.fromLogin(
                        user["email"], _passwordController.text));

                    if (statusCode == 200) {
                      var userRepository = UsersRepository();
                      userRepository.destroy(user["id"]);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else {
                      print('Invalid credentials');
                      DialogBuilder(context).hideOpenDialog();
                    }
                  } catch (err) {
                    print(err.toString());
                    DialogBuilder(context).hideOpenDialog();
                  }
                },
                child: Center(
                  child: RoundedButton(
                      height: size.height * 0.053,
                      width: size.width * 0.5,
                      radius: 30,
                      text: 'Excluir'),
                ),
              )
            ],
          ),
        ));
  }
}
