import 'package:flutter/cupertino.dart';

class ImageController extends ChangeNotifier {
  var image;

  changeImage(image) {
    this.image = image;
    notifyListeners();
  }
}
