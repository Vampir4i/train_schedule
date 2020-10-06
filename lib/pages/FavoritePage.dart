import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/components/FavoriteList.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вибрані напрямки'),
      ),
      body: FavoriteList(),
    );
  }
}