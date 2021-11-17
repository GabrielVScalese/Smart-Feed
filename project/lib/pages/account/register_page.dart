import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/dialog_helper.dart';
import 'package:project/components/rounded_button.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/components/toast_message.dart';
import 'package:project/models/user.dart';
import 'package:project/repositories/users_repository.dart';
import 'package:project/utils/app_colors.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();

var passwordVisible = true;
var confirmVisible = true;
var showEmailMessage = false;

class _RegisterPageState extends State<RegisterPage> {
  var appColors;

  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    loadTheme().then((data) {});
    super.initState();
  }

  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    // Labels
    var labelSize = size.width * 0.035;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: size.height * 0.06),
              GestureDetector(
                  onTap: () {
                    setState(() {});
                    nameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    confirmPasswordController.clear();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: size.width * 0.05),
                      child: CircleCard(
                          size: size,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: size.height * 0.03,
                          )))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Text('Criar Conta',
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * 0.05),
                  TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: nameController,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Nome',
                          prefixIcon: Icon(
                            Icons.person,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: emailController,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: passwordController,
                      obscureText: passwordVisible,
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
                                passwordVisible = !passwordVisible;
                              });
                            },
                            child: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFieldContainer(
                    size: size,
                    textField: TextField(
                      controller: confirmPasswordController,
                      obscureText: confirmVisible,
                      style:
                          GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          hintText: 'Confirmar senha',
                          prefixIcon: Icon(
                            Icons.lock,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                confirmVisible = !confirmVisible;
                              });
                            },
                            child: Icon(
                              confirmVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: size.width * 0.9 * 0.06,
                              color: inputColor,
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: size.height * 0.09),
                  GestureDetector(
                    onTap: () async {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        DialogHelper.errorModal(
                            context,
                            "Falta de informações",
                            "Preencha todos os campos para poder criar sua conta",
                            Icons.error_outline_outlined,
                            Colors.redAccent,
                            Colors.redAccent);
                      } else {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          User user = User(
                              nameController.text, emailController.text,
                              password: passwordController.text);

                          DialogBuilder(context, appColors)
                              .showLoadingIndicator();

                          var usersRepository = UsersRepository();
                          var statusCode = await usersRepository.register(user);

                          DialogBuilder(context, appColors).hideOpenDialog();

                          if (statusCode == 200) {
                            DialogHelper.errorModal(
                              context,
                              "Verifique seu email",
                              "Verifique sua conta atravéz do link enviado por email",
                              Icons.warning,
                              Colors.grey[300],
                              Color.fromRGBO(0, 153, 255, 1),
                            );
                            await Future.delayed(Duration(seconds: 3));
                            try {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            } catch (err) {}
                          }

                          if (statusCode == 400) {
                            showEmailMessage = true;
                          }
                        } else {
                          DialogHelper.errorModal(
                              context,
                              "Confirme a senha",
                              "As senhas que você colocou não são as mesmas",
                              Icons.error,
                              Colors.redAccent,
                              Colors.redAccent);
                        }

                        try {
                          await Future.delayed(Duration(seconds: 5));
                          showEmailMessage = false;
                          setState(() {});
                        } catch (err) {}
                      }
                    },
                    child: RoundedButton(
                      height: size.height * 0.053,
                      width: size.width * 0.9,
                      radius: 30,
                      text: 'CRIAR CONTA',
                      backgroundColor: Color.fromRGBO(0, 153, 255, 1),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Já possui conta? ',
                          style: GoogleFonts.inter(
                              color: Color.fromRGBO(140, 138, 138, 1),
                              fontSize: labelSize),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          confirmPasswordController.clear();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Container(
                          child: Text(
                            'Fazer login',
                            style: GoogleFonts.inter(
                              color: Color.fromRGBO(0, 119, 199, 1),
                              fontSize: labelSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ]),
            Visibility(
              visible: showEmailMessage,
              child: AnimatedCard(
                direction: AnimatedCardDirection.right,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment(-1, -1),
                    child: MessageEmail(
                      message: "Email já está cadastrado",
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
