import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/components/dialog_helper.dart';
import 'package:project/components/rounded_button.dart';
import 'package:project/controllers/feed_controller.dart';
import 'package:project/utils/app_colors.dart';

class QuantityDialog extends StatefulWidget {
  FeedController feedController;

  QuantityDialog({this.feedController});

  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

var appColors;

class _QuantityDialogState extends State<QuantityDialog> {
  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadTheme().then((data) {});
    super.initState();
  }

  TextEditingController quantityController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    quantityController.text = '${this.widget.feedController.getQuantity()}';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: appColors.instance ? 0 : 10,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 280,
        decoration: BoxDecoration(
            color: appColors.backgroundColorModal(),
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
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: appColors.textColor()),
                    ),
                    GestureDetector(
                      onTap: () {
                        DialogHelper.infoModal(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 25),
                          child: Icon(
                            Icons.error_outline,
                            color: appColors.iconButtonColor(),
                          )),
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
                        if (value.isNotEmpty)
                          this
                              .widget
                              .feedController
                              .changeQuantity(int.parse(value));
                      },
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
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
                        if (this.widget.feedController.getQuantity() != 500)
                          this.widget.feedController.changeQuantity(
                              this.widget.feedController.getQuantity() + 50);
                        quantityController.text =
                            '${this.widget.feedController.getQuantity()}';
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
                        if (this.widget.feedController.getQuantity() != 50)
                          this.widget.feedController.changeQuantity(
                              this.widget.feedController.getQuantity() - 50);

                        quantityController.text =
                            '${this.widget.feedController.getQuantity()}';
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RoundedButton(
                  height: 45,
                  width: 260,
                  text: 'APLICAR',
                  radius: 10,
                  backgroundColor: Color.fromRGBO(0, 153, 255, 1),
                ),
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
        color: appColors.buttonBackgroundColor(),
        elevation: appColors.instance ? 0 : 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: appColors.cardColor(), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Container(
            height: this.height, width: this.width, child: this.child));
  }
}
