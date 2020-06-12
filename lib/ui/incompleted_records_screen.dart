import 'package:flutter/material.dart';
import 'package:todo_app/ui/parts/record_list_view.dart';

class IncompletedTodosScreen extends StatelessWidget {
  const IncompletedTodosScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incompleted Todos'),
      ),
      body: const RecordListView(),
    );
  }
}
