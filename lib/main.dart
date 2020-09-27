import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
          RequestForm(),
          Container(
            height:
                Provider.of<FormModel>(context).schedule.length * 58.toDouble(),
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
            child: ListView.builder(
              itemCount: Provider.of<FormModel>(context).schedule.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    Provider.of<FormModel>(context).schedule[index].route,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
