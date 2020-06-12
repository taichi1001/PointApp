import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/bottom_navigation_model.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/model/record_contents_model.dart';
import 'package:todo_app/model/name_model.dart';
import 'package:todo_app/model/manage_db_model.dart';
import 'package:todo_app/ui/main_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationModel>(
          create: (context) => BottomNavigationModel(),
        ),
        ChangeNotifierProvider<RecordModel>(
          create: (context) => RecordModel(),
        ),
        ChangeNotifierProvider<RecordContentsModel>(
          create: (context) => RecordContentsModel(),
        ),
        ChangeNotifierProvider<NameModel>(
          create: (context) => NameModel(),
        ),
        ChangeNotifierProvider<ManageDBModel>(
          create: (context) => ManageDBModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainBottomNavigation(),
      ),
    );
  }
}
