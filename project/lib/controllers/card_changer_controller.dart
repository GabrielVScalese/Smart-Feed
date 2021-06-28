import 'package:flutter/widgets.dart';

class CardChangerController extends ChangeNotifier {
  Map value;

  CardChangerController();

  setValue(value) {
    this.value = value;
  }

  changeValue() {
    notifyListeners();
  }
}
