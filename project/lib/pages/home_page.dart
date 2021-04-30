import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  var devices = ['a', 'b', 'c'];

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
      body: Container(
        color: Color.fromRGBO(238, 243, 255, 1),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: 75,
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                child: Image.asset('assets/images/logo.png')),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 25, left: 30, bottom: 13),
              child: Text(
                'Dispositivo',
                style: GoogleFonts.lato(fontSize: 23.0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              alignment: Alignment.topLeft,
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 241, 105, 1),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    value: 'a',
                    isExpanded: true,
                    items:
                        devices.map<DropdownMenuItem<String>>((String value) {
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
                      setState(() {});
                    }),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 30, top: 10),
              child: Text(
                'Resumo',
                style: GoogleFonts.lato(fontSize: 23.0),
              ),
            ),
            Positioned(
                left: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 13),
                  height: 150,
                  width: 335,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(246, 241, 105, 1),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Column(children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        width: 310,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(188, 241, 255, 1),
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        child: Text('Bella',
                            style: GoogleFonts.lato(fontSize: 23.0))),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 14, top: 10),
                      child: Text(
                        'Pet: Cachorro',
                        style: GoogleFonts.lato(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 14, top: 6),
                      child: Text(
                        'Ração: Premium',
                        style: GoogleFonts.lato(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 14, top: 6),
                      child: Text(
                        'Porte: Grande',
                        style: GoogleFonts.lato(fontSize: 18),
                      ),
                    )
                  ]),
                )),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 30, top: 16),
              child: Text(
                'Histórico',
                style: GoogleFonts.lato(fontSize: 23.0),
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(153, 217, 217, 1),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: charts.BarChart(
                _seriesData,
                animate: true,
                animationDuration: Duration(seconds: 5),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 300,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pets,
              color: Colors.white,
            ),
            label: 'Informações',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Consumption {
  String date;
  int value;

  Consumption(this.date, this.value);
}
