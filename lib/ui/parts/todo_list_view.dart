import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/ui/parts/todo_list_tile.dart';

class TodoListView extends StatelessWidget {
  final List<Record> list;
  const TodoListView({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(list.isEmpty) {
      return Center(child: Text("No Items"));
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var record = list[index];
        return TodoListTile(record: record);
      },
      itemCount: list.length,
    );
  }
}