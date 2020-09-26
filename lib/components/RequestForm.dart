import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/FormModel.dart';

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
            TextFormField(
              initialValue: model.fieldSource,
              onChanged: (text) => model.fieldSource = text,
              decoration: InputDecoration(
                labelText: 'Відправлення',
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15),
                  borderSide: new BorderSide(),
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              validator: (value) {
                if (value.isEmpty)
                  return 'Поле не повинно бути порожнім';
                else
                  return null;
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextFormField(
              initialValue: model.fieldDestination,
              onChanged: (text) => model.fieldDestination = text,
              decoration: InputDecoration(
                labelText: 'Прибуття',
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15),
                  borderSide: new BorderSide(),
                ),
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              validator: (value) {
                if (value.isEmpty)
                  return 'Поле не повинно бути порожнім';
                else
                  return null;
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            RaisedButton(
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
              onPressed: (){
                if(_formKey.currentState.validate()){}
                  //TODO send request
              },
              child: Text(
                'Показати',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
