class ScheduleModel {
  final String _source;
  final String _destination;
  final String _sourceArrival;
  final String _destinationArrival;
  final String _travelTime;

  ScheduleModel(
    this._source,
    this._destination,
    this._sourceArrival,
    this._destinationArrival,
    this._travelTime,
  );

  String get source => _source;

  String get destination => _destination;

  String get sourceArrival => _sourceArrival;

  String get destinationArrival => _destinationArrival;

  String get travelTime => _travelTime;
}
