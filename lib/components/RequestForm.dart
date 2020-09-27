import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/FormModel.dart';

import 'EnterButton.dart';
import 'InputField.dart';
import 'PossibleStation.dart';

class RequestForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FormModel model = Provider.of<FormModel>(context);

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Colors.grey[100],
        border: Border.all(
          color: Colors.grey[200],
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField(
              'Відправлення',
              model.fieldSource,
              model.setFieldSource,
            ),
            PossibleStation(
              model.sourceStations,
              model.setSourceStation,
            ),
            InputField(
              'Прибуття',
              model.fieldDestination,
              model.setFieldDestination,
            ),
            PossibleStation(
              model.destinationStations,
              model.setDestinationStation,
            ),
            EnterButton(),
          ],
        ),
      ),
    );
  }
}






