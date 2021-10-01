import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/dialog_builder.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/text_field_container.dart';
import 'package:project/models/user.dart';
import 'package:project/pages/configurations/change_password_page.dart';
import 'package:project/pages/configurations/user_page.dart';
import 'package:project/repositories/login_repository.dart';
import 'package:project/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmPasswordPage extends StatefulWidget {
  RequestOptions requestOptions;
  String subtitle;
  String buttonTitle;
  String page;

  ConfirmPasswordPage(
      this.requestOptions, this.subtitle, this.buttonTitle, this.page);

  @override
  _ConfirmPasswordPageState createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  var _currentPasswordController = new TextEditingController();

  var currentPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor dos textos do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(size: size, title: 'Confirmar Senha'),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(this.widget.subtitle,
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.045,
                            color: Color.fromRGBO(125, 125, 125, 1)))
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.25),
              Align(
                child: TextFieldContainer(
                  size: size,
                  textField: TextField(
                    controller: _currentPasswordController,
                    obscureText: currentPasswordObscure,
                    style:
                        GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.inter(
                            color: Color.fromRGBO(186, 184, 184, 1)),
                        hintText: 'Senha Atual',
                        prefixIcon: Icon(
                          Icons.lock,
                          size: size.width * 0.9 * 0.06,
                          color: inputColor,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPasswordObscure = !currentPasswordObscure;
                            });
                          },
                          child: Icon(
                            currentPasswordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: size.width * 0.9 * 0.06,
                            color: inputColor,
                          ),
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0.92, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(this.widget.buttonTitle,
                    style: GoogleFonts.inter(
                        fontSize: size.width * 0.042,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                SizedBox(width: size.width * 0.02),
                GestureDetector(
                  onTap: () async {
                    try {
                      DialogBuilder(context).showLoadingIndicator();

                      var instance = await SharedPreferences.getInstance();
                      var user = jsonDecode(instance.get('user'));

                      var loginRepository = new LoginRepository();
                      var authenticationStatusCode =
                          await loginRepository.login(User.fromLogin(
                              user['email'], _currentPasswordController.text));

                      if (authenticationStatusCode == 200) {
                        DialogBuilder(context).showLoadingIndicator();

                        var dio = CustomDio.withAuthentication().instance;
                        var options = this.widget.requestOptions;

                        if (options.data != null) if (options
                            .data['password'].isEmpty)
                          options.data['password'] =
                              _currentPasswordController.text;

                        var response = await dio.request(options.path,
                            queryParameters: options.queryParameters,
                            data: options.data,
                            options: Options(method: options.method));

                        if (response.statusCode == 200) {
                          if (options.data != null)
                            user['email'] = options.data['email'];

                          instance.setString('user', jsonEncode(user));
                          Navigator.pushNamed(context, '/${this.widget.page}');
                        } else
                          DialogBuilder(context).hideOpenDialog();
                      } else
                        print('Error');
                    } on DioError catch (err) {
                      print(err.toString());
                      DialogBuilder(context).hideOpenDialog();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: size.width * 0.05),
                    child: CircleCard(
                      icon: Icon(
                        Icons.done,
                        color: Colors.black,
                      ),
                      size: size,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
