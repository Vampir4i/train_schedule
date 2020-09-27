class ScheduleModel {
  final String _route;

  String get route => _route;
  final String _sourceArrival;
  final String _destinationArrival;
  final String _travelTime;

  ScheduleModel(
    this._route,
    this._sourceArrival,
    this._destinationArrival,
    this._travelTime,
  );

// factory ScheduleModel(Map<String, String> json) {
//   return ScheduleModel(json, sourceArrival, destinationArrival, travelTime);
// }
}
