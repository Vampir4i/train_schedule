import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_schedule/components/RequestForm.dart';
import 'package:train_schedule/components/ScheduleBlock.dart';
import 'package:train_schedule/providers/ThemeModel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Розклад руху'),
        actions: [
          IconButton(
            icon: Icon(Icons.star_outlined),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
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
