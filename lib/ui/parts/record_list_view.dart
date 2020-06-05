import 'package:flutter/material.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/ui/parts/record_list_tile.dart';

class RecordListView extends StatelessWidget {
  final List<Record> list;
  const RecordListView({
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
        return RecordListTile(record: record);
      },
      itemCount: list.length,
    );
  }
}