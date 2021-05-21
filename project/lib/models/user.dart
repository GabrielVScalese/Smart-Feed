class User {
  String _name;
  String _email;
  String _password;

  User(this._name, this._email, this._password);

  // User(String _name, String _email, String _password) {
  //   setName(_name);
  //   setEmail(_email);
  //   setPassword(_password);
  // }

  User.fromUser(String _email, String _password) {
    this._email = _email;
    this._password = _password;
  }

  User.fromLogin(this._email, this._name);

  // setName(String _name) {
  //   if (_name.isEmpty) throw Exception('_name is invalid!');

  //   this._name = _name;
  // }

  // setEmail(String _email) {
  //   if (_email.isEmpty) throw Exception('_email is invalid!');

  //   this._email = _email;
  // }

  setPassword(String _password) {
    if (_password.isEmpty) throw Exception('_password is invalid!');

    this._password = _password;
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
}
