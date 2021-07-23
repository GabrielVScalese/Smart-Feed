import 'package:flutter/widgets.dart';

class CardChangerController extends ChangeNotifier {
  Map<String, dynamic> _value;

  Map<String, dynamic> getValue() {
    return this._value;
  }

  void setValue(value) {
    this._value = value;
  }

  void changeValue() {
    notifyListeners();
  }
}
