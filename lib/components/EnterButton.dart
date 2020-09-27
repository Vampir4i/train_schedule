import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/FormModel.dart';

class EnterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FormModel model = Provider.of<FormModel>(context);
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      elevation: 5,
      splashColor: Theme.of(context).primaryColorDark,
      animationDuration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      onPressed: () {
        model.getSchedules();
        // if (Form.of(context).validate()) model.getSchedules();
      },
      child: Text(
        'Показати',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
