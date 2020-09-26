import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/TrainsModel.dart';

class TrainsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TrainsModel model = Provider.of<TrainsModel>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: model.allTrains.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => model.changeCurrentTrain(index),
          child: ListItem(model, index),
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final TrainsModel _model;
  final int _index;

  ListItem(this._model, this._index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        border: Border.all(
          color: _model.currentTrain == _index
              ? Theme.of(context).primaryColor
              : Colors.grey[200],
          width: _model.currentTrain == _index ? 3 : 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        _model.allTrains[_index],
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
      ),
    );
  }
}
