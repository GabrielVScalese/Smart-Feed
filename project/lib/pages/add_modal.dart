import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPetModal extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const AddPetModal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: 'addModal',
            child: Material(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Novo Pet',
                            style: GoogleFonts.lato(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 30, right: 5),
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Imagem do pet: ',
                              style: GoogleFonts.lato(
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.only(top: 15, left: 30),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: InkWell(
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ]),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'New todo',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Write a note',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 6,
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 0.2,
                      ),
                      Container(
                        width: 350,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: Colors.blue,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Salvar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
