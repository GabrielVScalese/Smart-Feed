import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(238, 243, 255, 1),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  height: 70,
                  margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                  child: Image.asset('assets/images/logo.png')),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 25, left: 30),
                child: Text(
                  'Dispositivo',
                  style: GoogleFonts.lato(fontSize: 23.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                alignment: Alignment.topLeft,
                height: 80,
                width: 364,
                child: DropdownButton<String>(
                    value: 'a',
                    isExpanded: true,
                    items:
                        devices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {});
                    }),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  'Resumo',
                  style: GoogleFonts.lato(fontSize: 23.0),
                ),
              ),
              Positioned(
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
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
                margin: const EdgeInsets.only(left: 30, top: 30),
                child: Text(
                  'Histórico',
                  style: GoogleFonts.lato(fontSize: 23.0),
                ),
              )
            ],
          ),
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
