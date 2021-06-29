import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/pages/home_page.dart';

class PhotoAddPet extends StatefulWidget {
  @override
  _PhotoAddPetState createState() => _PhotoAddPetState();
}

class _PhotoAddPetState extends State<PhotoAddPet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleCard(
                          size: size,
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: size.height * 0.03,
                          )),
                    ),
                    Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text('5/5',
                                style: GoogleFonts.inter(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold)),
                            width: size.width * 0.14,
                            height: size.width * 0.14,
                            decoration: BoxDecoration(shape: BoxShape.circle)))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(size: size, title: 'Foto'),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text('Escolha uma foto.',
                        style: GoogleFonts.inter(
                            fontSize: size.width * 0.04,
                            color: Color.fromRGBO(125, 125, 125, 1)))
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.13,
              ),
              Stack(
                children: [
                  Align(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Container(
                          child: Stack(
                            children: [
                              Align(
                                child: Icon(Icons.person,
                                    size: (size.width * 0.5) * 0.55,
                                    color: Color.fromRGBO(186, 184, 184, 1)),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                  child: Container(
                                      child: Icon(Icons.photo_camera,
                                          size: (size.width * 0.15) * 0.5,
                                          color:
                                              Color.fromRGBO(144, 143, 143, 1)),
                                      width: size.width * 0.15,
                                      height: size.width * 0.15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle)),
                                ),
                              )
                            ],
                          ),
                          width: size.width * 0.5,
                          height: size.width * 0.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment(0.92, 0.92),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Finalizar',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: size.width * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: size.width * 0.05),
                    child: CircleCard(
                      icon: Icon(Icons.arrow_forward),
                      size: size,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}