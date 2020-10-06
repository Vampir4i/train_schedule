import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_schedule/models/StationModel.dart';

class FavoriteModel with ChangeNotifier {
  SharedPreferences _sharedPreferences;
  bool _isFavorite = false;
  List<List<StationModel>> _favorites = [];
  int _countNotes;
  static FavoriteModel _instance;

  FavoriteModel.primary() {
    _readCount();
    _readFavorites();
  }

  factory FavoriteModel() {
    if (_instance == null) _instance = FavoriteModel.primary();
    return _instance;
  }

  bool get isFavorite => _isFavorite;

  List get favorites => _favorites;

  _incrementCount() {
    _countNotes++;
    _writeCount();
  }

  _decrementCount() {
    _countNotes--;
    _writeCount();
  }

  _readCount() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _countNotes = _sharedPreferences.getInt('count') ?? 0;
  }

  _writeCount() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setInt('count', _countNotes);
  }

  _readFavorites() async {
    if (_countNotes == 0) return;
    _sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < _countNotes; i++) {
      String decode = _sharedPreferences.getString('favorite$i');
      _favorites.add(StationModel.decodeStations(decode));
    }
  }

  _writeFavorites() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    for (int i = 0; i < _countNotes; i++) {
      String encode = StationModel.encodeStations(_favorites[i]);
      _sharedPreferences.setString('favorite$i', encode);
    }
  }

  _addFavorite(StationModel source, StationModel destination) {
    _incrementCount();
    _favorites.add([source, destination]);
    _isFavorite = true;
    notifyListeners();
  }

  deleteFavorite(StationModel source, StationModel destination) {
    _decrementCount();
    _favorites = _favorites.where((el) {
      if (el[0].id == source.id && el[1].id == destination.id)
        return false;
      else
        return true;
    }).toList();
    _isFavorite = false;
    notifyListeners();
  }

  checkContains(StationModel source, StationModel destination) {
    bool isFavorite = false;
    _favorites.forEach((el) {
      if (el[0].id == source.id && el[1].id == destination.id)
        isFavorite = true;
    });
    if (_isFavorite != isFavorite) {
      _isFavorite = isFavorite;
      notifyListeners();
    }
  }

  changeStatus(StationModel source, StationModel destination) {
    if (_isFavorite)
      deleteFavorite(source, destination);
    else
      _addFavorite(source, destination);
    _writeFavorites();
  }
}
