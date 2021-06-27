import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/arrow_back_card.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
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
            SizedBox(height: size.height * 0.06),
            GestureDetector(onTap: () {}, child: ArrowBackCard(size: size)),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.05),
              child: Text(
                'Configurações',
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.065, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            ConfigurationCard(
              size: size,
              icon: Icon(
                Icons.person,
                size: size.height * 0.04,
              ),
              title: 'Minha Conta',
              content: 'Informações e editar conta',
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ConfigurationCard(
              size: size,
              icon: Icon(
                Icons.color_lens,
                size: size.height * 0.035,
              ),
              title: 'Tema',
              content: 'Troque entre o tema escuro ou claro',
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ConfigurationCard(
              size: size,
              icon: Icon(
                Icons.help,
                size: size.height * 0.035,
              ),
              title: 'Ajuda',
              content: 'Fale conosco ou envie um feedback',
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            ConfigurationCard(
              size: size,
              icon: Icon(
                Icons.delete,
                size: size.height * 0.035,
                color: Colors.red,
              ),
              title: 'Excluir Conta',
              content: 'Remover permanentemente a conta',
            )
          ],
        ),
      ),
    );
  }
}

class ConfigurationCard extends StatelessWidget {
  const ConfigurationCard(
      {Key key,
      @required this.size,
      @required this.icon,
      @required this.title,
      @required this.content})
      : super(key: key);

  final Size size;
  final Icon icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Container(
              padding: EdgeInsets.only(left: size.width * 0.05),
              height: size.height * 0.09,
              width: size.width * 0.9,
              child: Row(
                children: [
                  icon,
                  SizedBox(width: size.width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(title,
                          style: GoogleFonts.inter(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: size.height * 0.007,
                      ),
                      Text(content,
                          style: GoogleFonts.inter(
                              fontSize: size.width * 0.035,
                              color: Color.fromRGBO(125, 125, 125, 1))),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
