import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/providers/FavoriteModel.dart';
import 'package:train_schedule/providers/FormModel.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoriteModel favoriteModel = Provider.of<FavoriteModel>(context);
    FormModel formModel = Provider.of<FormModel>(context);
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Colors.grey[200],
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: favoriteModel.favorites.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                formModel.selectFavorite(
                  favoriteModel.favorites[index][0],
                  favoriteModel.favorites[index][1],
                );
                favoriteModel.checkContains(
                  favoriteModel.favorites[index][0],
                  favoriteModel.favorites[index][1],
                );
                Navigator.pop(context);
              },
              onLongPress: () => favoriteModel.deleteFavorite(
                favoriteModel.favorites[index][0],
                favoriteModel.favorites[index][1],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${favoriteModel.favorites[index][0].label}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${favoriteModel.favorites[index][1].label}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
