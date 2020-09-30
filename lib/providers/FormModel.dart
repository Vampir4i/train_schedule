import 'package:flutter/material.dart';
import 'package:train_schedule/api/StationAPI.dart';
import 'package:train_schedule/models/ScheduleModel.dart';
import 'package:train_schedule/models/StationModel.dart';

class FormModel with ChangeNotifier {
  String _fieldSource;
  String _fieldDestination;
  static FormModel _instance;
  List<StationModel> _sourceStations = [];
  List<StationModel> _destinationStations = [];
  StationModel _sourceStation;
  StationModel _destinationStation;
  List<ScheduleModel> _schedule = [];
  bool _showPicker = false;
  String _selectedDate = '';

  FormModel.primary();

  factory FormModel() {
    if (_instance == null) _instance = FormModel.primary();
    return _instance;
  }

  bool get showPicker => _showPicker;

  set selectedDate(String value) {
    _selectedDate = value.split(' ')[0];
  }

  changePicker() {
    _showPicker = !_showPicker;
    notifyListeners();
  }

  String get fieldSource => _fieldSource ?? '';

  setFieldSource(String stationName) {
    if (stationName.length >= 2) _getSourceTrains(stationName);
    if (_destinationStations.isNotEmpty) _destinationStations = [];
    _fieldSource = stationName;
    notifyListeners();
  }

  clearFieldSource() {
    bool isChange = false;
    if (_fieldSource.isNotEmpty) {
      _fieldSource = '';
      isChange = true;
    }
    if (_sourceStation != null) {
      _sourceStation = null;
      isChange = true;
    }
    if (_sourceStations.isNotEmpty) {
      _sourceStations = [];
      isChange = true;
    }
    if (isChange) notifyListeners();
  }

  clearFieldDestination() {
    bool isChange = false;
    if (_fieldDestination.isNotEmpty) {
      _fieldDestination = '';
      isChange = true;
    }
    if (_destinationStation != null) {
      _destinationStation = null;
      isChange = true;
    }
    if (_destinationStations.isNotEmpty) {
      _destinationStations = [];
      isChange = true;
    }
    if (isChange) notifyListeners();
  }

  String get fieldDestination => _fieldDestination ?? '';

  setFieldDestination(String stationName) {
    if (stationName.length >= 2) _getDestinationTrains(stationName);
    if (_sourceStations.isNotEmpty) _sourceStations = [];
    _fieldDestination = stationName;
    notifyListeners();
  }

  List<StationModel> get sourceStations => _sourceStations;

  List<StationModel> get destinationStations => _destinationStations;

  StationModel get sourceStation => _sourceStation;

  setSourceStation(StationModel station) {
    _sourceStation = station;
    _fieldSource = station.label;
    _sourceStations = [];
    notifyListeners();
  }

  StationModel get destinationStation => _destinationStation;

  setDestinationStation(StationModel station) {
    _destinationStation = station;
    _fieldDestination = station.label;
    _destinationStations = [];
    notifyListeners();
  }

  _getSourceTrains(String stationName) async {
    String response = await StationAPI.getStationCode(stationName);
    List listResponse = StationAPI.decodeJSON(response);
    _sourceStations = StationAPI.transformToStationModel(listResponse);
    notifyListeners();
  }

  _getDestinationTrains(String stationName) async {
    String response = await StationAPI.getStationCode(stationName);
    List listResponse = StationAPI.decodeJSON(response);
    _destinationStations = StationAPI.transformToStationModel(listResponse);
    notifyListeners();
  }

  List<ScheduleModel> get schedule => _schedule;

  getSchedules() async {
    String response;
    if (_showPicker) {
      response = await StationAPI.getScheduleDate(
          sourceStation.id, destinationStation.id, _selectedDate);
    } else
      response =
          await StationAPI.getSchedule(sourceStation.id, destinationStation.id);
    var document = StationAPI.decodeHTML(response);
    _schedule = StationAPI.transformToScheduleModel(document);
    notifyListeners();
  }

  swapField() {
    dynamic tmp = _fieldSource;
    _fieldSource = _fieldDestination;
    _fieldDestination = tmp;
    tmp = _sourceStation;
    _sourceStation = _destinationStation;
    _destinationStation = tmp;
    if (_sourceStations.isNotEmpty) _sourceStations = [];
    if (_destinationStations.isNotEmpty) _destinationStations = [];
    notifyListeners();
  }

  clearSourceStations() {
    if (_sourceStations.isNotEmpty) _sourceStations = [];
    notifyListeners();
  }

  clearDestinationStations() {
    if (_destinationStations.isNotEmpty) _destinationStations = [];
    notifyListeners();
  }
}
