import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/pages/FavoritePage.dart';
import 'package:train_schedule/pages/HomePage.dart';
import 'package:train_schedule/providers/FavoriteModel.dart';
import 'package:train_schedule/providers/FormModel.dart';
import 'package:train_schedule/providers/ThemeModel.dart';
import 'package:train_schedule/providers/TrainsModel.dart';

/*
TODO
Повысить отказоустойчивость:
  Отловить исключения
 *Добавить экран избранных направлений:
 *Добавить кнопку добавления в избранное
 Добавить плавные анимации появления блоков с информацией
 Тщательнее проработать появление блоков с возможными станциями
 Рефактор верстки
 */

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TrainsModel>(
          create: (context) => TrainsModel(),
        ),
        ChangeNotifierProvider<FormModel>(
          create: (context) => FormModel(),
        ),
        ChangeNotifierProvider<ThemeModel>(
          create: (context) => ThemeModel(),
        ),
        ChangeNotifierProvider<FavoriteModel>(
          create: (context) => FavoriteModel(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeModel>(context).currentTheme(),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/favorites': (BuildContext context) => FavoritePage(),
      },
    );
  }
}


