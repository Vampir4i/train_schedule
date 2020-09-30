import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/components/RequestForm.dart';
import 'package:train_schedule/components/ScheduleBlock.dart';
import 'package:train_schedule/providers/FormModel.dart';
import 'package:train_schedule/providers/ThemeModel.dart';
import 'package:train_schedule/providers/TrainsModel.dart';

/*
TODO
Повысить отказоустойчивость:
  Отловить исключения
  *Проработать случай, если пришло пустое расписание
Добавить экран избранных направлений:
   Добавить кнопку добавления в избранное
 *Заменить цвета в темной и светлой темах
 Добавить плавные анимации появления блоков с информацией
 Тщательнее проработать появление блоков с возможными станциями
 На будущее:
  Добавить расписание для поездов
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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeModel>(context).currentTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Розклад руху'),
        actions: [
          IconButton(
            icon: ThemeModel().getIcon(),
            onPressed: () =>
                Provider.of<ThemeModel>(context, listen: false).switchTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          RequestForm(),
          ScheduleBlock(),
        ],
      ),
    );
  }
}
