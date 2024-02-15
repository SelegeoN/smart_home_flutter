import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'device.dart';
import 'category.dart';

class HomeDevices extends ChangeNotifier {
  final List<Device> _devices = [
    Device(
        category: 0,
        name: "Свет 1",
        imagePath: 'lib/icons/light-bulb.png',
        description: "Вау это такой мега умный свет 1 что просто жесть",
        isActive: false),
    Device(
        category: 0,
        name: "Свет 2",
        imagePath: 'lib/icons/light-bulb.png',
        description: "Вау это такой мега умный свет 2 что просто жесть",
        isActive: false),
    Device(
        category: 0,
        name: "Свет 3",
        imagePath: 'lib/icons/light-bulb.png',
        description: "Вау это такой мега умный свет 3 что просто жесть",
        isActive: false),
    Device(
        category: 1,
        name: "Кондей 1",
        imagePath: 'lib/icons/air-conditioner.png',
        description: "Вау это такой мега умный кондей 1 что просто жесть",
        isActive: false),
    Device(
        category: 1,
        name: "Кондей 2",
        imagePath: 'lib/icons/air-conditioner.png',
        description: "Вау это такой мега умный кондей 2 что просто жесть",
        isActive: false),
    Device(
        category: 2,
        name: "Телек 1",
        imagePath: 'lib/icons/smart-tv.png',
        description: "Вау это такой мега умный телек 1 что просто жесть",
        isActive: false),
    Device(
        category: 2,
        name: "Телек 2",
        imagePath: 'lib/icons/smart-tv.png',
        description: "Вау это такой мега умный телек 2 что просто жесть",
        isActive: false),
    Device(
        category: 2,
        name: "Телек 3",
        imagePath: 'lib/icons/smart-tv.png',
        description: "Вау это такой мега умный телек 3 что просто жесть",
        isActive: false),
    Device(
        category: 2,
        name: "Телек 4",
        imagePath: 'lib/icons/smart-tv.png',
        description: "Вау это такой мега умный телек 4 что просто жесть",
        isActive: false),
    Device(
        category: 3,
        name: "Вентилятор 1",
        imagePath: 'lib/icons/fan.png',
        description: "Вау это такой мега умный вентилятор 1 что просто жесть",
        isActive: false),
    Device(
        category: 3,
        name: "Вентилятор 2",
        imagePath: 'lib/icons/fan.png',
        description: "Вау это такой мега умный вентилятор 2 что просто жесть",
        isActive: false),
    Device(
        category: 3,
        name: "Вентилятор 3",
        imagePath: 'lib/icons/fan.png',
        description: "Вау это такой мега умный вентилятор 3 что просто жесть",
        isActive: false),
    Device(
        category: 3,
        name: "Вентилятор 4",
        imagePath: 'lib/icons/fan.png',
        description: "Вау это такой мега умный вентилятор 4 что просто жесть",
        isActive: false),
    Device(
        category: 3,
        name: "Вентилятор 5",
        imagePath: 'lib/icons/fan.png',
        description: "Вау это такой мега умный вентилятор 5 что просто жесть",
        isActive: false),
  ];

  //категории
  final List<Category> _categories = [
    Category(index: 0, name: 'Свет'),
    Category(index: 1, name: 'Кондиционеры'),
    Category(index: 2, name: 'Телевизоры'),
    Category(index: 3, name: 'Вентиляторы'),
  ];

  //настройки
  String _userName = '';
  int _gridCount = 2;
  double _fontSize = 15;
  double _imageHeight = 70;
  bool _listView = false;

  //устройства пользователя
  List<Device> _userDevices = [];

  //все устройства
  List<Device> get devices => _devices;

  List<Device> getCategoryList(int index) {
    List<Device> outputList = _devices.where((item) => item.category == index).toList();
    return outputList;
  }

  //все категории
  List<Category> get categories => _categories;

  //устройства пользователя
  List<Device> get userDevices => _userDevices;

  //получение имени
  String get userName => _userName;

  //получение настроек
  int get gridCount => _gridCount;
  double get fontSize => _fontSize;
  double get imageHeight => _imageHeight;
  bool get listView => _listView;

  void listViewToggle() {
      _listView=!_listView;
      notifyListeners();
  }

  void downScaleGrid() {
    if (_gridCount == 2) {
      _gridCount = _gridCount + 1;
      _fontSize = 12;
      _imageHeight = 40;
      notifyListeners();
    }
  }

  void upScaleGrid() {
    if (_gridCount == 3) {
      _gridCount = _gridCount - 1;
      _fontSize = 15;
      _imageHeight = 70;
      notifyListeners();
    }
  }




  //добавить устройство пользователю
  void addToUserDevices(Device item, BuildContext context) {
    if(_userDevices.contains(item)){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Уже добавлено"))
        );
      }
    }else{
      _userDevices.add(item);
    }
    notifyListeners();
  }

  //добавить устройство пользователю
  void addUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  //изменить isActive
  void deviceToActive(Device item,bool value) {
    item.isActive = value;
    notifyListeners();
  }

  //e,hfnm устройство пользователю
  void removeFromUserDevices(Device item) {
    item.isActive=false;
    _userDevices.remove(item);
    notifyListeners();
  }

  //логаут
  void logOut() {
    for(var device in _userDevices){
      device.isActive=false;
    }
    _userDevices = [];
    _userName = '';
  }



}
