import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/add_pet_structure.dart';
import 'package:project/components/text_field_container.dart';

class NameAddPet extends StatefulWidget {
  @override
  _NameAddPetState createState() => _NameAddPetState();
}

class _NameAddPetState extends State<NameAddPet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AddPetStructure(
      size: size,
      title: 'Nome',
      subTitle: 'Digite o nome do pet',
      page: 4,
      cardSliders: null,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.13,
          ),
          Align(
            child: new TextFieldContainer(
              size: size,
              textField: TextField(
                style: GoogleFonts.inter(fontSize: size.width * 0.9 * 0.045),
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.inter(
                        color: Color.fromRGBO(186, 184, 184, 1)),
                    hintText: 'Nome',
                    prefixIcon:
                        Icon(Icons.person, size: size.width * 0.9 * 0.06),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
      buttonText: 'Próximo',
    );
  }
}
