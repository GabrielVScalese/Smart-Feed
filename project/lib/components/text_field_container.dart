import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key key,
    @required this.size,
    @required this.textField,
  }) : super(key: key);

  final Size size;
  final TextField textField;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
          height: size.height * 0.070,
          width: size.width * 0.9,
          padding: EdgeInsets.all(size.width * 0.9 * 0.02),
          child: textField),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
