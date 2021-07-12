import 'package:flutter/widgets.dart';

class CardChangerController extends ChangeNotifier {
  Map _value;

  getValue() {
    return this._value;
  }

  setValue(value) {
    this._value = value;
  }

  changeValue() {
    notifyListeners();
  }
}
