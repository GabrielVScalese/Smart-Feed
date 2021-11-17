import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String password;
  String imgUrl;

  User(this.name, this.email, {this.imgUrl = '', this.password = ''});

  User.fromAuth(this.id, this.name, this.email);

  User.fromLogin(String email, String password) {
    this.email = email;
    this.password = password;
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  int getId() {
    return this.id;
  }

  String getName() {
    return this.name;
  }

  String getEmail() {
    return this.email;
  }

  String getPassword() {
    return this.password;
  }

  String getImageUrl() {
    return this.imgUrl;
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(map['name'], map['email'], imgUrl: map['imgUrl']);
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
