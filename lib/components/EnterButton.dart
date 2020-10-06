import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/FavoriteModel.dart';
import 'package:train_schedule/providers/FormModel.dart';

class EnterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FormModel formModel = Provider.of<FormModel>(context);
    FavoriteModel favoriteModel = Provider.of<FavoriteModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.autorenew,
          ),
          onPressed: () {
            formModel.swapField();
            favoriteModel.checkContains(
              formModel.sourceStation,
              formModel.destinationStation,
            );
          },
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
          onPressed: () {
            if (Form.of(context).validate()) formModel.getSchedules();
          },
          child: Text(
            'Показати',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            favoriteModel.isFavorite ? Icons.star_outlined : Icons.star_outline,
          ),
          onPressed: () {
            if (formModel.sourceStation != null &&
                formModel.destinationStation != null)
              favoriteModel.changeStatus(
                  formModel.sourceStation, formModel.destinationStation);
          },
        ),
      ],
    );
  }
}
