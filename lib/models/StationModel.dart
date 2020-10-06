import 'dart:convert';

class StationModel {
  final String _id;
  final String _label;
  final String _info;

  StationModel(this._id, this._label, this._info);

  factory StationModel.fromJson(Map<String, dynamic> json) {
    String info = json['info'] as String;
    if (info.contains('i>')) info = info.split('i>')[1];

    info = info.substring(0, info.length - 2).replaceFirst('область', 'обл.');
    return StationModel(json['id'] as String, json['label'] as String, info);
  }

  static Map<String, dynamic> toMap(StationModel station) =>
      {'id': station.id, 'label': station.label, 'info': station.info};

  static String encodeStations(List<StationModel> stations) =>
      json.encode(stations
          .map<Map<String, dynamic>>((station) => StationModel.toMap(station))
          .toList());

  static List<StationModel> decodeStations(String stations) =>
      (json.decode(stations) as List<dynamic>)
          .map<StationModel>((item) => StationModel.fromJson(item))
          .toList();

  String get id => _id;

  String get label => _label;

  String get info => _info;
}
