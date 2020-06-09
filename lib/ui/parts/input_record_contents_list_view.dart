import 'package:flutter/material.dart';
import 'package:todo_app/entity/record_contents.dart';
import 'package:todo_app/ui/parts/input_record_contents_list_tile.dart';

class InputRecordContentsListView extends StatelessWidget {
  final List<RecordContents> list;
  const InputRecordContentsListView({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Center(child: Text('先に名前を入力してください'));
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final recordContents = list[index];
        return InputRecordContentsListTile(recordContents: recordContents);
      },
      itemCount: list.length,
    );
  }
}
