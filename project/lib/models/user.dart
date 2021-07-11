import 'dart:convert';

class User {
  int _id;
  String _name;
  String _email;
  String _password;

  User(this._id, this._name, this._email);

  User.fromAuth(this._email, this._password);

  User.fromLogin(String _email, String password) {
    this._email = _email;
    this._password = password;
  }

  // set_name(String _name) {
  //   if (_name.isEmpty) throw Exception('_name is inval_id!');

  //   this._name = _name;
  // }

  // set_email(String _email) {
  //   if (_email.isEmpty) throw Exception('_email is inval_id!');

  //   this._email = _email;
  // }

  // setPassword(String password) {
  //   this.password = password;
  // }

  getId() {
    return this._id;
  }

  getName() {
    return this._name;
  }

  getEmail() {
    return this._email;
  }

  getPassword() {
    return this._password;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User.fromAuth(map["_email"], map["password"]);
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": _id,
        "name": _name,
        "email": _email,
      };

  String toJson() => jsonEncode(toMap());
}
