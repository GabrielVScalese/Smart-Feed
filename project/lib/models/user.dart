import 'dart:convert';

class User {
  int _id;
  String _name;
  String _email;
  String _password;

  User(this._id, this._name, this._email, this._password);

  User.fromAuth(this._id, this._name, this._email);

  User.fromLogin(String email, String password) {
    this._email = email;
    this._password = password;
  }

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
    return User.fromAuth(map['id'], map["name"], map["email"]);
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": _id,
        "name": _name,
        "email": _email,
      };

  String toJson() => jsonEncode(toMap());
}
