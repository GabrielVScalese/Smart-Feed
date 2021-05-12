import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/pet.dart';
import 'package:project/models/pet_repository.dart';

class AddPet extends StatefulWidget {
  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  var animalTypes = ['Cachorro', 'Gato'];

  File imageFile;
  var picBytes;

  var nameController = new TextEditingController();
  var animalType = 'Cachorro';
  var rationController = new TextEditingController();
  var sizeController = new TextEditingController();

  Future<void> _openGallery() async {
    try {
      var picture =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);

      setState(() {
        imageFile = picture as File;
        _decideImageView();
      });

      List imageBytes = await picture.readAsBytes();

      var icPicBytes = base64Encode(imageBytes);
      return icPicBytes;
    } catch (error) {}
  }

  Widget _decideImageView() {
    print('imagem : $imageFile');
    if (imageFile == null)
      return Icon(
        Icons.add_photo_alternate_outlined,
        size: 50,
      );
    else {
      return Image.file(
        imageFile,
        width: 300,
        height: 100,
      );
    }
  }

  _uploadImage(picBytes) async {
    var clientID = '2f7307ddc860abf'; // your client id
    var jsonData = json.encode({'image': picBytes});

    var response = await http.post(
        Uri.parse(
          'https://api.imgur.com/3/image',
        ),
        body: jsonData,
        headers: {
          "Authorization": 'Client-ID $clientID',
          "Content-Type": "application/json"
        });

    var map = json.decode(response.body);
    return map['data']['link'];
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'addPetPage',
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Novo Pet',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 35),
              alignment: Alignment.center,
              child: Text(
                'Adicione uma imagem',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Card(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: InkWell(
                  child: Container(
                      width: 300,
                      height: 100,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: _decideImageView()),
                  onTap: () {
                    picBytes = _openGallery();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: TextField(
                controller: nameController,
                style: GoogleFonts.lato(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Digite o nome',
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      value: animalType,
                      isExpanded: true,
                      items: animalTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          animalType = value;
                        });
                      }),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: TextField(
                controller: rationController,
                style: GoogleFonts.lato(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.restaurant_menu_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Digite o tipo da ração',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: TextField(
                controller: sizeController,
                style: GoogleFonts.lato(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.aspect_ratio_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Digite o porte do pet',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 190,
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.blue,
              ),
              child: TextButton(
                child: Text(
                  'Salvar',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 22),
                ),
                onPressed: () async {
                  var imgLink = _uploadImage(picBytes);
                  await PetRepository.insertPet(Pet(
                      nameController.text,
                      animalType,
                      rationController.text,
                      sizeController.text,
                      '',
                      imgLink));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
