import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/FormModel.dart';

class DatePickerBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FormModel model = Provider.of<FormModel>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Всі дні',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              value: model.showPicker,
              onChanged: (value) => model.changePicker(),
            ),
            Text(
              'На дату',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        model.showPicker
            ? DatePicker(
                DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                locale: 'uk_UA',
                onDateChange: (date) {
                  model.selectedDate = date.toString();
                },
              )
            : Container(),
      ],
    );
  }
}
