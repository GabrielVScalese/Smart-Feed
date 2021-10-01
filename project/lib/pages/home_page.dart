import 'dart:convert';
import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/pet_card.dart';
import 'package:project/components/shimmer_widget.dart';
import 'package:project/models/pet.dart';
import 'package:project/pages/configurations/configuration_page.dart';
import 'package:project/pages/information_page.dart';
import 'package:project/repositories/feeds_repository.dart';
import 'package:project/repositories/pets_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addPet/type_add_pet.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

// IMPORTANTE: CORRIGIR ERRO HOME PAGE -> INFORMATION PAGE (DEPOIS DE INPUT)
class _HomePageState extends State<HomePage> {
  var _petList = [];
  var _feedList = [];
  var _dynamicPetList = [];
  var _isLoading = true;

  var namePetController = new TextEditingController();

  _loadData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var user = jsonDecode(prefs.getString('user'));

      var feedsRepository = new FeedsRepository();
      _feedList = await feedsRepository.findByOwner(user['id']);

      var petsRepository = PetsRepository();
      _petList = await petsRepository.findByOwner(user['id']);
      _dynamicPetList = _petList;

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  _findPetsByValue(String value) {
    var pets = [];
    for (Pet pet in _petList) {
      if (pet.getName().toLowerCase().startsWith(value.toLowerCase()))
        pets.add(pet);
    }

    return pets;
  }

  @override
  void initState() {
    super.initState();

    _loadData().then((data) {});
  }

  Widget getPets(size) {
    if (_petList.isEmpty) {
      return AnimatedCard(
        direction: AnimatedCardDirection.bottom,
        child: Container(
          width: size.width,
          height: size.height * 0.67,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Você ainda não",
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Image.asset(
                'assets/images/noPets.png',
                scale: 1.5,
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              Text(
                "possui nenhum pet",
                style: GoogleFonts.inter(
                    fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        itemCount: _isLoading ? 1 : _dynamicPetList.length,
        itemBuilder: (BuildContext context, index) {
          if (_isLoading)
            return buildPetCardShimmer(size);
          else
            return AnimatedCard(
              direction: index % 2 == 0
                  ? AnimatedCardDirection.left
                  : AnimatedCardDirection.right,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InformationPage(
                            pet: _petList[index],
                            feed: _feedList[index],
                          )));
                },
                child: PetCard(
                  size: size,
                  pet: _dynamicPetList[index],
                ),
              ),
            );
        },
      );
  }

  buildPetCardShimmer(size) => Container(
        margin: EdgeInsets.only(
            left: size.width * 0.03,
            right: size.width * 0.03,
            bottom: size.height * 0.015),
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ShimmerWidget.circular(
                        width: size.width * 0.2, height: size.width * 0.2)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: size.width * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ShimmerWidget.rectangular(
                            width: size.width * 0.15,
                            height: size.height * 0.015),
                        ShimmerWidget.rectangular(
                            width: size.width * 0.5,
                            height: size.height * 0.015),
                        ShimmerWidget.rectangular(
                            width: size.width * 0.17,
                            height: size.height * 0.015),
                      ],
                    ),
                  ),
                )
              ],
            )),
      );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Cor do texto do input
    var inputColor = Color.fromRGBO(186, 184, 184, 1);

    // Shimmer Effect para o carregamento de cards dos pets

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfigurationPage()));
                            },
                            child: CircleCard(
                              icon: Icon(Icons.settings_rounded),
                              size: size * 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 15.0, bottom: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Seus Pets',
                              style: GoogleFonts.inter(
                                  fontSize: size.width * 0.067,
                                  fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => TypeAddPet()));
                            },
                            child: CircleCard(
                              icon: Icon(Icons.add),
                              size: size * 0.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedCard(
                direction: AnimatedCardDirection.left,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
                  height: size.height * 0.06,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    elevation: 5,
                    child: Container(
                      // padding: EdgeInsets.only(top: size.width * 0.9 * 0.0066),

                      child: TextField(
                        controller: namePetController,
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty)
                              this._dynamicPetList = this._petList;
                            else
                              this._dynamicPetList = _findPetsByValue(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Buscar",
                          hintStyle: GoogleFonts.inter(
                              color: Color.fromRGBO(186, 184, 184, 1)),
                          prefixIcon: Icon(Icons.search,
                              size: size.width * 0.05, color: inputColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Container(
                  height: size.height * 0.7,
                  child: getPets(size),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
