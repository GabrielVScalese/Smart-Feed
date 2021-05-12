import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:project/models/hero_dialog_route.dart';
import 'package:project/pages/information_page.dart';
import 'package:project/pages/add_modal.dart';
import 'package:project/pages/add_pet_page.dart';

class HomePage extends StatefulWidget {
  var pets = [];

  HomePage(this.pets);

  @override
  _HomePageState createState() => _HomePageState(this.pets);
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  var devices = ['aabecerasd', 'b', 'c'];
  var pets = [];

  _HomePageState(this.pets);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<charts.Series<Consumption, String>> _seriesData;

  _generateData() {
    var data = [
      new Consumption('10/03', 16),
      new Consumption('11/03', 23),
      new Consumption('12/03', 28),
      new Consumption('13/03', 14),
      new Consumption('14/03', 19),
      new Consumption('15/03', 23),
    ];

    _seriesData.add(charts.Series<Consumption, String>(
      id: 'Consumption',
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
      domainFn: (Consumption sales, _) => sales.date,
      measureFn: (Consumption sales, _) => sales.value,
      data: data,
      fillPatternFn: (_, __) => charts.FillPatternType.solid,
    ));
  }

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _seriesData = List<charts.Series<Consumption, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Hero(tag: 'addModal', child: Icon(Icons.add)),
      //   onPressed: () {
      //     Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      //       return const AddPetModal();
      //     }));
      //   },
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Seus Pets',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 700,
              child: ListView.builder(
                itemCount: pets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      margin: EdgeInsets.only(bottom: 15),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  InformationPage(pets[index])));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topCenter,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 30.0),
                                  child: Image.asset('assets/images/logo.png')),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  this.pets[index].getName(),
                                  style: GoogleFonts.lato(fontSize: 22),
                                ),
                              )
                            ],
                          ),
                          height: 200,
                        ),
                      ));
                },
                padding: EdgeInsets.only(left: 30, right: 30, top: 25),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return AddPet();
                    }));
                  },
                  child: Hero(
                    tag: 'addPetPage',
                    child: Material(
                      color: Colors.blue,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Consumption {
  String date;
  int value;

  Consumption(this.date, this.value);
}
