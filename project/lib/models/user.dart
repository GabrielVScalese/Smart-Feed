import 'dart:convert';

class User {
  int _id;
  String _name;
  String _email;
  String _password;

  User(this._id, this._name, this._email, [this._password = '']);

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

  static User fromMap(Map<String, dynamic> map) {
    User(map['id'], map['name'], map['email']);
  }

  static Map<String, dynamic> toMap(User user) => {
        "name": user.getName(),
        "email": user.getEmail(),
        "password": user.getPassword()
      };

  // String toJson() => jsonEncode(toMap());

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));
}
