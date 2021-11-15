import 'package:project/models/feed.dart';

class Pet {
  int _id;
  int _userId;
  String _name;
  String _animal;
  String _ration;
  String _size;
  String _device;
  String _image;
  Feed _feed;

  Pet(this._id, this._userId, this._name, this._animal, this._ration,
      this._size, this._device, this._image, this._feed);

  Pet.fromRegister(this._userId, this._name, this._animal, this._ration,
      this._size, this._device, this._image);

  int getId() {
    return this._id;
  }

  int getUserId() {
    return this._userId;
  }

  String getName() {
    return this._name;
  }

  String getAnimal() {
    return this._animal;
  }

  String getRation() {
    return this._ration;
  }

  String getSize() {
    return this._size;
  }

  String getDevice() {
    return this._device;
  }

  String getImage() {
    return this._image;
  }

  Feed getFeed() {
    return this._feed;
  }

  static Pet fromMap(Map<String, dynamic> map) {
    return Pet(
        map['id'],
        map['user_id'],
        map['name'],
        map['animal'],
        map['ration'],
        map['size'],
        map['device'],
        map['image'],
        Feed.fromMap(map['feed']));
  }

  static Map<String, dynamic> toMap(Pet pet) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = pet.getUserId();
    data['name'] = pet.getName();
    data['animal'] = pet.getAnimal();
    data['ration'] = pet.getRation();
    data['size'] = pet.getSize();
    data['device'] = pet.getDevice();
    data['image'] = pet.getImage();

    return data;
  }
}
