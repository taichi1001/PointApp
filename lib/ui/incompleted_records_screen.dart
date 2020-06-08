import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/ui/parts/record_list_view.dart';

class IncompletedTodosScreen extends StatelessWidget {
  IncompletedTodosScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Incompleted Todos"),
      ),
      body: RecordListView(list: model.incompletedTodoList),
    );
  }
}
