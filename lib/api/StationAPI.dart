import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:train_schedule/models/ScheduleModel.dart';
import 'package:train_schedule/models/StationModel.dart';

class StationAPI {
  static final String _url = 'https://swrailway.gov.ua/timetable/eltrain3-6/?';

  static Future<String> getStationCode(String stationName) {
    return http
        .get('${_url}JSON=station&lng=&term=$stationName')
        .then((response) => response.body);
  }

  static Future<String> getSchedule(String source, String destination) {
    return http
        .get('${_url}sid=$source&sid2=$destination&lng=')
        .then((response) => response.body);
  }

  static List decodeJSON(String response) {
    return json.decode(response).cast<Map<String, dynamic>>();
  }

  static List<ScheduleModel> decodeHTML(String response) {
    List<ScheduleModel> schedule = [];
    var document = parse(response);
    var table = document.getElementsByClassName('td_center')[0];
    var rows = table.getElementsByTagName('tr');
    if (rows.length == 4) return schedule;
    for (int i = 4; i < rows.length; i += 2) {
      List children = rows[i].children;
      ScheduleModel model = ScheduleModel(
        children[2].text,
        children[3].text,
        children[5].text,
        children[7].text,
      );
      schedule.add(model);
    }
    return schedule;
  }

  static List<StationModel> transformToStationModel(List listResponse) {
    return listResponse
        .map<StationModel>((json) => StationModel.fromJson(json))
        .toList();
  }
}
