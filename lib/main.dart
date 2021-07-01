import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:scheduler/DBprovider.dart';
import 'package:scheduler/Splashscreen.dart';

import 'Homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DBprovider(),
        ),
      ],
      builder: (context, child) {
        Provider.of<DBprovider>(context).databaseinit();
        return MaterialApp(
          title: 'Scheduler',
          home: splashscreen(),
        );
      },
    );
  }
}
