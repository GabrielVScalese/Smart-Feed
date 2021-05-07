class Pet {
  String _name;
  String _animal;
  String _ration;
  String _size;
  String _device;

  Pet(this._name, this._animal, this._ration, this._size, this._device);

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
}
