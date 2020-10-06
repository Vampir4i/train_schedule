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
        .get('${_url}sid=$source&sid2=$destination&dateR=0')
        .then((response) => response.body);
  }

  static Future<String> getScheduleDate(
      String source, String destination, String date) {
    return http
        .get('${_url}sid=$source&sid2=$destination&dateR=1&startPicker2=$date')
        .then((response) => response.body);
  }

  static List decodeJSON(String response) {
    return json.decode(response).cast<Map<String, dynamic>>();
  }

  static dynamic decodeHTML(String response) {
    return parse(response);
  }

  static List<ScheduleModel> transformToScheduleModel(var document) {
    List<ScheduleModel> schedule = [];
    var table = document.getElementsByClassName('td_center')[0];
    var rows = table.getElementsByTagName('tr');
    if (rows.length == 6 &&
        (rows[4].children[0].text as String) ==
            'Не знайдено маршрутів за вказаними параметрами') return schedule;
    for (int i = 4; i < rows.length; i += 2) {
      schedule.add(
        ScheduleModel(
          rows[i].children[2].text,
          rows[1].children[1].text,
          rows[1].children[2].text,
          rows[i].children[3].text == '–'
              ? rows[i].children[4].text
              : rows[i].children[3].text,
          rows[i].children[5].text,
          rows[i].children[7].text,
        ),
      );
    }
    return schedule;
  }

  static List<StationModel> transformToStationModel(List listResponse) {
    return listResponse
        .map<StationModel>((json) => StationModel.fromJson(json))
        .toList();
  }
}
