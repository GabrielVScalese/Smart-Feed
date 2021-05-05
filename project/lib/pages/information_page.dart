import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  List<String> devices = ['aabecerasd', 'b', 'c'];

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
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Bella',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Dispositivo',
                style: GoogleFonts.lato(fontSize: 23),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        value: 'aabecerasd',
                        isExpanded: true,
                        items: devices
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
                          setState(() {});
                        }),
                  )),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Dados',
                style: GoogleFonts.lato(fontSize: 23),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    print('ok');
                  },
                  child: Column(children: [
                    Container(
                        alignment: Alignment.topCenter,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.only(right: 10.0, top: 14),
                        child: Image.asset('assets/images/logo.png')),
                    Container(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              child: Icon(Icons.pets, size: 24),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Bella',
                                style: GoogleFonts.lato(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              child: Icon(Icons.pets, size: 24),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Cachorro',
                                style: GoogleFonts.lato(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              child: Icon(Icons.restaurant_menu, size: 24),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Premium',
                                style: GoogleFonts.lato(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              child: Icon(Icons.aspect_ratio, size: 24),
                              margin: EdgeInsets.only(left: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Grande',
                                style: GoogleFonts.lato(fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    )
                  ]),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Histórico',
                style: GoogleFonts.lato(fontSize: 23),
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/historic');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: charts.BarChart(_seriesData,
                          animate: true,
                          animationDuration: Duration(seconds: 5)),
                    )),
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
