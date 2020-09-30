import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/components/DatePickerBlock.dart';
import 'package:train_schedule/providers/FormModel.dart';

import 'EnterButton.dart';
import 'InputField.dart';
import 'PossibleStation.dart';

class RequestForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusSource = FocusNode();
  final FocusNode _focusDestination = FocusNode();

  @override
  Widget build(BuildContext context) {
    FormModel model = Provider.of<FormModel>(context);

    _focusSource.addListener(() => model.clearSourceStations());
    _focusDestination.addListener(() => model.clearDestinationStations());

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        // boxShadow: [BoxShadow()],
        color: Theme.of(context).cardColor,
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
              model.sourceStation,
              model.setFieldSource,
              model.clearFieldSource,
              _focusSource,
              nextFocus: _focusDestination,
            ),
            PossibleStation(
              model.sourceStations,
              model.setSourceStation,
            ),
            InputField(
              'Прибуття',
              model.fieldDestination,
              model.destinationStation,
              model.setFieldDestination,
              model.clearFieldDestination,
              _focusDestination,
            ),
            PossibleStation(
              model.destinationStations,
              model.setDestinationStation,
            ),
            DatePickerBlock(),
            EnterButton(),
          ],
        ),
      ),
    );
  }
}
