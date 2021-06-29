import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String password;

  User(this.id, this.name, this.email);

  // User(String name, String email, String password) {
  //   setName(name);
  //   setEmail(email);
  //   setPassword(password);
  // }

  User.fromAuth({this.email, this.password});

  User.fromUser(String email, String password) {
    this.email = email;
    this.password = password;
  }

  User.fromRegister(this.name, this.email, this.password);

  // setName(String name) {
  //   if (name.isEmpty) throw Exception('name is invalid!');

  //   this.name = name;
  // }

  // setEmail(String email) {
  //   if (email.isEmpty) throw Exception('email is invalid!');

  //   this.email = email;
  // }

  setPassword(String password) {
    this.password = password;
  }

  getId() {
    return this.id;
  }

  getName() {
    return this.name;
  }

  getEmail() {
    return this.email;
  }

  getPassword() {
    return this.password;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User.fromAuth(email: map["email"], password: map["password"]);
  }

  factory User.fromJson(String json) => User.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
      };

  String toJson() => jsonEncode(toMap());
}
