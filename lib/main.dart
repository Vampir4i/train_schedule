import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/components/RequestForm.dart';
import 'package:train_schedule/components/TrainsList.dart';
import 'package:train_schedule/providers/FormModel.dart';
import 'package:train_schedule/providers/ThemeModel.dart';
import 'package:train_schedule/providers/TrainsModel.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeModel>(context).currentTheme(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
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
          Container(
            height: 100,
            child: TrainsList(),
          ),
          RequestForm(),
        ],
      ),
    );
  }
}
