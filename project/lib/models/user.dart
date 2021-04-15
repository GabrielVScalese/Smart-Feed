class User {
  String name;
  String email;
  String password;

  User(String name, String email, String password) {
    setName(name);
    setEmail(email);
    setPassword(password);
  }

  User.fromUser(String email, String password) {
    this.email = email;
    this.password = password;
  }

  setName(String name) {
    if (name.isEmpty) throw Exception('Name is invalid!');

    this.name = name;
  }

  setEmail(String email) {
    if (email.isEmpty) throw Exception('Email is invalid!');

    this.email = email;
  }

  setPassword(String password) {
    if (password.isEmpty) throw Exception('Password is invalid!');

    this.password = password;
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
}
