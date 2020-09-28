class StationModel {
  final String _id;
  final String _label;
  final String _info;

  StationModel(this._id, this._label, this._info);

  factory StationModel.fromJson(Map<String, dynamic> json) {
    String info = (json['info'] as String).split('i>')[1];
    info = info.substring(0, info.length - 2).replaceFirst('область', 'обл.');
    return StationModel(json['id'] as String, json['label'] as String, info);
  }

  String get id => _id;

  String get label => _label;

  String get info => _info;
}
