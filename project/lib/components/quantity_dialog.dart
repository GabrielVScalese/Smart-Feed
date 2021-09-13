import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/dialog_helper.dart';
import 'package:project/components/rounded_button.dart';

class QuantityDialog extends StatefulWidget {
  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  TextEditingController quantityController = new TextEditingController();
  int quantity = 50;

  @override
  Widget build(BuildContext context) {
    quantityController.text = '$quantity';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 280,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Align(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Quantidade (g)',
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        DialogHelper.infoModal(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 25),
                          child: Icon(Icons.error_outline)),
                    ),
                  ]),
            ),
            SizedBox(
              height: 23,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              BoxCard(
                height: 100,
                width: 200,
                child: Align(
                  child: TextField(
                      onChanged: (value) {
                        if (value.isNotEmpty) this.quantity = int.parse(value);
                        print(this.quantity);
                      },
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.inter(
                          fontSize: 28, fontWeight: FontWeight.bold),
                      controller: quantityController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      )),
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (this.quantity != 500) this.quantity += 50;
                        quantityController.text = '$quantity';
                      });
                    },
                    child: BoxCard(
                      height: 50,
                      width: 50,
                      child: Align(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (this.quantity != 50) this.quantity -= 50;

                        quantityController.text = '$quantity';
                      });
                    },
                    child: BoxCard(
                      height: 50,
                      width: 50,
                      child: Align(
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Align(
              child: RoundedButton(
                height: 45,
                width: 260,
                text: 'APLICAR',
                radius: 10,
              ),
            ),
          ],
        ),
      );
}

class BoxCard extends StatelessWidget {
  const BoxCard(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.child})
      : super(key: key);

  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Container(
            height: this.height, width: this.width, child: this.child));
  }
}
