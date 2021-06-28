import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/circle_card.dart';
import 'package:project/components/page_title.dart';
import 'package:project/components/pet_card.dart';
import 'package:project/models/pet.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // margin: const EdgeInsets.only(bottom: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: CircleCard(
                              icon: Icon(Icons.settings_rounded),
                              size: size * 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PageTitle(size: size, title: "Seus Pets"),
                          GestureDetector(
                            onTap: () {},
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
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
                height: size.height * 0.06,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  elevation: 5,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
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
                child: Column(
                  children: [
                    PetCard(
                      size: size,
                      pet: Pet(
                          10,
                          "Maria",
                          "Cachorro",
                          "Premium",
                          "Grande",
                          "45654-SmartFeed",
                          "https://www.petz.com.br/blog/wp-content/uploads/2021/03/piercing-para-cachorro-2.jpg"),
                    ),
                    PetCard(
                      size: size,
                      pet: Pet(
                          10,
                          "Maria",
                          "Cachorro",
                          "Premium",
                          "Grande",
                          "45654-SmartFeed",
                          "https://www.petz.com.br/blog/wp-content/uploads/2021/03/piercing-para-cachorro-2.jpg"),
                    ),
                    PetCard(
                      size: size,
                      pet: Pet(
                          10,
                          "Maria",
                          "Cachorro",
                          "Premium",
                          "Grande",
                          "45654-SmartFeed",
                          "https://www.petz.com.br/blog/wp-content/uploads/2021/03/piercing-para-cachorro-2.jpg"),
                    ),
                    PetCard(
                      size: size,
                      pet: Pet(
                          10,
                          "Maria",
                          "Cachorro",
                          "Premium",
                          "Grande",
                          "45654-SmartFeed",
                          "https://www.petz.com.br/blog/wp-content/uploads/2021/03/piercing-para-cachorro-2.jpg"),
                    ),
                    PetCard(
                      size: size,
                      pet: Pet(
                          10,
                          "Maria",
                          "Cachorro",
                          "Premium",
                          "Grande",
                          "45654-SmartFeed",
                          "https://www.petz.com.br/blog/wp-content/uploads/2021/03/piercing-para-cachorro-2.jpg"),
                    ),
                    PetCard(
                      size: size,
                      pet: Pet(
                          10,
                          "Maria",
                          "Cachorro",
                          "Premium",
                          "Grande",
                          "45654-SmartFeed",
                          "https://www.petz.com.br/blog/wp-content/uploads/2021/03/piercing-para-cachorro-2.jpg"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
