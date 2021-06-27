import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/circle_image.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Fazer tamanho máximo e tamanho mínimo
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            GestureDetector(
                onTap: () {},
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
              child: Text(
                'Minha Conta',
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.065, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleImage(
                    scale: size.height * 0.2,
                    srcImage:
                        'https://lh3.google.com/u/0/ogw/ADea4I4W4LOMQSuR-ScGQ5ir_-xWRMF4vs7aliXbOQ6q=s83-c-mo',
                    margin: null,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text('Guilherme Augusto',
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text('guilherme.augusto@hotmail.com',
                      style: GoogleFonts.inter(
                          fontSize: size.width * 0.035,
                          color: Color.fromRGBO(125, 125, 125, 1))),
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
                  DataCard(
                    size: size,
                    icon: Icons.lock,
                    title: 'Mudar Senha',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Logout',
                    style: GoogleFonts.inter(
                        fontSize: size.width * 0.042,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                SizedBox(width: size.width * 0.02),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(right: size.width * 0.05),
                      child: CircleCard(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        size: size,
                      ),
                    )),
              ],
            )
          ],
        ),
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
