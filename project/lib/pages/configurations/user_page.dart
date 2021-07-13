import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/circle_image.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/shimmer_widget.dart';
import 'package:project/controllers/auth_controller.dart';
import 'package:project/pages/account/login_page.dart';
import 'package:project/pages/configurations/configuration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_password_page.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var _isLoading = true;
  var _user;

  _loadData() async {
    try {
      var instance = await SharedPreferences.getInstance();
      _user = await jsonDecode(instance.get('user'));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {}
  }

  _decideView(size) {
    if (this._isLoading)
      return Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerWidget.circular(
                width: size.height * 0.03, height: size.height * 0.03),
            SizedBox(
              height: size.height * 0.03,
            ),
            ShimmerWidget.rectangular(
                width: size.width * 0.15, height: size.height * 0.015),
            SizedBox(
              height: size.height * 0.01,
            ),
            ShimmerWidget.rectangular(
                width: size.width * 0.15, height: size.height * 0.015),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      );

    return Column(
      children: [
        CircleImage(
          scale: size.height * 0.2,
          srcImage:
              'https://lh3.google.com/u/0/ogw/ADea4I4W4LOMQSuR-ScGQ5ir_-xWRMF4vs7aliXbOQ6q=s83-c-mo',
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Text(_user['name'],
            style: GoogleFonts.inter(
                fontSize: size.width * 0.045, fontWeight: FontWeight.bold)),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text(_user['email'],
            style: GoogleFonts.inter(
                fontSize: size.width * 0.035,
                color: Color.fromRGBO(125, 125, 125, 1)))
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _loadData().then((data) {});
  }

  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ConfigurationPage()));
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
                margin: EdgeInsets.only(left: size.width * 0.05),
                child: PageTitle(
                  size: size,
                  title: 'Minha Conta',
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    _decideView(size),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    DataCard(
                      size: size,
                      icon: Icons.email,
                      title: 'Trocar Email',
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ChangePasswordPage()));
                      },
                      child: DataCard(
                        size: size,
                        icon: Icons.lock,
                        title: 'Mudar Senha',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
          Align(
            alignment: Alignment(0.92, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Logout',
                    style: GoogleFonts.inter(
                        fontSize: size.width * 0.042,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                SizedBox(width: size.width * 0.02),
                GestureDetector(
                  onTap: () async {
                    try {
                      var instance = await SharedPreferences.getInstance();

                      instance.remove('user');
                      instance.remove('token');

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } catch (err) {}
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: size.width * 0.05),
                    child: CircleCard(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      size: size,
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class DataCard extends StatelessWidget {
  const DataCard(
      {Key key, @required this.size, @required this.icon, @required this.title})
      : super(key: key);

  final Size size;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.09,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: size.height * 0.028,
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Text(title,
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold))
                ],
              ),
              Icon(
                Icons.chevron_right,
                size: size.height * 0.035,
              )
            ],
          ),
        ),
      ),
    );
  }
}
