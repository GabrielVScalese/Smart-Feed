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

  static User fromMap(Map<String, dynamic> map) {
    User(map['id'], map['name'], map['email']);
  }

  static Map<String, dynamic> toMap(User user) => {
        "name": user.getName(),
        "email": user.getEmail(),
        "password": user.getPassword()
      };

  String toJson(User user) => jsonEncode(toMap(user));
}
