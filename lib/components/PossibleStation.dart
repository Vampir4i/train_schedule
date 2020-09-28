import 'package:flutter/material.dart';
import 'package:train_schedule/models/StationModel.dart';

class PossibleStation extends StatelessWidget {
  final List<StationModel> _stations;
  final Function _setStation;

  PossibleStation(this._stations, this._setStation);

  @override
  Widget build(BuildContext context) {
    return _stations.isNotEmpty
        ? Container(
            height: (_stations.length < 4
                ? _stations.length * 58
                : 4 * 58).toDouble(),
            margin: EdgeInsets.symmetric(
              vertical: 5,
            ),
            decoration: BoxDecoration(
              // color: Colors.grey[100],
              border: Border.all(
                color: Colors.grey[200],
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
              itemCount: _stations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => _setStation(_stations[index]),
                  title: Text(
                    _stations[index].label,
                  ),
                );
              },
            ),
          )
        : Padding(
            padding: EdgeInsets.all(10),
          );
  }
}
