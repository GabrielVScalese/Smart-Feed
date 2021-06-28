import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/components/add_pet_structure.dart';

class PhotoAddPet extends StatefulWidget {
  @override
  _PhotoAddPetState createState() => _PhotoAddPetState();
}

class _PhotoAddPetState extends State<PhotoAddPet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AddPetStructure(
      size: size,
      title: 'Foto',
      subTitle: 'Escolha uma foto',
      page: 5,
      cardSliders: null,
      child: Stack(
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
                                  color: Color.fromRGBO(144, 143, 143, 1)),
                              width: size.width * 0.15,
                              height: size.width * 0.15,
                              decoration:
                                  BoxDecoration(shape: BoxShape.circle)),
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
      buttonText: 'Finalizar',
    );
  }
}
