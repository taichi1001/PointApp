import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/entity/record.dart';
import 'package:todo_app/model/record_model.dart';
import 'package:todo_app/ui/record_contents_screen.dart';

class RecordListTile extends StatelessWidget {
  final Record record;

  const RecordListTile({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _CheckBoxButton(record: record),
        title: Text(record.title),
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RecordContentsView(
              record: record);
        })),
        trailing: _RemoveButton(record: record),
      ),
    );
  }
}

class _CheckBoxButton extends StatelessWidget {
  final Record record;

  const _CheckBoxButton({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    return FlatButton(
      child: record.isDone
          ? const Icon(Icons.check_box)
          : const Icon(Icons.check_box_outline_blank),
      onPressed: () {
        model.toggleIsDone(record);
      },
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final Record record;

  const _RemoveButton({
    Key key,
    @required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    return FlatButton(
      child: const Icon(Icons.delete_forever),
      onPressed: () {
        model.remove(record);
      },
    );
  }
}
