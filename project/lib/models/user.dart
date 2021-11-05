import 'dart:convert';

class User {
  int _id;
  String _name;
  String _email;
  String _password;
  String _imgUrl;

  User(this._name, this._email, [this._imgUrl = '', this._password = '']);

  User.fromAuth(this._id, this._name, this._email);

  User.fromLogin(String email, String password) {
    this._email = email;
    this._password = password;
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  int getId() {
    return this._id;
  }

  String getName() {
    return this._name;
  }

  String getEmail() {
    return this._email;
  }

  String getPassword() {
    return this._password;
  }

  String getImageUrl() {
    return this._imgUrl;
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(map['name'], map['email'], map['imgUrl']);
  }

  static Map<String, dynamic> toMap(User user) {
    var map = {
      "name": user.getName(),
      "email": user.getEmail(),
      "imgUrl": user.getImageUrl(),
      "password": user.getPassword(),
    };

    if (map['password'] == '') {
      map.remove("password");
    }

    return map;
  }

  String toJson(User user) => jsonEncode(toMap(user));
}
