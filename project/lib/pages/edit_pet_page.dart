import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project/models/pet.dart';
import 'package:project/models/repositories/pet_repository.dart';
import 'package:project/models/repositories/user_repository.dart';
import 'package:project/pages/home_page.dart';

import 'loading_page.dart';

class EditPet extends StatefulWidget {
  var pet;
  var user;

  EditPet(this.user, this.pet);

  @override
  _EditPetState createState() => _EditPetState(this.user, this.pet);
}

class _EditPetState extends State<EditPet> {
  File imgFile;
  var img64;

  var nameController = new TextEditingController();
  var animalTypes = ['Cachorro', 'Gato'];
  var animalType = 'Cachorro';
  var rationController = new TextEditingController();
  var sizeController = new TextEditingController();

  var pet;
  var user;
  var loaded = true;

  _EditPetState(this.user, this.pet);

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
    if (imgFile == null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: NetworkImage(
              this.pet.getImg(),
            ),
            fit: BoxFit.fill,
          ),
        ),
      );
    } else {
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
  void initState() {
    super.initState();

    nameController.text = this.widget.pet.getName();
    rationController.text = this.widget.pet.getRation();
    sizeController.text = this.widget.pet.getSize();
    animalType = this.widget.pet.getAnimal();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Hero(
        tag: 'addPetPage',
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Editando ' + this.pet.getName(),
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
              child: Container(
                alignment: Alignment.center,
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    alignment: Alignment.center,
                    child: Text(
                      'Imagem do Pet',
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
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 150,
                            margin: const EdgeInsets.only(top: 30, left: 38),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color.fromRGBO(42, 48, 101, 1),
                            ),
                            child: TextButton(
                              child: Text(
                                'Salvar',
                                style: GoogleFonts.lato(
                                    color: Colors.white, fontSize: 22),
                              ),
                              onPressed: () async {
                                setState(() {
                                  loaded = false;
                                });

                                var imgLink = null;

                                if (imgFile == null)
                                  imgLink = this.pet.getImg();
                                else
                                  imgLink = await _uploadImage(img64);

                                await PetRepository.updatePet(
                                  Pet(
                                      this.pet.getId(),
                                      nameController.text,
                                      animalType,
                                      rationController.text,
                                      sizeController.text,
                                      '',
                                      imgLink.toString()),
                                );

                                loaded = true;

                                var pets = null;

                                Navigator.popUntil(context, (route) => false);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(pets, this.user)));
                              },
                            )),
                        Container(
                            margin: const EdgeInsets.only(top: 30, left: 30),
                            height: 56,
                            width: 150,
                            child: Card(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      loaded = false;
                                    });

                                    await PetRepository.deletePet(
                                        this.pet.getId());

                                    loaded = true;

                                    var pets = null;

                                    Navigator.popUntil(
                                        context, (route) => false);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage(pets, this.user)));
                                  },
                                  child: Text('Excluir',
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 22))),
                            ))
                      ],
                    ),
                  ),
                ]),
              ),
            )),
      );
    } else {
      return LoadingPage.Build();
    }
  }
}
