import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainsModel with ChangeNotifier {
  List<String> _allTrains = [
    'Донецька\nзалізниця',
    'Львівська\nзалізниця',
    'Одеська\nзалізниця',
    'Південна\nзалізниця',
    'Південно-Західна\nзалізниця',
    'Придніпровська\nзалізниця'
  ];
  int _currentTrain;
  static TrainsModel _instance;
  SharedPreferences _preferences;

  TrainsModel.primary() {
    _readData();
  }

  factory TrainsModel() {
    if(_instance == null) _instance = TrainsModel.primary();
    return _instance;
  }

  changeCurrentTrain(int selectTrain) {
    _currentTrain = selectTrain;
    _writeData();
    notifyListeners();
  }

  int get currentTrain => _currentTrain;

  set currentTrain(int value) {
    _currentTrain = value;
  }

  List<String> get allTrains => _allTrains;

  _readData() async {
    _preferences = await SharedPreferences.getInstance();
    _currentTrain = _preferences.getInt('currentTrain') ?? 0;
    notifyListeners();
  }

  _writeData() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setInt('currentTrain', _currentTrain);
  }
}
