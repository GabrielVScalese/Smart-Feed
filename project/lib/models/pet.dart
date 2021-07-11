class Pet {
  int _id;
  String _name;
  String _animal;
  String _ration;
  String _size;
  String _device;
  String _image;

  Pet(this._id, this._name, this._animal, this._ration, this._size,
      this._device, this._image);

  Pet.SemIdConstr(this._name, this._animal, this._ration, this._size,
      this._device, this._image);

  getId() {
    return this._id;
  }

  getName() {
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
}
