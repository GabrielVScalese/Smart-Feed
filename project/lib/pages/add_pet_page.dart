import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project/models/pet.dart';
import 'package:project/models/repositories/pet_repository.dart';
import 'package:project/models/repositories/user_repository.dart';
import 'package:project/pages/home_page.dart';

class AddPet extends StatefulWidget {
  var user;

  AddPet(this.user);

  @override
  _AddPetState createState() => _AddPetState(this.user);
}

class _AddPetState extends State<AddPet> {
  File imgFile;
  var img64;

  var nameController = new TextEditingController();
  var animalTypes = ['Cachorro', 'Gato'];
  var animalType = 'Cachorro';
  var rationController = new TextEditingController();
  var sizeController = new TextEditingController();

  var user;

  _AddPetState(this.user);

  _openGallery() async {
    try {
      var imgPicker = ImagePicker();
      var pickedFile = await imgPicker.getImage(source: ImageSource.gallery);

      setState(() {
        imgFile = File(pickedFile.path);
      });

      var bytes = await pickedFile.readAsBytes();
      img64 = base64Encode(bytes);
    } catch (error) {}
  }

  Widget _decideImageView() {
    if (imgFile == null)
      return Icon(
        Icons.add_photo_alternate_outlined,
        size: 50,
      );
    else {
      return Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          image: DecorationImage(
            image: FileImage(imgFile),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  _uploadImage(img64) async {
    var clientID = '2f7307ddc860abf';
    var jsonData = json.encode({'image': img64});

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
              margin: EdgeInsets.only(top: 25),
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
                      width: 300, height: 180, child: _decideImageView()),
                  onTap: () async {
                    await _openGallery();
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
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color.fromRGBO(42, 48, 101, 1),
              ),
              child: TextButton(
                child: Text(
                  'Salvar',
                  style: GoogleFonts.lato(color: Colors.white, fontSize: 22),
                ),
                onPressed: () async {
                  var imgLink = await _uploadImage(img64);
                  await PetRepository.insertPet(
                    this.user.getEmail(),
                    Pet(nameController.text, animalType, rationController.text,
                        sizeController.text, '', imgLink),
                  );

                  var pets = await PetRepository.findPetsByUserEmail(
                      this.user.getEmail());

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(pets, this.user)));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
