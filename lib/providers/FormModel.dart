import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormModel with ChangeNotifier {
  String _fieldSource;
  String _fieldDestination;
  SharedPreferences _preferences;
  static FormModel _instance;

  FormModel.primary();

  factory FormModel() {
    if(_instance == null) _instance = FormModel.primary();
    return _instance;
  }

  String get fieldSource => _fieldSource;

  set fieldSource(String value) {
    _fieldSource = value;
    notifyListeners();
  }

  String get fieldDestination => _fieldDestination;

  set fieldDestination(String value) {
    _fieldDestination = value;
    notifyListeners();
  }
}