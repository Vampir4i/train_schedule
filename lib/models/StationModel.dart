class StationModel {
  final String _id;
  final String _label;
  final String _info;

  StationModel(this._id, this._label, this._info);

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
        json['id'] as String,
        json['label'] as String,
        json['info'] as String
    );
  }

  String get id => _id;
  String get label => _label;
  String get info => _info;
}
