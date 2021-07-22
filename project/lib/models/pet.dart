class Pet {
  int _id;
  int _userId;
  String _name;
  String _animal;
  String _ration;
  String _size;
  String _device;
  String _image;

  Pet(this._id, this._userId, this._name, this._animal, this._ration,
      this._size, this._device, this._image);

  Pet.fromRegister(this._userId, this._name, this._animal, this._ration,
      this._size, this._device, this._image);

  getId() {
    return this._id;
  }

  getUserId() {
    return this._userId;
  }

  String getName() {
    return this._name;
  }

  getAnimal() {
    return this._animal;
  }

  getRation() {
    return this._ration;
  }

  getSize() {
    return this._size;
  }

  getDevice() {
    return this._device;
  }

  getImage() {
    return this._image;
  }

  static Pet fromMap(Map map) {
    return Pet(map['id'], map['user_id'], map['name'], map['animal'],
        map['ration'], map['size'], map['device'], map['image']);
  }

  static Map toMap(Pet pet) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = pet.getId();
    data['name'] = pet.getName();
    data['animal'] = pet.getAnimal();
    data['ration'] = pet.getRation();
    data['size'] = pet.getSize();
    data['device'] = pet.getDevice();
    data['image'] = pet.getImage();

    return data;
  }
}
