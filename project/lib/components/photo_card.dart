import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/controllers/image_controller.dart';
import 'package:project/utils/app_colors.dart';

class PhotoCard extends StatefulWidget {
  var initialImage;
  ImageController imageController;

  PhotoCard({this.initialImage, this.imageController});

  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  var _imgFile;
  var appColors;

  _openGallery() async {
    try {
      var imgPicker = ImagePicker();
      var pickedFile = await imgPicker.getImage(source: ImageSource.gallery);

      setState(() {
        this._imgFile = File(pickedFile.path);
        this.widget.imageController.changeImage(this._imgFile);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  _decideView(size) {
    print(this._imgFile);
    if (_imgFile != null)
      return Center(
        child: Container(
          width: size.width * 0.5,
          height: size.width * 0.5,
          child: ClipOval(
            child: Image.file(
              _imgFile,
              fit: BoxFit.cover,
              // scale: size.height * 0.2,
            ),
          ),
        ),
      );
    else
      return Center(
        child: Container(
          width: size.width * 0.5,
          height: size.width * 0.5,
          child: ClipOval(
            child: Image.network(
              this.widget.initialImage,
              fit: BoxFit.cover,
              scale: 0.1,
              height: size.width * 0.01,
              width: size.width * 0.01,
              // scale: size.height * 0.2,
            ),
          ),
        ),
      );
  }

  loadTheme() async {
    appColors = new AppColors();
    await appColors.initialize();

    setState(() {});
  }

  @override
  void initState() {
    loadTheme().then((data) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      child: Container(
          child: Stack(
            children: [
              _decideView(size),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () async {
                    await _openGallery();
                  },
                  child: Card(
                    color: appColors.cardColor(),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: Container(
                        child: Icon(Icons.photo_camera,
                            size: (size.width * 0.15) * 0.5,
                            color: appColors.cameraIconColor()),
                        width: size.width * 0.15,
                        height: size.width * 0.15,
                        decoration: BoxDecoration(shape: BoxShape.circle)),
                  ),
                ),
              )
            ],
          ),
          width: size.width * 0.5,
          height: size.width * 0.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          )),
    );
  }
}
