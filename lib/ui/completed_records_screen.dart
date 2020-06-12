import 'package:flutter/material.dart';
import 'package:todo_app/ui/parts/record_list_view.dart';

class CompletedTodosScreen extends StatelessWidget {
  const CompletedTodosScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Todos'),
      ),
      body: const RecordListView(),
    );
  }
}
