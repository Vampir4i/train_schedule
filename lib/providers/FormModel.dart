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

  FormModel.primary();

  factory FormModel() {
    if (_instance == null) _instance = FormModel.primary();
    return _instance;
  }

  String get fieldSource => _fieldSource ?? '';

  setFieldSource(String stationName) {
    if (stationName.length >= 2) _getSourceTrains(stationName);
    if (_destinationStations.isNotEmpty) _destinationStations = [];
    _fieldSource = stationName;
    notifyListeners();
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
    String response =
        await StationAPI.getSchedule('3489', '3740');
        // await StationAPI.getSchedule(sourceStation.id, destinationStation.id);
    _schedule = StationAPI.decodeHTML(response);
    notifyListeners();
  }
}
