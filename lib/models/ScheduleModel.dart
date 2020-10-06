class ScheduleModel {
  final String _source;
  final String _destination;
  final String _sourceArrival;
  final String _destinationArrival;
  final String _travelTime;
  final String _route;

  ScheduleModel(
    this._route,
    this._source,
    this._destination,
    this._sourceArrival,
    this._destinationArrival,
    this._travelTime,
  );

  String get route => _route;

  String get source => _source;

  String get destination => _destination;

  String get sourceArrival => _sourceArrival;

  String get destinationArrival => _destinationArrival;

  String get travelTime => _travelTime;
}
