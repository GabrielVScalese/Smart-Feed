class User {
  int _id;
  String _name;
  String _email;
  String _password;

  User(this._id, this._name, this._email);

  // User(String _name, String _email, String _password) {
  //   setName(_name);
  //   setEmail(_email);
  //   setPassword(_password);
  // }

  User.fromUser(String _email, String _password) {
    this._email = _email;
    this._password = _password;
  }

  User.fromRegister(this._name, this._email, this._password);

  // setName(String _name) {
  //   if (_name.isEmpty) throw Exception('_name is invalid!');

  //   this._name = _name;
  // }

  // setEmail(String _email) {
  //   if (_email.isEmpty) throw Exception('_email is invalid!');

  //   this._email = _email;
  // }

  setPassword(String password) {
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
}
