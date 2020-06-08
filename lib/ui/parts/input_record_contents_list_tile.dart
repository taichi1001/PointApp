import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';

class InputRecordContentsListTile extends StatelessWidget {
  final RecordContents recordContents;

  const InputRecordContentsListTile({
    Key key,
    @required this.recordContents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('name'),
        title: Text(recordContents.nameId.toString()),
      ),
    );
  }
}
