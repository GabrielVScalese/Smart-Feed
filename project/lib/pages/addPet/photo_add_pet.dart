import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';

class PhotoAddPet extends StatefulWidget {
  @override
  _PhotoAddPetState createState() => _PhotoAddPetState();
}

class _PhotoAddPetState extends State<PhotoAddPet> {
  File _imgFile;

  _getArguments() {
    var arguments = ModalRoute.of(context).settings.arguments;

    return arguments;
  }

  _openGallery() async {
    try {
      var imgPicker = ImagePicker();
      var pickedFile = await imgPicker.getImage(source: ImageSource.gallery);

      setState(() {
        _imgFile = File(pickedFile.path);
      });
    } catch (error) {}
  }

  _decideView(size) {
    if (_imgFile != null)
      return Center(
        child: Container(
          width: size.width * 0.5,
          height: size.width * 0.5,
          child: ClipOval(
            child: Image.file(
              _imgFile,
              fit: BoxFit.cover,
              // scale: size.height * 0.2,
            ),
          ),
        ),
      );
    else
      return Align(
        child: Icon(Icons.person,
            size: (size.width * 0.5) * 0.55,
            color: Color.fromRGBO(186, 184, 184, 1)),
      );
  }

  _insertArgument() {
    var arguments = _getArguments() as List;

    if (arguments.length > 3)
      arguments[3] = {'value': _imgFile};
    else
      arguments.add({'value': _imgFile});

    return arguments;
  }

  _setImgFile() {
    var arguments = _getArguments() as List;

    if (arguments.length > 3)
      setState(() {
        if (_imgFile == null) _imgFile = arguments[3]['value'];
      });
  }

  @override
  Widget build(BuildContext context) {
    _setImgFile();

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
                      onTap: () {
                        var arguments = _insertArgument();

                        Navigator.of(context).pushReplacementNamed('/ration',
                            arguments: arguments);
                      },
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
                            child: Text('4/5',
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
                            fontSize: size.width * 0.045,
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
                              _decideView(size),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    await _openGallery();
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(150),
                                    ),
                                    child: Container(
                                        child: Icon(Icons.photo_camera,
                                            size: (size.width * 0.15) * 0.5,
                                            color: Color.fromRGBO(
                                                144, 143, 143, 1)),
                                        width: size.width * 0.15,
                                        height: size.width * 0.15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle)),
                                  ),
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
                Text('Próximo',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: size.width * 0.02),
                GestureDetector(
                  onTap: () {
                    var arguments = _insertArgument();

                    Navigator.of(context)
                        .pushReplacementNamed('/name', arguments: arguments);
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
